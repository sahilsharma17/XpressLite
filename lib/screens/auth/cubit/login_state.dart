
import 'package:flutter/material.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoaded extends LoginState {
  String msg;
  LoginLoaded({required this.msg});
}

class LoginLoading extends LoginState {}

class LoginError extends LoginState {
  String error;
  LoginError({required this.error});
}