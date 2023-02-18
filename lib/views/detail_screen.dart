import 'package:covid19/views/world_states.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class DetailScreen extends StatefulWidget {


  String image;
  String name;
  int totalCases, totalDeaths, totalRecovered, active, critical,todayRecovered,test;
   DetailScreen({Key? key,required this.image,required this.name,required this.totalCases,
  required this.totalDeaths, required this.todayRecovered, required this.critical,
    required this.active, required this.test, required this.totalRecovered,

  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(alignment: Alignment.topCenter,
            children: [
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height *
    .067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * .06,),
                      ReusableRow(title: 'cases', value: widget.totalCases.toString()),
                      ReusableRow(title: 'Recovered', value: widget.totalRecovered.toString()),
                      ReusableRow(title: 'Deaths', value: widget.totalDeaths.toString()),
                      ReusableRow(title: 'Critical', value: widget.critical.toString()),
                      ReusableRow(title: 'Today Recovered', value: widget.totalRecovered.toString()),

                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
