abstract class Repository<T> {
  Future<void> add(T user);
  Future<T?> getById(String id);
  Future<void> update(T user);
  Future<void> delete(T user);
}
