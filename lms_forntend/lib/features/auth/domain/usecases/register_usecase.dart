import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_management_system/config/common/failure.dart';
import 'package:learn_management_system/features/auth/domain/entity/auth_entity.dart';
import 'package:learn_management_system/features/auth/domain/repository/iAuth_repository.dart';

final registerUsecaseProvider =
    Provider.autoDispose<RegisterUsecase>((ref) => RegisterUsecase(ref.read(iauthRepositoryProvider)));

class RegisterUsecase {
  final IauthRepository iauthRepository;
  RegisterUsecase(this.iauthRepository);

  Future<Either<Failure, bool>> register(AuthEntity authEntity) {
    return iauthRepository.register(authEntity);
  }
}
