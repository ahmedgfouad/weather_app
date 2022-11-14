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
    DateTime d = DateTime.now();
    DateFormat formatter = DateFormat("EEE");
    final dates = <Widget>[];

    for (int i = 0; i < 5; i++) {
      final date = d.add(Duration(days: i));
      dates.add(Padding(
        padding: EdgeInsets.only(
            top: 8.0,
            bottom: 8.0,
            left: 20.0,
            right: 20.0,
        ),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                formatter.format(date),
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            // Text(_monthFormatter.format(date)),
          ],
        ),
      ));
    }
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: FutureBuilder<WeatherApiResponse>(
            future: weatherApi.getApiData(),
            builder: (context, snapShot) {
              if (snapShot.hasData) {
                response = snapShot.data!;

                return SingleChildScrollView(
                  child: Container(
                    color: Colors.blueAccent,
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
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${response.list.first.main.temp}°',
                          style:
                          const TextStyle(fontSize: 40, color: Colors.white),
                        ),
                        Text(
                          response.list.first.weather.first.description,
                          style:
                          const TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          // color: Colors.blueAccent,
                          child: Column(
                            children: [
                              Column(
                                  children: [
                                 SizedBox(height: 30,),
                                Row(
                                  children: dates.map((widget) => Expanded(child: widget)).toList(),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(

                                        children: [
                                          Column(
                                            children: [
                                              Image.network(
                                                  'https://openweathermap.org/img/wn/${response.list.elementAt(0).weather.first.icon}@2x.png'),
                                              Text(
                                                response.list
                                                    .elementAt(0)
                                                    .main
                                                    .temp
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Image.network(
                                                  'https://openweathermap.org/img/wn/${response.list.elementAt(8).weather.first.icon}@2x.png'),
                                              Text(
                                                response.list
                                                    .elementAt(8)
                                                    .main
                                                    .temp
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Image.network(
                                                  'https://openweathermap.org/img/wn/${response.list.elementAt(16).weather.first.icon}@2x.png'),
                                              Text(
                                                response.list
                                                    .elementAt(16)
                                                    .main
                                                    .temp
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Image.network(
                                                  'https://openweathermap.org/img/wn/${response.list.elementAt(24).weather.first.icon}@2x.png'),
                                              Text(
                                                response.list
                                                    .elementAt(24)
                                                    .main
                                                    .temp
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Image.network(
                                                  'https://openweathermap.org/img/wn/${response.list.elementAt(32).weather.first.icon}@2x.png'),
                                              Text(
                                                response.list
                                                    .elementAt(32)
                                                    .main
                                                    .temp
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
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