import 'package:equatable/equatable.dart';
import '../data/model/product_model.dart';

enum HomeStatus { initial, loading, success, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<ProductModel> products;
  final List<ProductModel> filteredProducts;
  final String? errorMessage;
  final int selectedCategoryIndex;
  final String searchQuery;
  final int bottomNavIndex;

  static const List<String> categories = [
    'الكل',
    'الرجال',
    'النساء',
    'إلكترونيات',
    'مجوهرات',
  ];

  static const List<String> apiCategories = [
    '',
    "men's clothing",
    "women's clothing",
    "electronics",
    "jewelery",
  ];

  const HomeState({
    this.status = HomeStatus.initial,
    this.products = const [],
    this.filteredProducts = const [],
    this.errorMessage,
    this.selectedCategoryIndex = 0,
    this.searchQuery = '',
    this.bottomNavIndex = 0,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<ProductModel>? products,
    List<ProductModel>? filteredProducts,
    String? errorMessage,
    int? selectedCategoryIndex,
    String? searchQuery,
    int? bottomNavIndex,
  }) {
    return HomeState(
      status: status ?? this.status,
      products: products ?? this.products,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedCategoryIndex:
          selectedCategoryIndex ?? this.selectedCategoryIndex,
      searchQuery: searchQuery ?? this.searchQuery,
      bottomNavIndex: bottomNavIndex ?? this.bottomNavIndex,
    );
  }

  @override
  List<Object?> get props => [
    status,
    products,
    filteredProducts,
    errorMessage,
    selectedCategoryIndex,
    searchQuery,
    bottomNavIndex,
  ];
}
