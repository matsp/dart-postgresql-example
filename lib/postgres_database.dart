import 'package:postgres/postgres.dart';

class PostgresDatabase {
  late PostgreSQLConnection connection;

  PostgresDatabase() {
    connection = PostgreSQLConnection(
      '127.0.0.1',
      5432,
      'app',
      username: 'app',
      password: 'password',
    );

  }

  Future<void> connect() async {
    try {
      await connection.open();
    } catch (e) {
      print(e);
    }
  }

  Future<void> disconnect() async {
    try {
      await connection.close();
    } catch (e) {
      print(e);
    }
  }
}
