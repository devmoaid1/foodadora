import 'package:equatable/equatable.dart';
import 'package:foodadora/core/errors/faliures.dart';
import 'package:dartz/dartz.dart';
import 'package:foodadora/core/usecases/use_cases.dart';
import 'package:foodadora/features/orders/data/models/order_model.dart';
import 'package:foodadora/features/orders/domain/repositories/orders_repository.dart';

class GetCustomerOrdersUsecase
    implements UseCase<List<OrderModel>, GetCustomerOrdersParams> {
  final OrdersRepository ordersRepository;

  GetCustomerOrdersUsecase({required this.ordersRepository});
  @override
  Future<Either<Failure, List<OrderModel>>> call(
          GetCustomerOrdersParams params) =>
      ordersRepository.getOrdersForCustomer(customerId: params.customerId);
}

class GetCustomerOrdersParams extends Equatable {
  final String customerId;

  const GetCustomerOrdersParams({required this.customerId});

  @override
  List<Object?> get props => [customerId];
}
