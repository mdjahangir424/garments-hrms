import 'package:flutter_test/flutter_test.dart';
import 'package:garments_hrms/features/employees/models/employee.dart';

void main() {
  group('Employee model', () {
    test('converts map data to model and back without losing fields', () {
      final source = {
        'id': 'EMP-001',
        'name': 'Rahim Ahmed',
        'department': 'Sewing',
        'designation': 'Operator',
        'status': 'Active',
      };

      expect(Employee.fromMap(source).toMap(), source);
    });

    test('reports missing required fields', () {
      final errors = const Employee(
        id: ' ',
        name: '',
        department: '',
        designation: '',
        status: 'Active',
      ).validate();

      expect(errors.keys, containsAll(['id', 'name', 'department', 'designation']));
    });

    test('rejects an unsupported status', () {
      final errors = const Employee(
        id: 'EMP-001',
        name: 'Test',
        department: 'Sewing',
        designation: 'Operator',
        status: 'Pending',
      ).validate();

      expect(errors['status'], isNotNull);
    });

    test('accepts a complete employee record', () {
      final errors = const Employee(
        id: 'EMP-001',
        name: 'Rahim Ahmed',
        department: 'Sewing',
        designation: 'Operator',
        status: 'Active',
      ).validate();

      expect(errors, isEmpty);
    });
  });
}
