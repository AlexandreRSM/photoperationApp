import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_camera_app/app.dart';
import 'package:flutter_camera_app/bloc/photo_app_cubit.dart';
import 'package:flutter_camera_app/bloc/photo_app_logic.dart';

void main() => runApp(const App());

//HomePage

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // App Root
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photoperation',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 145, 55, 55)),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => PhotoAppCubit(),
        child: const PhotoAppLogic(),
      ),
    );
  }
}       