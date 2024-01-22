import 'dart:convert';

import 'package:http/http.dart';
import 'package:weather_app/Repository/Api/api_client.dart';

import '../../Model_Class/WeatherModel.dart';

class WeatherApi{
  ApiClient apiClient = ApiClient();
  Future<WeatherModel>getWeather({required String location})async{
    String path  = 'https://open-weather13.p.rapidapi.com/city/${location}';
    var body={};
    Response response = await apiClient.invokeAPI(path, 'GET', body);
    return WeatherModel.fromJson(jsonDecode(response.body));
  }
}