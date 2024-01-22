part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherBlocLoading extends WeatherState {}

class WeatherBlocLoaded extends WeatherState {}

class WeatherBlocError extends WeatherState {}
