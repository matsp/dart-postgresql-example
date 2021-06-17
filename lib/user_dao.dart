import 'package:dart_postgresql_example/dao.dart';
import 'package:dart_postgresql_example/postgres_database.dart';
import 'package:dart_postgresql_example/user_dto.dart';
import 'package:postgres/postgres.dart';

class UserDao implements Dao<UserDto> {
  final PostgreSQLConnection db;

  UserDao() : db = PostgresDatabase().connection;

  @override
  Future<void> add(UserDto dto) async {
    try {
      await db.query(
        'INSERT INTO auth.users (id, name) VALUES (@id, @name)',
        substitutionValues: {'id': dto.id, 'name': dto.name},
      );
    } catch (e) {
      throw UserCouldNotBeAddedException('id: ${dto.id}');
    }
  }

  @override
  Future<void> delete(UserDto dto) async {
    try {
      await db.query(
        'DELETE FROM auth.users WHERE id=@id',
        substitutionValues: {'id': dto.id},
      );
    } catch (e) {
      throw UserNotFoundException('id: ${dto.id}');
    }
  }

  @override
  Future<UserDto?> getById(String id) async {
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
  Future<void> update(UserDto dto) async {
    try {
      await db.query(
        'UPDATE auth.users SET id=@id, name=@name WHERE id=@id',
        substitutionValues: {'id': dto.id, 'name': dto.name},
      );
    } catch (e) {
      throw UserCouldNotBeUpdatedException('id: ${dto.id}');
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
