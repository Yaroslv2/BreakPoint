import 'package:bloc/bloc.dart';
import 'package:brandpoint/application/home/home_service.dart';
import 'package:brandpoint/models/product_list.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeService _homeService;

  HomeBloc(HomeService homeService)
      : _homeService = homeService,
        super(HomeState.initial()) {
    on<GetProductList>(_getProductist);
    on<GetSearchList>(_getSearchList);
    on<LoadingMore>(_loadingMore);
  }

  Future<void> _getProductist(
      GetProductList event, Emitter<HomeState> emit) async {
    emit(state.copyWith(
      homestate: homeState.loading,
    ));
    final response = await _homeService.getProductList(event.filter);
    if (response.statusCode == 200) {
      emit(
        state.copyWith(
          productList: response.body,
          homestate: homeState.ok,
        ),
      );
    } else {
      emit(
        state.copyWith(
            homestate: homeState.failureLoadiing, errorMessage: response.error),
      );
    }
  }

  Future<void> _getSearchList(
      GetSearchList event, Emitter<HomeState> emit) async {
    emit(
      state.copyWith(
        homestate: homeState.loadingSearch,
      ),
    );
    var response = await _homeService.getProductList(event.filter);
    if (response.statusCode == 200) {
      if (state.productList.isEmpty && response.body == null) {
        emit(
          state.copyWith(
            homestate: homeState.emptySearch,
          ),
        );
      } else {
        emit(
          state.copyWith(productList: response.body, homestate: homeState.ok),
        );
      }
    } else {
      emit(
        state.copyWith(
          homestate: homeState.failureLoadiing,
          errorMessage: response.error,
        ),
      );
    }
  }

  Future<void> _loadingMore(LoadingMore event, Emitter<HomeState> emit) async {
    var response = await _homeService.getProductList(event.filter);
    if (response.statusCode == 200) {
      emit(state.copyWith(
        productList: response.body,
      ));
    } else {
      emit(state.copyWith(
        homestate: homeState.failureLoadiing,
        errorMessage: response.error,
      ));
    }
  }
}
