import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_management_system/config/common/failure.dart';
import 'package:learn_management_system/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:learn_management_system/features/auth/domain/entity/auth_entity.dart';
import 'package:learn_management_system/features/auth/domain/repository/iAuth_repository.dart';

final authRemoteRepositoryProvider = Provider<AuthRemoteRepository>(
    (ref) => AuthRemoteRepository(ref.watch(authRemoteDataSourceProvider)));

class AuthRemoteRepository implements IauthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  AuthRemoteRepository(this.authRemoteDatasource);
  @override
  Future<Either<Failure, bool>> register(AuthEntity authEntity) async {
    return authRemoteDatasource.register(authEntity);
  }
  
  @override
  Future<Either<Failure, AuthEntity>> login(String userName, String password) async{
    return authRemoteDatasource.login(userName, password);
  }
}
