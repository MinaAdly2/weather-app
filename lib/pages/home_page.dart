import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app/cubits/weather_cubit/weather_state.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/search_page.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  WeatherModel? weatherData;

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchPage();
              }));
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WeatherSuccessState) {
            //weatherData = BlocProvider.of<WeatherCubit>(context).weatherModel;
            return HomeBody(weatherData: state.weatherModel);
          } else if (state is WeatherFailureState) {
            return const Center(
              child: Text(
                'Something went wrong please try again',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          } else {
            return const InitialHomeBody();
          }
        },
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
    required this.weatherData,
  });

  final WeatherModel? weatherData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            weatherData!.getThemeColor(),
            weatherData!.getThemeColor()[300]!,
            weatherData!.getThemeColor()[100]!,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(
            flex: 3,
          ),
          Text(
            BlocProvider.of<WeatherCubit>(context).cityName!,
            style: const TextStyle(
              fontSize: 32.0,
            ),
          ),
          Text(
            'updated at: ${weatherData!.date.hour.toString()}:${weatherData!.date.minute.toString()}',
            style: const TextStyle(
              fontSize: 20.0,
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image(image: AssetImage(weatherData!.getImage())),
              Text(
                '${weatherData!.temp.toInt()}',
                style: const TextStyle(
                  fontSize: 32.0,
                ),
              ),
              Column(
                children: [
                  Text('maxTemp: ${weatherData!.maxTemp.toInt()}'),
                  Text('minTemp: ${weatherData!.minTemp.toInt()}'),
                ],
              ),
            ],
          ),
          const Spacer(
            flex: 1,
          ),
          Text(
            weatherData!.weatherCondition,
            style: const TextStyle(
              fontSize: 32.0,
            ),
          ),
          const Spacer(
            flex: 6,
          ),
        ],
      ),
    );
  }
}

class InitialHomeBody extends StatelessWidget {
  const InitialHomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'There is no weather 😞 ٍٍstart',
            style: TextStyle(
              fontSize: 30.0,
            ),
          ),
          Text(
            'Searching now 🔍 ',
            style: TextStyle(
              fontSize: 30.0,
            ),
          ),
        ],
      ),
    );
  }
}
