import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/Repository/Api/API/WeatherApi.dart';

import '../Repository/Model_Class/WeatherModel.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {

  WeatherApi weatherApi = WeatherApi();
  late WeatherModel weatherModel;

  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeather>((event, emit) async {

      emit(WeatherBlocLoading());
      try {
        weatherModel = await weatherApi.getWeather(location: event.location);
        emit(WeatherBlocLoaded());
      }
      catch (e) {
        print(e);
        emit(WeatherBlocError());
      }
    });
  }
}
