import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_weather/api/api.dart';
import 'package:the_weather/models/weather_apiResponse.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late WeatherApiResponse response;
  final weatherApi = WeatherApi();
  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.now();
    DateFormat formatter = DateFormat("E");
    final dates = <Widget>[];

    for (int i = 0; i < 5; i++) {
      final date = dateTime.add(Duration(days: i));
      dates.add(
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            formatter.format(date),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      );
    }
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: FutureBuilder<WeatherApiResponse>(
            future: weatherApi.getApiData(),
            builder: (context, snapShot) {
              if (snapShot.hasData) {
                response = snapShot.data!;

                return Container(
                  color: Colors.teal,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          response.city.name,
                          style: const TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Image.network(
                            'https://openweathermap.org/img/wn/${response.list.first.weather.first.icon}@2x.png'),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${response.list.first.main.temp}°',
                          style: const TextStyle(
                              fontSize: 40, color: Colors.white),
                        ),
                        Text(
                          response.list.first.weather.first.description,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Column(children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: dates
                                      .map((widget) => Expanded(child: widget))
                                      .toList(),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 120,
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: ListView.separated(
                                      separatorBuilder:(context,index)=>SizedBox(width: 30,),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 5,
                                      itemBuilder: (context, index) {
                                        return Row(
                                          children: [
                                            Column(
                                              children: [
                                                Image.network(
                                                  'https://openweathermap.org/img/wn/${response.list[index].weather.first.icon}@2x.png',
                                                  width: 50,
                                                  height: 50,
                                                ),
                                                Text(
                                                  '${response.list[index].main.temp}°',
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            )
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ]),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (snapShot.hasError) {
                print(snapShot.error);
                return Container();
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}

