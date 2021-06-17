import 'dart:async';

import 'package:dart_postgresql_example/repository.dart';
import 'package:dart_postgresql_example/user_dao.dart';
import 'package:dart_postgresql_example/user_dto.dart';

class UserRepository implements Repository<UserDto> {

  @override
  Future<UserDto?> getById(String id) => UserDao().getById(id);

  @override
  Future<void> delete(UserDto dto) => UserDao().delete(dto);

  @override
  Future<void> add(UserDto dto) => UserDao().add(dto);

  @override
  Future<void> update(UserDto dto) => UserDao().update(dto);

}

