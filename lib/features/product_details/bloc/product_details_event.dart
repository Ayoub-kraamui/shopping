import 'package:equatable/equatable.dart';
import '../../home/data/model/product_model.dart';

abstract class ProductDetailsEvent extends Equatable {
  const ProductDetailsEvent();

  @override
  List<Object> get props => [];
}

class IncrementQuantity extends ProductDetailsEvent {}

class DecrementQuantity extends ProductDetailsEvent {}

class AddToCart extends ProductDetailsEvent {
  final ProductModel product;
  final int quantity;

  const AddToCart(this.product, this.quantity);

  @override
  List<Object> get props => [product, quantity];
}
