import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/home_bloc.dart';
import '../../bloc/home_event.dart';
import '../../bloc/home_state.dart';
import 'home_header.dart';
import 'home_categories.dart';
import 'home_latest_products_header.dart';
import 'home_product_grid.dart';

class HomeMainView extends StatefulWidget {
  const HomeMainView({super.key});

  @override
  State<HomeMainView> createState() => _HomeMainViewState();
}

class _HomeMainViewState extends State<HomeMainView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(FetchProducts());
    _searchController.addListener(() {
      context.read<HomeBloc>().add(
        HomeSearchQueryChanged(_searchController.text),
      );
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ─── Header + Search ──────────────────────────────────────────
        BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (previous, current) =>
              previous.searchQuery != current.searchQuery,
          builder: (context, state) {
            if (_searchController.text != state.searchQuery) {
              _searchController.text = state.searchQuery;
            }
            return HomeHeaderWidget(
              searchController: _searchController,
              searchQuery: state.searchQuery,
              onClearSearch: () => _searchController.clear(),
            );
          },
        ),

        // ─── Categories ───────────────────────────────────────────────
        const HomeCategoriesWidget(),

        // ─── Latest Products Header ────────────────────────────────────
        const HomeLatestProductsHeader(),

        // ─── Product Grid ─────────────────────────────────────────────
        const Expanded(child: HomeProductGridWidget()),
      ],
    );
  }
}
