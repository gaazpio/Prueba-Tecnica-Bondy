import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prueba_tecnica_bondy/controllers/weather_controller.dart';
import 'package:prueba_tecnica_bondy/widgets/weather_card.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context) {
    Color colorAppLet= Color.fromRGBO(68, 44, 64, 1.0);
    Color colorFondo= Color.fromRGBO(224, 198, 216, 1.0);
    final weatherController = Get.put(WeatherController());

    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double appBarHeight = AppBar().preferredSize.height;
    double screenHeightWithoutAppBar = MediaQuery.of(context).size.height - appBarHeight;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorFondo,
        elevation: 0,
        toolbarHeight: 70,
        title:Row(
          children: [
            SizedBox(width: 40),
            Icon(Icons.location_on,size: 32,color: colorAppLet,),
            SizedBox(width: 8), // Espacio entre el ícono y el texto
          Text("Location",style: TextStyle(color: colorAppLet,fontSize: 30,fontWeight: FontWeight.bold),),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.more_vert,size: 32,color: colorAppLet,), // Icono de prefijo
          onPressed: () {
          },
        ),
        actions: <Widget>[
        IconButton(
        icon: Icon(Icons.add,size: 32,color: colorAppLet,), // Icono de sufijo
        onPressed: () {
          // Acción al hacer clic en el icono de sufijo
        },
      ),
            ],
        ),
      body: Container(
        width: screenWidth,
        color: colorFondo,
        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Monday, 1 January 9:00",style: TextStyle(fontSize: 19),),
            Text('Alto de la AppBar: $appBarHeight'),
            Text('Alto de la pantalla sin la AppBar: $screenHeightWithoutAppBar'),
          ],
        ),
      ),
    );

          /*Column(
            children: [
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: TextField(
                  controller: weatherController.input,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) async => Future.delayed(
                      const Duration(milliseconds: 150),
                          () async => await weatherController.fetchLocations(value)),
                ),
              ),
              Obx(
                    () => weatherController.searchLocations.value.isEmpty
                    ? const SizedBox.shrink()
                    : ListView.builder(
                  shrinkWrap: true,
                  itemCount: weatherController.searchLocations.value.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(weatherController
                        .searchLocations.value[index].name ??
                        ""),
                    onTap: () => weatherController.setLocation(index),
                  ),
                ),
              ),
              Obx(
                    () => weatherController.currentWeather.value == null
                    ? const Padding(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: Text("No city selected."),
                )
                    : WeatherInfoCard(
                  weatherData: weatherController.currentWeather.value!,
                  locationData: weatherController.locationSelected.value!,
                ),
              ),
            ],
          ),*/
  }
}
