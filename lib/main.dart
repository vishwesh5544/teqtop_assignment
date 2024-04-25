import 'package:flutter/material.dart';
import 'package:flutter_assignment/bloc/base_bloc.dart';
import 'package:flutter_assignment/screens/home_screen.dart';
import 'package:flutter_assignment/service/base_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teqtop Assignment',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) {
          final baseService = BaseService();
          return BaseBloc(baseService);
        },
        child: const HomeScreen(),
      ),
    );
  }
}
