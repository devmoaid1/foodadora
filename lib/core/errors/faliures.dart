import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {} // for remote data

class AuthenticationFailure extends Failure {}

class CacheFailure extends Failure {} // for local data 
