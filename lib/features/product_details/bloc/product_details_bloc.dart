import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repository/product_details.dart';
import 'product_details_event.dart';
import 'product_details_state.dart';

export 'product_details_event.dart';
export 'product_details_state.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  final ProductDetailsRepository _repository;

  ProductDetailsBloc(this._repository) : super(const ProductDetailsState()) {
    on<IncrementQuantity>(_onIncrementQuantity);
    on<DecrementQuantity>(_onDecrementQuantity);
    on<AddToCart>(_onAddToCart);
  }

  void _onIncrementQuantity(
    IncrementQuantity event,
    Emitter<ProductDetailsState> emit,
  ) {
    emit(state.copyWith(quantity: state.quantity + 1));
  }

  void _onDecrementQuantity(
    DecrementQuantity event,
    Emitter<ProductDetailsState> emit,
  ) {
    if (state.quantity > 1) {
      emit(state.copyWith(quantity: state.quantity - 1));
    }
  }

  Future<void> _onAddToCart(
    AddToCart event,
    Emitter<ProductDetailsState> emit,
  ) async {
    emit(state.copyWith(status: ProductDetailsStatus.adding));
    try {
      await _repository.addToCart(event.product.id.toString(), event.quantity);
      emit(state.copyWith(status: ProductDetailsStatus.success));
      // Revert status to initial after success
      emit(state.copyWith(status: ProductDetailsStatus.initial));
    } catch (e) {
      emit(
        state.copyWith(
          status: ProductDetailsStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
