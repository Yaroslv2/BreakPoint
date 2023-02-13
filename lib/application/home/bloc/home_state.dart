part of 'home_bloc.dart';

class HomeState extends Equatable {
  final bool isRefreshing;
  final List<Product> productList;
  final homeState? homestate;

  const HomeState({
    required this.isRefreshing,
    required this.productList,
    this.homestate,
  });

  factory HomeState.initial() =>
      const HomeState(isRefreshing: false, productList: []);

  HomeState copyWith({
    bool? isRefreshing,
    List<Product>? productList,
    homeState? homestate,
  }) =>
      HomeState(
        isRefreshing: isRefreshing ?? this.isRefreshing,
        productList: productList ?? this.productList,
        homestate: homestate ?? this.homestate,
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
}
