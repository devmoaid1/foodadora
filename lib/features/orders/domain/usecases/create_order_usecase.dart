import 'package:equatable/equatable.dart';
import 'package:foodadora/core/errors/faliures.dart';
import 'package:dartz/dartz.dart';
import 'package:foodadora/core/usecases/use_cases.dart';
import 'package:foodadora/features/orders/data/models/order_model.dart';
import 'package:foodadora/features/orders/domain/repositories/orders_repository.dart';

class CreateOrderUseCase implements UseCase<void, CreateOrderParams> {
  final OrdersRepository ordersRepository;

  CreateOrderUseCase({required this.ordersRepository});
  @override
  Future<Either<Failure, void>> call(CreateOrderParams params) =>
      ordersRepository.createOrder(order: params.order);
}

class CreateOrderParams extends Equatable {
  final OrderModel order;

  const CreateOrderParams({required this.order});
  @override
  List<Object?> get props => [];
}
