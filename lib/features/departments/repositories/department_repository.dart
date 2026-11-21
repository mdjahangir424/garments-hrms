import '../models/department.dart';

/// Data access contract for factory-scoped departments.
abstract class DepartmentRepository {
  List<Department> getByFactory(String organizationId, String factoryId);
  void add(Department department);
  void update(Department department);
  void delete(String organizationId, String factoryId, String departmentId);
}

/// In-memory foundation only. Replace with a secured backend repository later.
class InMemoryDepartmentRepository implements DepartmentRepository {
  final List<Department> _departments = [];

  @override
  List<Department> getByFactory(String organizationId, String factoryId) =>
      List<Department>.unmodifiable(
        _departments.where(
          (item) =>
              item.organizationId == organizationId &&
              item.factoryId == factoryId,
        ),
      );

  @override
  void add(Department department) {
    _validate(department);
    _ensureUniqueCode(department);
    if (_departments.any((item) =>
        item.organizationId == department.organizationId &&
        item.factoryId == department.factoryId &&
        item.id == department.id)) {
      throw StateError('Department ID already exists: ${department.id}');
    }
    _departments.add(department);
  }

  @override
  void update(Department department) {
    _validate(department);
    final index = _departments.indexWhere(
      (item) =>
          item.id == department.id &&
          item.organizationId == department.organizationId &&
          item.factoryId == department.factoryId,
    );
    if (index == -1) {
      throw StateError('Department not found: ${department.id}');
    }
    _ensureUniqueCode(department, exceptIndex: index);
    _departments[index] = department;
  }

  @override
  void delete(String organizationId, String factoryId, String departmentId) {
    _departments.removeWhere(
      (item) =>
          item.organizationId == organizationId &&
          item.factoryId == factoryId &&
          item.id == departmentId,
    );
  }

  void _validate(Department department) {
    final errors = department.validate();
    if (errors.isNotEmpty) {
      throw ArgumentError('Invalid department: ${errors.values.join(' ')}');
    }
  }

  void _ensureUniqueCode(Department department, {int? exceptIndex}) {
    final code = department.code.trim().toLowerCase();
    final index = _departments.indexWhere(
      (item) =>
          item.organizationId == department.organizationId &&
          item.factoryId == department.factoryId &&
          item.code.trim().toLowerCase() == code,
    );
    if (index != -1 && index != exceptIndex) {
      throw StateError('Department code already exists: ${department.code}');
    }
  }
}
