import 'package:postgres/postgres.dart';

class PostgresDatabase {
  final PostgreSQLConnection connection = PostgreSQLConnection(
    '127.0.0.1',
    5432,
    'app',
    username: 'app',
    password: 'password',
  );

  static final PostgresDatabase _instance = PostgresDatabase._singelton();

  PostgresDatabase._singelton();

  factory PostgresDatabase() {
    return _instance;
  }
}
