/// Factory domain model for future multi-factory organizations.
class Factory {
  const Factory({
    required this.id,
    required this.organizationId,
    required this.name,
    required this.code,
    this.location = '',
    this.status = 'Active',
  });

  final String id;
  final String organizationId;
  final String name;
  final String code;
  final String location;
  final String status;

  Map<String, String> toMap() => {
        'id': id,
        'organizationId': organizationId,
        'name': name,
        'code': code,
        'location': location,
        'status': status,
      };

  factory Factory.fromMap(Map<String, String> data) => Factory(
        id: data['id'] ?? '',
        organizationId: data['organizationId'] ?? '',
        name: data['name'] ?? '',
        code: data['code'] ?? '',
        location: data['location'] ?? '',
        status: data['status'] ?? 'Active',
      );

  Map<String, String> validate() {
    final errors = <String, String>{};
    if (id.trim().isEmpty) errors['id'] = 'Factory ID is required.';
    if (organizationId.trim().isEmpty) {
      errors['organizationId'] = 'Organization ID is required.';
    }
    if (name.trim().isEmpty) errors['name'] = 'Factory name is required.';
    if (code.trim().isEmpty) errors['code'] = 'Factory code is required.';
    if (status != 'Active' && status != 'Inactive') {
      errors['status'] = 'Status must be Active or Inactive.';
    }
    return errors;
  }
}
