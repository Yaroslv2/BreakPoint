part of 'home_bloc.dart';

class HomeState extends Equatable {
  final bool isRefreshing;
  List<Product> productList;
  final homeState? homestate;
  final String? errorMessage;

  HomeState({
    required this.isRefreshing,
    required this.productList,
    this.homestate,
    this.errorMessage,
  });

  factory HomeState.initial() =>
      HomeState(isRefreshing: false, productList: []);

  HomeState copyWith({
    bool? isRefreshing,
    List<Product>? productList,
    homeState? homestate,
    String? errorMessage,
  }) =>
      HomeState(
        isRefreshing: isRefreshing ?? this.isRefreshing,
        productList: productList ?? this.productList,
        homestate: homestate ?? this.homestate,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object?> get props => [
        isRefreshing,
        productList,
        homestate,
      ];
}

enum homeState {
  ok,
  loading,
  failureLoadiing,
  emptySearch,
  okSearch,
  loadingSearch
}
