import 'package:flutter_bloc/flutter_bloc.dart';

/// -------- EVENTS --------
abstract class ThemeEvent {}

class ToggleThemeEvent extends ThemeEvent {}

/// -------- STATES --------
abstract class ThemeState {}

class ThemeLight extends ThemeState {}

class ThemeDark extends ThemeState {}

/// -------- BLOC --------
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeLight()) {
    on<ToggleThemeEvent>((event, emit) {
      if (state is ThemeLight) {
        emit(ThemeDark());
      } else {
        emit(ThemeLight());
      }
    });
  }
}
