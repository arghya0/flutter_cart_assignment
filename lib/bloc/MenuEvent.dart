
import 'package:equatable/equatable.dart';

abstract class MenuEvent extends Equatable {
  MenuEvent();

  @override
  List<Object> get props => [];
}

class MenuFetchEvent extends MenuEvent {}