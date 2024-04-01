import 'dart:io';

import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';


abstract class PhotoAppState extends Equatable {
  final bool? isLoading;
  final bool? hasError;
  final String? errorMessage;

  const PhotoAppState({
    this.errorMessage,
    this.isLoading,
    this.hasError
  });
}

class InitialState extends PhotoAppState{
  const InitialState();

  @override
  List<Object?> get props => [];
}


class StartScreenState extends PhotoAppState {
  final File? file;

  const StartScreenState({
    this.file,
    super.isLoading,
    super.errorMessage,
    super.hasError,
  });

  @override
  List<Object?> get props =>[file, isLoading, errorMessage, hasError];
 }

class CameraState extends PhotoAppState {
  final CameraDescription camera;
  final CameraController controller;

  const CameraState({
    required this.controller,
    required this.camera,
    super.isLoading,
    super.errorMessage,
    super.hasError,
  });

  @override
  List<Object?> get props => [controller, camera, isLoading, errorMessage, hasError];
}

class PreviewState extends PhotoAppState {
  final File? file;

  const PreviewState({
    required this.file,
    super.isLoading,
    super.errorMessage,
    super.hasError
  });

  @override
  List<Object?> get props => [file, isLoading, errorMessage, hasError];
}        