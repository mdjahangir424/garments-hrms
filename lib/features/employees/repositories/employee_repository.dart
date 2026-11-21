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
  final List<Map<String, String>> _employees = [
    {
      'id': 'EMP-001',
      'name': 'Rahim Ahmed',
      'department': 'Sewing',
      'designation': 'Operator',
      'status': 'Active',
    },
    {
      'id': 'EMP-002',
      'name': 'Nusrat Jahan',
      'department': 'Quality',
      'designation': 'Quality Inspector',
      'status': 'Active',
    },
    {
      'id': 'EMP-003',
      'name': 'Karim Uddin',
      'department': 'Finishing',
      'designation': 'Supervisor',
      'status': 'Inactive',
    },
  ];

  @override
  List<Map<String, String>> getAll() =>
      List<Map<String, String>>.unmodifiable(_employees);

  @override
  void add(Map<String, String> employee) {
    _employees.add(Map<String, String>.from(employee));
  }

  @override
  void update(String currentId, Map<String, String> employee) {
    final index = _employees.indexWhere((item) => item['id'] == currentId);
    if (index == -1) {
      throw StateError('Employee not found: $currentId');
    }
    _employees[index] = Map<String, String>.from(employee);
  }

  @override
  void delete(String id) {
    _employees.removeWhere((employee) => employee['id'] == id);
  }
}
