import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/features/cart/data/model/cart_item_model.dart';
import 'cart_event.dart';
import 'cart_state.dart';

export 'cart_event.dart';
export 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<CartItemAdded>(_onItemAdded);
    on<CartItemRemoved>(_onItemRemoved);
    on<CartItemIncremented>(_onItemIncremented);
    on<CartItemDecremented>(_onItemDecremented);
    on<CartCleared>(_onCartCleared);
  }

  void _onItemAdded(CartItemAdded event, Emitter<CartState> emit) {
    final currentItems = List<CartItemModel>.from(state.items);
    final existingIndex = currentItems.indexWhere(
      (item) => item.product.id == event.product.id,
    );

    if (existingIndex != -1) {
      final existing = currentItems[existingIndex];
      currentItems[existingIndex] = existing.copyWith(
        quantity: existing.quantity + event.quantity,
      );
    } else {
      currentItems.add(
        CartItemModel(product: event.product, quantity: event.quantity),
      );
    }

    emit(state.copyWith(items: currentItems));
  }

  void _onItemRemoved(CartItemRemoved event, Emitter<CartState> emit) {
    final updatedItems = state.items
        .where((item) => item.product.id != event.item.product.id)
        .toList();
    emit(state.copyWith(items: updatedItems));
  }

  void _onItemIncremented(CartItemIncremented event, Emitter<CartState> emit) {
    final updatedItems = state.items.map((item) {
      if (item.product.id == event.item.product.id) {
        return item.copyWith(quantity: item.quantity + 1);
      }
      return item;
    }).toList();
    emit(state.copyWith(items: updatedItems));
  }

  void _onItemDecremented(CartItemDecremented event, Emitter<CartState> emit) {
    final updatedItems = state.items.map((item) {
      if (item.product.id == event.item.product.id && item.quantity > 1) {
        return item.copyWith(quantity: item.quantity - 1);
      }
      return item;
    }).toList();
    emit(state.copyWith(items: updatedItems));
  }

  void _onCartCleared(CartCleared event, Emitter<CartState> emit) {
    emit(const CartState(items: []));
  }
}
