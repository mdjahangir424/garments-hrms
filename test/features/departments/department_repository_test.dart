import 'package:flutter_test/flutter_test.dart';
import 'package:garments_hrms/features/departments/models/department.dart';
import 'package:garments_hrms/features/departments/repositories/department_repository.dart';

void main() {
  group('InMemoryDepartmentRepository', () {
    late InMemoryDepartmentRepository repository;

    Department department(String id, String code, {String factoryId = 'F-1'}) =>
        Department(
          id: id,
          organizationId: 'ORG-1',
          factoryId: factoryId,
          name: 'Department $id',
          code: code,
        );

    setUp(() => repository = InMemoryDepartmentRepository());

    test('filters departments by organization and factory', () {
      repository.add(department('D-1', 'SEW'));
      repository.add(department('D-2', 'QLT', factoryId: 'F-2'));
      expect(
        repository.getByFactory('ORG-1', 'F-1').map((e) => e.id),
        ['D-1'],
      );
    });

    test('rejects duplicate codes in the same factory', () {
      repository.add(department('D-1', 'SEW'));
      expect(
        () => repository.add(department('D-2', 'sew')),
        throwsA(isA<StateError>()),
      );
    });

    test('allows same code in another factory', () {
      repository.add(department('D-1', 'SEW'));
      repository.add(department('D-2', 'SEW', factoryId: 'F-2'));
      expect(repository.getByFactory('ORG-1', 'F-2'), hasLength(1));
    });

    test('rejects a department without a factory ID', () {
      expect(
        () => repository.add(
          const Department(
            id: 'D-1',
            organizationId: 'ORG-1',
            factoryId: '',
            name: 'Sewing',
            code: 'SEW',
          ),
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('deletes only from the specified factory', () {
      repository.add(department('D-1', 'SEW'));
      repository.add(department('D-2', 'SEW', factoryId: 'F-2'));
      repository.delete('ORG-1', 'F-1', 'D-1');
      expect(repository.getByFactory('ORG-1', 'F-1'), isEmpty);
      expect(repository.getByFactory('ORG-1', 'F-2'), hasLength(1));
    });
  });
}
