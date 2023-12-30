import 'package:covid_19/Models/countries_list.dart';
import 'package:covid_19/Models/row.dart';
import 'package:covid_19/api_models/world_state_api.dart';
import 'package:covid_19/services/state_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldSate extends StatefulWidget {
  const WorldSate({super.key});

  @override
  State<WorldSate> createState() => _WorldSateState();
}

class _WorldSateState extends State<WorldSate> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 4),
    vsync: this,
  )..repeat();
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .01),
              FutureBuilder(
                future: stateServices.getWorldApi(),
                builder: (context, AsyncSnapshot<WorldStateApi> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50.0,
                        controller: _controller,
                      ),
                    );
                  } else {
                    // ignore: avoid_unnecessary_containers
                    return Container(
                      child: Expanded(
                        child: Column(
                          children: [
                            PieChart(
                              dataMap: {
                                'Total': double.parse(
                                    snapshot.data!.cases!.toString()),
                                'Recoverd': double.parse(
                                    snapshot.data!.recovered!.toString()),
                                'Deaths': double.parse(
                                    snapshot.data!.deaths!.toString()),
                              },
                              chartValuesOptions: const ChartValuesOptions(
                                  showChartValuesInPercentage: true),
                              animationDuration: const Duration(seconds: 2),
                              chartType: ChartType.ring,
                              legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.left,
                                legendShape: BoxShape.rectangle,
                                legendTextStyle: TextStyle(
                                    fontFamily: 'Pacifico', fontSize: 17),
                              ),
                              colorList: colorList,
                              chartRadius:
                                  MediaQuery.of(context).size.width / 2.5,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * .06,
                              ),
                              child: Card(
                                child: Column(
                                  children: [
                                    Row1(
                                        title: 'Total Cases',
                                        value:
                                            snapshot.data!.cases!.toString()),
                                    Row1(
                                        title: 'Total Recovered',
                                        value: snapshot.data!.recovered!
                                            .toString()),
                                    Row1(
                                        title: 'Total Deaths',
                                        value:
                                            snapshot.data!.deaths!.toString()),
                                    Row1(
                                        title: 'Active',
                                        value:
                                            snapshot.data!.active!.toString()),
                                    Row1(
                                        title: 'Critical Cases',
                                        value: snapshot.data!.critical!
                                            .toString()),
                                    Row1(
                                        title: 'ToDay Deaths',
                                        value: snapshot.data!.todayDeaths!
                                            .toString()),
                                    Row1(
                                        title: 'ToDay Recovered',
                                        value: snapshot.data!.todayRecovered!
                                            .toString()),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: ElevatedButton(
                                style: const ButtonStyle(
                                  foregroundColor:
                                      MaterialStatePropertyAll(Colors.amber),
                                  overlayColor: MaterialStatePropertyAll(
                                      Colors.cyanAccent),
                                  shape: MaterialStatePropertyAll(OvalBorder()),
                                  fixedSize:
                                      MaterialStatePropertyAll(Size(250, 45)),
                                  elevation: MaterialStatePropertyAll(15.0),
                                  shadowColor: MaterialStatePropertyAll(
                                      Colors.redAccent),
                                  textStyle: MaterialStatePropertyAll(
                                    TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                  backgroundColor: MaterialStatePropertyAll(
                                      Color.fromARGB(255, 6, 156, 11)),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CountriesList()));
                                },
                                child: const Text(
                                  'Tracker Countires',
                                  style: TextStyle(
                                    fontFamily: 'Pacifico',
                                    fontSize: 25,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
