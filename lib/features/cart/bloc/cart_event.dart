import 'package:equatable/equatable.dart';
import 'package:shopping/features/cart/data/model/cart_item_model.dart';
import 'package:shopping/features/home/data/model/product_model.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class CartItemAdded extends CartEvent {
  final ProductModel product;
  final int quantity;

  const CartItemAdded(this.product, {this.quantity = 1});

  @override
  List<Object?> get props => [product, quantity];
}

class CartItemRemoved extends CartEvent {
  final CartItemModel item;

  const CartItemRemoved(this.item);

  @override
  List<Object?> get props => [item];
}

class CartItemIncremented extends CartEvent {
  final CartItemModel item;

  const CartItemIncremented(this.item);

  @override
  List<Object?> get props => [item];
}

class CartItemDecremented extends CartEvent {
  final CartItemModel item;

  const CartItemDecremented(this.item);

  @override
  List<Object?> get props => [item];
}

class CartCleared extends CartEvent {
  const CartCleared();
}
