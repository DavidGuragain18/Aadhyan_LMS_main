import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_management_system/config/common/failure.dart';
import 'package:learn_management_system/features/auth/data/repository/auth_remote_repository.dart';
import 'package:learn_management_system/features/auth/domain/entity/auth_entity.dart';

final iauthRepositoryProvider =
    Provider((ref) => ref.read(authRemoteRepositoryProvider));

abstract class IauthRepository {
  Future<Either<Failure, bool>> register(AuthEntity authEntity);
  Future<Either<Failure, AuthEntity>> login(String userName, String password);
}
