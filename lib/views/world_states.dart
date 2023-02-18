import 'package:covid19/Model/WorldStatesModel.dart';
import 'package:covid19/Services/states_services.dart';
import 'package:covid19/views/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({Key? key}) : super(key: key);

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen> with TickerProviderStateMixin{



  late final AnimationController _controller =
  AnimationController(duration: Duration(seconds: 3),
      vsync: this)..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: SafeArea(

        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height:  MediaQuery.of(context).size.height * .01,),
              FutureBuilder(
                  future: statesServices.getWorldStatesRecords(),
                  builder: (context,AsyncSnapshot<WorldStatesModel>snapshot){
                    if(!snapshot.hasData){
                      return Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50.0,
                        controller: _controller,
                      ));
                    }else{
                      return Column(
                         children: [
                           PieChart(

                             dataMap:
                           {
                             'Total' : double.parse(snapshot.data!.cases!.toString()),
                             'Recovered' : double.parse(snapshot.data!.recovered.toString()),
                             'Deaths' : double.parse(snapshot.data!.deaths.toString()),

                           },
                             chartValuesOptions:  ChartValuesOptions(
                               showChartValuesInPercentage: true,
                             ),
                             chartRadius: MediaQuery.of(context).size.width/3.2,

                             legendOptions: LegendOptions(
                                 legendPosition: LegendPosition.left
                             ),
                             animationDuration: Duration(milliseconds: 1200),
                             chartType: ChartType.ring,
                             colorList: colorList,

                           ),
                           Padding(
                             padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .06),
                             child: Card(
                               child:
                               Column(children: [
                                 ReusableRow(title: 'Total', value: snapshot.data!.cases.toString()),
                                 ReusableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                                 ReusableRow(title: 'Recovered', value: snapshot.data!.recovered.toString() ),
                                 ReusableRow(title: 'Active', value: snapshot.data!.active.toString()),
                                 ReusableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                                 ReusableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString() ),
                                 ReusableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString() ),
                               ],),
                             ),
                           ),
                           GestureDetector(
                             onTap: (){

                               Navigator.push(context, MaterialPageRoute(builder: (context)=>CountriesListScreen()));
                             },
                             child: Container(
                               height: 50,
                               decoration: BoxDecoration(
                                   color: Color(0xff1aa260),
                                   borderRadius: BorderRadius.circular(12)

                               ),
                               child: Center(child: Text('Track Countires')),
                             ),
                           ),
                         ],
                      );
                    }

              }),


            ],
          ),
        ),
      ),
    );
  }
}
class ReusableRow extends StatelessWidget {

  String title , value;
   ReusableRow({Key? key,required this.title,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(title),
              Text( value),
            ],
          ),
          SizedBox(height: 5,),
          Divider()
        ],
      ),
    );
  }
}
