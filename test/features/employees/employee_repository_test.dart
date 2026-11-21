import 'package:flutter_test/flutter_test.dart';
import 'package:garments_hrms/features/employees/repositories/employee_repository.dart';

void main() {
  group('InMemoryEmployeeRepository', () {
    late InMemoryEmployeeRepository repository;

    setUp(() {
      repository = InMemoryEmployeeRepository();
    });

    test('starts with the three prototype employees', () {
      expect(repository.getAll(), hasLength(3));
    });

    test('adds an employee', () {
      repository.add({
        'id': 'EMP-004',
        'name': 'Test Employee',
        'department': 'Cutting',
        'designation': 'Operator',
        'status': 'Active',
      });

      expect(repository.getAll(), hasLength(4));
      expect(repository.getAll().last['id'], 'EMP-004');
    });

    test('updates an employee by its current ID', () {
      repository.update('EMP-001', {
        'id': 'EMP-010',
        'name': 'Updated Employee',
        'department': 'Sewing',
        'designation': 'Line Chief',
        'status': 'Active',
      });

      expect(repository.getAll().first['id'], 'EMP-010');
      expect(repository.getAll().first['name'], 'Updated Employee');
    });

    test('throws when updating a missing employee', () {
      expect(
        () => repository.update('UNKNOWN', {'id': 'UNKNOWN'}),
        throwsA(isA<StateError>()),
      );
    });

    test('rejects duplicate employee IDs regardless of case', () {
      expect(
        () => repository.add({
          'id': 'emp-001',
          'name': 'Duplicate',
          'department': 'Sewing',
          'designation': 'Operator',
          'status': 'Active',
        }),
        throwsA(isA<StateError>()),
      );
    });

    test('rejects changing an employee to another employee ID', () {
      expect(
        () => repository.update('EMP-001', {
          'id': 'emp-002',
          'name': 'Rahim Ahmed',
          'department': 'Sewing',
          'designation': 'Operator',
          'status': 'Active',
        }),
        throwsA(isA<StateError>()),
      );
    });

    test('deletes an employee by ID', () {
      repository.delete('EMP-002');

      expect(repository.getAll(), hasLength(2));
      expect(
        repository.getAll().any((item) => item['id'] == 'EMP-002'),
        isFalse,
      );
    });

    test('does not expose its internal list for mutation', () {
      final result = repository.getAll();

      expect(() => result.clear(), throwsUnsupportedError);
    });
  });
}
