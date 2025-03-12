import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_management_system/config/common/failure.dart';
import 'package:learn_management_system/features/auth/domain/entity/auth_entity.dart';
import 'package:learn_management_system/features/auth/domain/repository/iAuth_repository.dart';

final loginUseCaseProvider = Provider.autoDispose<LoginUseCase>(
    (ref) => LoginUseCase(ref.watch(iauthRepositoryProvider)));

class LoginUseCase {
  final IauthRepository iauthRepository;
  LoginUseCase(this.iauthRepository);

  Future<Either<Failure, AuthEntity>> login(
      String userName, String password) async {
    return await iauthRepository.login(userName, password);
  }
}
