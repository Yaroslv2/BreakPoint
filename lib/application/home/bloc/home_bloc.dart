import 'package:bloc/bloc.dart';
import 'package:brandpoint/application/home/home_service.dart';
import 'package:brandpoint/application/home/product_list.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeService _homeService;

  HomeBloc(HomeService homeService)
      : _homeService = homeService,
        super(HomeState.initial()) {
    on<GetProductList>(_getProductist);
  }

  Future<void> _getProductist(
      GetProductList event, Emitter<HomeState> emit) async {
    emit(state.copyWith(
      homestate: homeState.loading,
    ));
    final response = await _homeService.getProductList(event.filter);
    if (response.statusCode == 200) {
      //print(state.productList);
      //print(response.body);

      emit(
        state.copyWith(
          productList: response.body,
          homestate: homeState.ok,
        ),
      );
    } else {
      emit(state.copyWith(
        homestate: homeState.failureLoadiing,
      ));
    }
  }
}
