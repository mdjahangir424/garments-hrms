import '../models/employee.dart';

/// Data access contract for employee records.
///
/// The current implementation is in-memory demo storage. A Firebase-backed
/// implementation can be added later without changing the Employees UI.
abstract class EmployeeRepository {
  List<Map<String, String>> getAll();

  void add(Map<String, String> employee);

  void update(String currentId, Map<String, String> employee);

  void delete(String id);
}

/// Temporary repository used by the prototype. Data resets when the app
/// restarts; no real employee records are stored.
class InMemoryEmployeeRepository implements EmployeeRepository {
  final List<Employee> _employees = [
    const Employee(
      id: 'EMP-001',
      name: 'Rahim Ahmed',
      department: 'Sewing',
      designation: 'Operator',
      status: 'Active',
    ),
    const Employee(
      id: 'EMP-002',
      name: 'Nusrat Jahan',
      department: 'Quality',
      designation: 'Quality Inspector',
      status: 'Active',
    ),
    const Employee(
      id: 'EMP-003',
      name: 'Karim Uddin',
      department: 'Finishing',
      designation: 'Supervisor',
      status: 'Inactive',
    ),
  ];

  @override
  List<Map<String, String>> getAll() =>
      _employees.map((employee) => employee.toMap()).toList(growable: false);

  @override
  void add(Map<String, String> employee) {
    _employees.add(Employee.fromMap(employee));
  }

  @override
  void update(String currentId, Map<String, String> employee) {
    final index = _employees.indexWhere((item) => item.id == currentId);
    if (index == -1) {
      throw StateError('Employee not found: $currentId');
    }
    _employees[index] = Employee.fromMap(employee);
  }

  @override
  void delete(String id) {
    _employees.removeWhere((employee) => employee.id == id);
  }
}
