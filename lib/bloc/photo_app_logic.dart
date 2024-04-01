import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_camera_app/app.dart';
import 'package:flutter_camera_app/bloc/photo_app_cubit.dart';
import 'package:flutter_camera_app/bloc/photo_app_state.dart';

class PhotoAppLogic extends StatelessWidget {
  const PhotoAppLogic({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhotoAppCubit, PhotoAppState>(
        builder: (context, state){
           if (state is StartScreenState){
             return const InitialScreen();
           }
           else if (state is CameraState){
             return const CameraScreen();
           }
           else if (state is PreviewState){
             return const PreviewScreen();
           }
           else {
             return const Scaffold(
               body: Center(
                 child: Text('Nothing to show'),
               ),
             );
           }
        },
        listener: (context, state ){
        }
    );
  }
}
        