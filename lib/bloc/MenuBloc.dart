

import 'package:flutter_assignment/bloc/MenuEvent.dart';
import 'package:flutter_assignment/bloc/MenuState.dart';
import 'package:flutter_assignment/repocitory/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {

  MenuBloc() : super(MenuInitState()) {

    ApiService _apiService = ApiService();

    on<MenuFetchEvent>((event, emit) async {
      try{
        emit(MenuLoadingState());

        var items = await _apiService.fetchMenus();

        if (items != null) {
          //print('Data fetched -> ${items}');

          emit(MenuLoadedState(items));

        } else {
          emit(MenuErrorState('Some error occurred!'));
          print('Else Part');
        }

      } catch (e) {

          emit(MenuErrorState('Some error occurred -> ${e.toString()}'));
          print('Error occurred -> ${e.toString()}');
      }

    });
  }
}