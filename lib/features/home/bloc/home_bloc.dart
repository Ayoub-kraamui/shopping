import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repository/home_repository.dart';
import '../data/model/product_model.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _homeRepository;

  HomeBloc({required HomeRepository homeRepository})
    : _homeRepository = homeRepository,
      super(const HomeState()) {
    on<FetchProducts>(_onFetchProducts);
    on<HomeCategorySelected>(_onCategorySelected);
    on<HomeSearchQueryChanged>(_onSearchQueryChanged);
    on<HomeBottomNavIndexChanged>(_onBottomNavIndexChanged);
  }

  Future<void> _onFetchProducts(
    FetchProducts event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final products = await _homeRepository.getProducts();
      emit(
        state.copyWith(
          status: HomeStatus.success,
          products: products,
          filteredProducts: _filterProducts(
            products: products,
            categoryIndex: state.selectedCategoryIndex,
            query: state.searchQuery,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: HomeStatus.error, errorMessage: e.toString()),
      );
    }
  }

  void _onCategorySelected(
    HomeCategorySelected event,
    Emitter<HomeState> emit,
  ) {
    if (state.selectedCategoryIndex == event.index) return;

    emit(
      state.copyWith(
        selectedCategoryIndex: event.index,
        filteredProducts: _filterProducts(
          products: state.products,
          categoryIndex: event.index,
          query: state.searchQuery,
        ),
      ),
    );
  }

  void _onSearchQueryChanged(
    HomeSearchQueryChanged event,
    Emitter<HomeState> emit,
  ) {
    emit(
      state.copyWith(
        searchQuery: event.query,
        filteredProducts: _filterProducts(
          products: state.products,
          categoryIndex: state.selectedCategoryIndex,
          query: event.query,
        ),
      ),
    );
  }

  void _onBottomNavIndexChanged(
    HomeBottomNavIndexChanged event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(bottomNavIndex: event.index));
  }

  List<ProductModel> _filterProducts({
    required List<ProductModel> products,
    required int categoryIndex,
    required String query,
  }) {
    List<ProductModel> filtered = categoryIndex == 0
        ? products
        : products
              .where(
                (p) => p.category == HomeState.apiCategories[categoryIndex],
              )
              .toList();

    if (query.isNotEmpty) {
      filtered = filtered
          .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    return filtered;
  }
}
