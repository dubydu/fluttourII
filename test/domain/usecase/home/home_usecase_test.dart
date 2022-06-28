import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttour/data/api/api_client/error/error.dart';
import 'package:fluttour/data/api/response/fluttour_response.dart';
import 'package:fluttour/data/repository/home/home_repository.dart';
import 'package:fluttour/domain/model/fluttour.dart';
import 'package:fluttour/domain/translator/home_translator.dart';
import 'package:fluttour/domain/usecase/home/home_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../mock/home_responses_mock.dart';
import 'home_usecase_test.mocks.dart';

class MockHomeRepository extends Mock implements HomeRepository { }

@GenerateMocks(<Type>[MockHomeRepository])
void main() {
  late MockMockHomeRepository mockHomeRepository;
  late FluttourResponse fluttourResponse;
  setUp(() {
    mockHomeRepository = MockMockHomeRepository();
    fluttourResponse = HomeResponsesMock.fluttourResponse;
  });
  group('HomeUseCase', () {
    test('getFluttourDoctor should return a FluttourDoctor response', () async {
      when(
          mockHomeRepository
              .getFluttourDoctor())
          .thenAnswer((_) async => right(fluttourResponse)
      );
      final HomeUseCase homeUseCase = HomeUseCase(repository: mockHomeRepository);
      final Either<Failure, Fluttour> response = await homeUseCase.getFluttourDoctor();
      expect(HomeTranslator.toModel(response: fluttourResponse), response.toOption().toNullable());
    });

    test('getFluttourDoctor should return a Failure', () async {
      when(
          mockHomeRepository
              .getFluttourDoctor())
          .thenAnswer((_) async => left(const NoAuthenticationFailure())
      );
      final HomeUseCase homeUseCase = HomeUseCase(repository: mockHomeRepository);
      final Either<Failure, Fluttour> response = await homeUseCase.getFluttourDoctor();
      expect(response.isLeft(), isTrue);
    });
  });
}