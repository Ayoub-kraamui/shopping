import 'package:equatable/equatable.dart';

enum ProductDetailsStatus { initial, loading, adding, success, error }

class ProductDetailsState extends Equatable {
  final ProductDetailsStatus status;
  final String? errorMessage;
  final int quantity;

  const ProductDetailsState({
    this.status = ProductDetailsStatus.initial,
    this.errorMessage,
    this.quantity = 1,
  });

  ProductDetailsState copyWith({
    ProductDetailsStatus? status,
    String? errorMessage,
    int? quantity,
  }) {
    return ProductDetailsState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage, quantity];
}
