// ignore_for_file: must_be_immutable

import 'package:covid_19/Models/row.dart';
import 'package:covid_19/services/state_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class Countries extends StatefulWidget {
  String name,
      todaydeaths,
      todayrecovered,
      active,
      cirtical,
      countryflag,
      population;
  double cases, recovered, death;
  // ignore: use_key_in_widget_constructors
  Countries({
    required this.active,
    required this.name,
    required this.death,
    required this.todaydeaths,
    required this.todayrecovered,
    required this.cases,
    required this.cirtical,
    required this.countryflag,
    required this.population,
    required this.recovered,
  });

  @override
  State<Countries> createState() => _CountriesState();
}

class _CountriesState extends State<Countries> with TickerProviderStateMixin {
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
      appBar: AppBar(
        leading: BackButton(
          color: Colors.redAccent,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        shadowColor: Colors.redAccent,
        elevation: 30,
        title: Center(
          child: Text(
            widget.name,
            style: const TextStyle(
              fontFamily: 'Pacifico',
              fontSize: 30,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .01),
              FutureBuilder(
                future: stateServices.getCountriesApi(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
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
                                'Total': double.parse(widget.cases.toString()),
                                'Recoverd':
                                    double.parse(widget.recovered.toString()),
                                'Deaths': double.parse(widget.death.toString()),
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
                                  MediaQuery.of(context).size.width / 3.0,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Expanded(
                              child: ListTile(
                                title: SingleChildScrollView(
                                  child: Card(
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          maxRadius: 40,
                                          backgroundImage: NetworkImage(
                                            widget.countryflag,
                                          ),
                                        ),
                                        Row1(
                                            title: 'Total Cases',
                                            value: widget.cases.toString()),
                                        Row1(
                                            title: 'Total Recovered',
                                            value: widget.recovered.toString()),
                                        Row1(
                                            title: 'Total Deaths',
                                            value: widget.death.toString()),
                                        Row1(
                                            title: 'Active',
                                            value: widget.active),
                                        Row1(
                                            title: 'Critical Cases',
                                            value: widget.cirtical),
                                        Row1(
                                            title: 'ToDay Deaths',
                                            value: widget.todaydeaths),
                                        Row1(
                                            title: 'Countries Population',
                                            value: widget.population),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
