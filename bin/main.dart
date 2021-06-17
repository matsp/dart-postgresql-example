import 'package:dart_postgresql_example/postgres_database.dart';
import 'package:dart_postgresql_example/user_dto.dart';
import 'package:dart_postgresql_example/user_repository.dart';
import 'package:uuid/uuid.dart';

Future<void> main(List<String> arguments) async {
  final userRepo = UserRepository();

  try {
    await PostgresDatabase().connection.open();
    final user = await userRepo.getById('be06b5af-152f-4abb-a010-cdfee2eae9c0');
    // print('User - id: ${user?.id}, name: ${user?.name}');

    final newUser = UserDto(id: Uuid().v4(), name: 'Maria Doe');
    await userRepo.add(newUser);

    final lisbeth = UserDto(id: newUser.id, name: 'Lisbeth Doe');
    await userRepo.update(lisbeth);

    await PostgresDatabase().connection.close();
  } catch (e) {
    print(e);
  }
}
