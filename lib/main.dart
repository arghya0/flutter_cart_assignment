import 'package:flutter/material.dart';
import 'package:flutter_assignment/bloc/MenuBloc.dart';
import 'package:flutter_assignment/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return BlocProvider(
      create: (context) => MenuBloc(),
      child: MaterialApp(
        home: HomePage(),
      ),
    );

  }
}
