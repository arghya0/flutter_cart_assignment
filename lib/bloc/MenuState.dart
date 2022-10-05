
import 'package:equatable/equatable.dart';
import 'package:flutter_assignment/model/menu_m.dart';

abstract class MenuState extends Equatable {

  MenuState();

  @override
  List<Object> get props => [];
}

class MenuInitState extends MenuState {}

class MenuErrorState extends MenuState {
  String error;

  MenuErrorState(this.error);
}

class MenuLoadingState extends MenuState {}

class MenuLoadedState extends MenuState {
  Map<String, List<MenuM>> items;

  MenuLoadedState(this.items);
}