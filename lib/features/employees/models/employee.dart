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

  /// Returns field-specific validation errors. Empty means valid.
  Map<String, String> validate() {
    final errors = <String, String>{};
    if (id.trim().isEmpty) errors['id'] = 'Employee ID is required.';
    if (name.trim().isEmpty) errors['name'] = 'Name is required.';
    if (department.trim().isEmpty) {
      errors['department'] = 'Department is required.';
    }
    if (designation.trim().isEmpty) {
      errors['designation'] = 'Designation is required.';
    }
    if (status != 'Active' && status != 'Inactive') {
      errors['status'] = 'Status must be Active or Inactive.';
    }
    return errors;
  }
}
