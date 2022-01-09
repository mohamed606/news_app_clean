import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app_clean/core/error/failures.dart';

abstract class UseCase<Type, Param> {
  Future<Either<Failure, Type>> call (Param param);
}
class NoParams extends Equatable{
  @override
  List<Object?> get props => [];
}