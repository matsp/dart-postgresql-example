import 'dart:async';

import 'package:dart_postgresql_example/repository.dart';
import 'package:dart_postgresql_example/user_dto.dart';
import 'package:postgres/postgres.dart';

class UserRepository implements Repository<UserDto> {
  final PostgreSQLConnection db;

  UserRepository(this.db);

  @override
  Future<UserDto?> get(String id) async {
    UserDto? user;

    try {
      final result = await db.mappedResultsQuery(
        'SELECT * FROM auth.users WHERE id=@id',
        substitutionValues: {
          'id': id,
        },
      );

      user = UserDto(
        id: result[0]['users']?['id'],
        name: result[0]['users']?['name'],
      );
    } catch (e) {
      throw UserNotFoundException('id: $id');
    }

    return user;
  }

  @override
  Future<void> delete(String id) async {
    try {
      await db.query(
        'DELETE FROM auth.users WHERE id=@id',
        substitutionValues: {'id': id},
      );
    } catch (e) {
      throw UserNotFoundException('id: $id');
    }
  }

  @override
  Future<void> add(UserDto user) async {
    try {
      await db.query(
        'INSERT INTO auth.users (id, name) VALUES (@id, @name)',
        substitutionValues: {'id': user.id, 'name': user.name},
      );
    } catch (e) {
      throw UserCouldNotBeAddedException('id: ${user.id}');
    }
  }

  @override
  Future<void> update(UserDto user) async {
    try {
      await db.query(
        'UPDATE auth.users SET id=@id, name=@name WHERE id=@id',
        substitutionValues: {'id': user.id, 'name': user.name},
      );
    } catch (e) {
      throw UserCouldNotBeUpdatedException('id: ${user.id}');
    }
  }
}

class UserNotFoundException implements Exception {
  String message;

  UserNotFoundException(this.message);

  @override
  String toString() => 'UserNotFoundException | $message';
}

class UserCouldNotBeAddedException implements Exception {
  String message;

  UserCouldNotBeAddedException(this.message);

  @override
  String toString() => 'UserCouldNotBeAddedException | $message';
}

class UserCouldNotBeUpdatedException implements Exception {
  String message;

  UserCouldNotBeUpdatedException(this.message);

  @override
  String toString() => 'UserCouldNotBeUpdateException | $message';
}
