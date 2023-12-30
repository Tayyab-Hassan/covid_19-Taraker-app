import 'package:covid_19/Models/countries_detail.dart';
import 'package:covid_19/services/state_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  StateServices stateServices = StateServices();
  TextEditingController searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.redAccent,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 20,
        shadowColor: Colors.redAccent,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              onChanged: (value) {
                setState(() {});
              },
              controller: searchcontroller,
              decoration: InputDecoration(
                hintText: "Search Countries By Its Name ",
                label: const Text("Search"),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: stateServices.getCountriesApi(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (!snapshot.hasData) {
                  return ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.cyanAccent.shade700,
                        highlightColor: Colors.cyanAccent.shade100,
                        child: Column(
                          children: [
                            ListTile(
                              title: Container(
                                  height: 10, width: 90, color: Colors.white),
                              subtitle: Container(
                                  height: 10, width: 90, color: Colors.white),
                              leading: Container(
                                  height: 50, width: 50, color: Colors.white),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String name = snapshot.data![index]['country'];

                      if (searchcontroller.text.isEmpty) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Countries(
                                      active: snapshot.data![index]['active']
                                          .toString(),
                                      name: snapshot.data![index]['country']
                                          .toString(),
                                      death: double.parse(snapshot.data![index]
                                              ['deaths']
                                          .toString()),
                                      todaydeaths: snapshot.data![index]
                                              ['todayDeaths']
                                          .toString(),
                                      todayrecovered: snapshot.data![index]
                                              ['todayRecovered']
                                          .toString(),
                                      cases: double.parse(snapshot.data![index]
                                              ['cases']
                                          .toString()),
                                      cirtical: snapshot.data![index]
                                              ['critical']
                                          .toString(),
                                      countryflag: snapshot.data![index]
                                              ['countryInfo']['flag']
                                          .toString(),
                                      population: snapshot.data![index]
                                              ['population']
                                          .toString(),
                                      recovered: double.parse(snapshot
                                          .data![index]['recovered']
                                          .toString()),
                                    ),
                                  ),
                                );
                              },
                              child: ListTile(
                                title: Text(
                                  snapshot.data![index]['country'],
                                ),
                                subtitle: Text(
                                  snapshot.data![index]['cases'].toString(),
                                ),
                                leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]
                                        ['countryInfo']['flag'])),
                              ),
                            )
                          ],
                        );
                      } else if (name
                          .toLowerCase()
                          .contains(searchcontroller.text.toLowerCase())) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Countries(
                                  active: snapshot.data![index]['active']
                                      .toString(),
                                  name: snapshot.data![index]['country']
                                      .toString(),
                                  death: double.parse(snapshot.data![index]
                                          ['deaths']
                                      .toString()),
                                  todaydeaths: snapshot.data![index]
                                          ['todayDeaths']
                                      .toString(),
                                  todayrecovered: snapshot.data![index]
                                          ['todayRecovered']
                                      .toString(),
                                  cases: double.parse(snapshot.data![index]
                                          ['cases']
                                      .toString()),
                                  cirtical: snapshot.data![index]['critical']
                                      .toString(),
                                  countryflag: snapshot.data![index]
                                          ['countryInfo']['flag']
                                      .toString(),
                                  population: snapshot.data![index]
                                          ['population']
                                      .toString(),
                                  recovered: double.parse(snapshot.data![index]
                                          ['recovered']
                                      .toString()),
                                ),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  snapshot.data![index]['country'],
                                ),
                                subtitle: Text(
                                  snapshot.data![index]['cases'].toString(),
                                ),
                                leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]
                                        ['countryInfo']['flag'])),
                              )
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                }
              },
            ),
          ),
        ],
      )),
    );
  }
}
