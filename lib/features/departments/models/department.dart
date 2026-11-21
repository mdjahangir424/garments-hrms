/// Department domain model, scoped to an organization and factory.
class Department {
  const Department({
    required this.id,
    required this.organizationId,
    required this.factoryId,
    required this.name,
    required this.code,
    this.status = 'Active',
  });

  final String id;
  final String organizationId;
  final String factoryId;
  final String name;
  final String code;
  final String status;

  Map<String, String> toMap() => {
        'id': id,
        'organizationId': organizationId,
        'factoryId': factoryId,
        'name': name,
        'code': code,
        'status': status,
      };

  factory Department.fromMap(Map<String, String> data) => Department(
        id: data['id'] ?? '',
        organizationId: data['organizationId'] ?? '',
        factoryId: data['factoryId'] ?? '',
        name: data['name'] ?? '',
        code: data['code'] ?? '',
        status: data['status'] ?? 'Active',
      );

  Map<String, String> validate() {
    final errors = <String, String>{};
    if (id.trim().isEmpty) errors['id'] = 'Department ID is required.';
    if (organizationId.trim().isEmpty) {
      errors['organizationId'] = 'Organization ID is required.';
    }
    if (factoryId.trim().isEmpty) {
      errors['factoryId'] = 'Factory ID is required.';
    }
    if (name.trim().isEmpty) errors['name'] = 'Department name is required.';
    if (code.trim().isEmpty) errors['code'] = 'Department code is required.';
    if (status != 'Active' && status != 'Inactive') {
      errors['status'] = 'Status must be Active or Inactive.';
    }
    return errors;
  }
}
