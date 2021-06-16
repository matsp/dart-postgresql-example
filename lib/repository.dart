abstract class Repository<T> {
  Future<T?> get(String id);
  Future<void> delete(String id);
  Future<void> add(T user);
  Future<void> update(T user);
}
