import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_softspace/data/constant.dart';
import 'package:weather/weather.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBloc() : super(WeatherBlocInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherBlocLoading());
      try {
        WeatherFactory wf = WeatherFactory(API_KEY, language: Language.RUSSIAN);

        Weather weather = await wf.currentWeatherByCityName(event.cityName);
        emit(WeatherBlocSuccess(weather));
      } catch (e) {
        emit(WeatherBlocFailure());
      }
    });
  }
}
