import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/BloC/weather_bloc.dart';
import 'package:weather_app/Repository/Model_Class/WeatherModel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

late WeatherModel data;
TextEditingController controller = TextEditingController();

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin:
                    EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 150),
                height: 50,
                width: 370,
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                        height: 50,
                        width: 280,
                        child: TextFormField(
                          controller: controller,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'search location'),
                        )),
                    GestureDetector(
                      onTap: (){
                        print(controller.text);
                        BlocProvider.of<WeatherBloc>(context).add(FetchWeather(location: controller.text));
                      },
                      child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(8)),
                          child: Icon(Icons.search)),
                    ),
                  ],
                ),
              ),


              BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if(state is WeatherBlocLoading){
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.yellow,
                      ),
                    );
                  }
                  if (state is WeatherBlocError) {
                    return Center(
                      child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.not_listed_location_outlined,color: Colors.blueGrey[300],size: 100,),
                          Text('Search your location',style: TextStyle(fontSize: 30,color: Colors.blueGrey[300],fontWeight: FontWeight.bold),),
                        ],
                      ),
                    );
                  }if (state is WeatherBlocLoaded){
                    data = BlocProvider.of<WeatherBloc>(context).weatherModel;
                    return Column(
                      children: [
                        Icon(Icons.cloud_queue_rounded,size: 100,color: Colors.blueGrey[100],),
                        Text(
                          data.name.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              data.main!.temp.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '⁰C',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Feel like ',
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            Text(
                              data.main!.feelsLike.toString(),
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                  else {
                   return Center(
                     child: Column(mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Icon(Icons.location_searching_rounded,color: Colors.blueGrey[300],size: 100,),
                         Text('Search your location',style: TextStyle(fontSize: 30,color: Colors.blueGrey[300],fontWeight: FontWeight.bold),),
                       ],
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
