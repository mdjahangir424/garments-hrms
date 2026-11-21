import '../models/factory.dart';

/// Data access contract for organization-scoped factories.
abstract class FactoryRepository {
  List<Factory> getByOrganization(String organizationId);
  void add(Factory factory);
  void update(Factory factory);
  void delete(String organizationId, String factoryId);
}

/// In-memory foundation only. Replace with a secured backend repository later.
class InMemoryFactoryRepository implements FactoryRepository {
  final List<Factory> _factories = [];

  @override
  List<Factory> getByOrganization(String organizationId) =>
      List<Factory>.unmodifiable(
        _factories.where((item) => item.organizationId == organizationId),
      );

  @override
  void add(Factory factory) {
    _validate(factory);
    _ensureUniqueCode(factory);
    if (_factories.any((item) =>
        item.organizationId == factory.organizationId &&
        item.id == factory.id)) {
      throw StateError('Factory ID already exists: ${factory.id}');
    }
    _factories.add(factory);
  }

  @override
  void update(Factory factory) {
    _validate(factory);
    final index = _factories.indexWhere(
      (item) => item.id == factory.id &&
          item.organizationId == factory.organizationId,
    );
    if (index == -1) {
      throw StateError('Factory not found: ${factory.id}');
    }
    _ensureUniqueCode(factory, exceptIndex: index);
    _factories[index] = factory;
  }

  @override
  void delete(String organizationId, String factoryId) {
    _factories.removeWhere(
      (item) => item.organizationId == organizationId && item.id == factoryId,
    );
  }

  void _validate(Factory factory) {
    final errors = factory.validate();
    if (errors.isNotEmpty) {
      throw ArgumentError('Invalid factory: ${errors.values.join(' ')}');
    }
  }

  void _ensureUniqueCode(Factory factory, {int? exceptIndex}) {
    final code = factory.code.trim().toLowerCase();
    final index = _factories.indexWhere(
      (item) => item.organizationId == factory.organizationId &&
          item.code.trim().toLowerCase() == code,
    );
    if (index != -1 && index != exceptIndex) {
      throw StateError('Factory code already exists: ${factory.code}');
    }
  }
}
