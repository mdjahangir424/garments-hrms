import 'package:flutter_test/flutter_test.dart';
import 'package:garments_hrms/features/factories/models/factory.dart';
import 'package:garments_hrms/features/factories/repositories/factory_repository.dart';

void main() {
  group('InMemoryFactoryRepository', () {
    late InMemoryFactoryRepository repository;

    Factory factory(String id, String organizationId, String code) => Factory(
          id: id,
          organizationId: organizationId,
          name: 'Factory $id',
          code: code,
        );

    setUp(() => repository = InMemoryFactoryRepository());

    test('filters factories by organization', () {
      repository.add(factory('F-1', 'ORG-1', 'DHK'));
      repository.add(factory('F-2', 'ORG-2', 'DHK'));
      expect(repository.getByOrganization('ORG-1').map((e) => e.id), ['F-1']);
    });

    test('rejects duplicate codes within the same organization', () {
      repository.add(factory('F-1', 'ORG-1', 'DHK'));
      expect(
        () => repository.add(factory('F-2', 'ORG-1', 'dhk')),
        throwsA(isA<StateError>()),
      );
    });

    test('allows same code in a different organization', () {
      repository.add(factory('F-1', 'ORG-1', 'DHK'));
      repository.add(factory('F-2', 'ORG-2', 'DHK'));
      expect(repository.getByOrganization('ORG-2'), hasLength(1));
    });

    test('rejects invalid factory data', () {
      expect(
        () => repository.add(factory('F-1', '', 'DHK')),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('deletes only within the requested organization', () {
      repository.add(factory('F-1', 'ORG-1', 'DHK'));
      repository.add(factory('F-1', 'ORG-2', 'DHK'));
      repository.delete('ORG-1', 'F-1');
      expect(repository.getByOrganization('ORG-1'), isEmpty);
      expect(repository.getByOrganization('ORG-2'), hasLength(1));
    });
  });
}
