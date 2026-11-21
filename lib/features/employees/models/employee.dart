/// Typed employee domain model used by the Employees feature.
class Employee {
  const Employee({
    required this.id,
    required this.name,
    required this.department,
    required this.designation,
    required this.status,
  });

  final String id;
  final String name;
  final String department;
  final String designation;
  final String status;

  factory Employee.fromMap(Map<String, String> data) {
    return Employee(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      department: data['department'] ?? '',
      designation: data['designation'] ?? '',
      status: data['status'] ?? 'Active',
    );
  }

  Map<String, String> toMap() => {
        'id': id,
        'name': name,
        'department': department,
        'designation': designation,
        'status': status,
      };

  /// Validates one form field and returns a message when invalid.
  static String? validateField(String field, String? rawValue) {
    final value = rawValue?.trim() ?? '';
    if (value.isEmpty) {
      switch (field) {
        case 'id': return 'Employee ID is required.';
        case 'name': return 'Name is required.';
        case 'department': return 'Department is required.';
        case 'designation': return 'Designation is required.';
      }
    }
    return null;
  }

  /// Returns field-specific validation errors. Empty means valid.
  Map<String, String> validate() {
    final errors = <String, String>{};
    for (final field in ['id', 'name', 'department', 'designation']) {
      final message = validateField(field, switch (field) {
        'id' => id,
        'name' => name,
        'department' => department,
        _ => designation,
      });
      if (message != null) errors[field] = message;
    }
    if (status != 'Active' && status != 'Inactive') {
      errors['status'] = 'Status must be Active or Inactive.';
    }
    return errors;
  }
}
