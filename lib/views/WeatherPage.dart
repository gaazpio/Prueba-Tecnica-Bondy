import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WheatherPage extends StatefulWidget {
  const WheatherPage({Key? key}) : super(key: key);

  @override
  State<WheatherPage> createState() => _WheatherPageState();
}

class _WheatherPageState extends State<WheatherPage> {
  String Ciudad = "";
  String dataInfo="";

  double WindSpeed=0.0;
  int WindSpeedEntero=0;

  int humedad=0;
  int nubes=0;
  int estado=0;

  String mainWeather="";

  double temperatura=0;
  int temperaturaEntero=0;

void conectarApi(double latitud, double longitud) async{
  final url = "https://api.openweathermap.org/data/2.5/weather?lat=$latitud&lon=$longitud&appid=14a1ebdfd8a21d21210752adf9826abf";
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    print("CONECATADA CORRECTAMENTE");
    final data = json.decode(response.body);

    setState(() {
      WindSpeed=data['wind']['speed']* 3.6;
      WindSpeedEntero=WindSpeed.toInt();

      dataInfo=data.toString();
      humedad=data['main']['humidity'];

      nubes=data['clouds']['all'];

      temperatura=data['main']['temp']-273.15;
      temperaturaEntero=temperatura.toInt();

      dynamic weatherData = data['weather'][0];
       mainWeather = weatherData['main'];

      //print(dataInfo);

    });

  }
  else {
    // Maneja errores de solicitud.
    print("Error al obtener datos meteorológicos: ${response.statusCode}");
  }
}
  @override
  void initState() {
    obtenerLocalizacionActual();
    super.initState();
  }

  void obtenerLocalizacionActual() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks.toString());
    setState(() {
      Ciudad = placemarks[0].locality.toString();
      conectarApi(position.latitude,position.longitude);
    });
  }


  @override
  Widget build(BuildContext context) {
    Color colorAppLet = Color.fromRGBO(68, 44, 64, 1.0);
    Color colorFondo = Color.fromRGBO(224, 198, 216, 1.0);

    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double appBarHeight = AppBar().preferredSize.height;
    double screenHeightWithoutAppBar = MediaQuery.of(context).size.height - appBarHeight;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorFondo,
        elevation: 0,
        toolbarHeight: 80,
        title: Row(
          children: [
            Icon(
              Icons.location_on,
              size: 32,
              color: colorAppLet,
            ),
            SizedBox(width: 8), // Espacio entre el ícono y el texto
            AutoSizeText(
              '$Ciudad',
              textAlign: TextAlign.center,maxLines: 1,
              style: TextStyle(
                  color: colorAppLet,
                  fontSize: 21,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(
            Icons.more_vert,
            size: 32,
            color: colorAppLet,
          ),
          // Icono de prefijo
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              size: 32,
              color: colorAppLet,
            ),
            // Icono de sufijo
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
            Text(
              "Monday, 1 January 9:00",
              style: TextStyle(fontSize: 19),
            ),
            Center(
              child: Column(
                children: [
                 Text(
                    "${temperaturaEntero}°",
                    style: TextStyle(
                        fontSize: 200,
                        fontWeight: FontWeight.bold,
                        color: colorAppLet),
                  ),
                  Row(children: [
                    SizedBox(width: 100),
                    Text("${mainWeather}",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: colorAppLet)),
                    SizedBox(width: 40),
                    Icon(
                      Icons.cloud,
                      size: 40,
                      color: colorAppLet,
                    ),
                  ]
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 70),
              width: 360,
              height: 110,
              child: Card(
                elevation: 0,
                semanticContainer: true,
                color: Color.fromRGBO(240, 228, 236, 0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud,
                            size: 20,
                            color: colorAppLet,
                          ),
                          SizedBox(height: 8),
                          Text("${nubes}%",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: colorAppLet)),
                          SizedBox(height: 8),
                          Text("Clouds",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: colorAppLet)),
                        ]),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.water_drop,
                            size: 20,
                            color: colorAppLet,
                          ),
                          SizedBox(height: 8),
                          Text("${humedad}%",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: colorAppLet)),
                          SizedBox(height: 8),
                          Text("Humidity",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: colorAppLet)),
                        ]),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.wind_power_rounded,
                            size: 20,
                            color: colorAppLet,
                          ),
                          SizedBox(height: 8),
                          Text("${WindSpeedEntero} km/h",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: colorAppLet)),
                          SizedBox(height: 8),
                          Text("Wind speed",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: colorAppLet)),
                        ]),
                  ],
                ),
              ),
            ),
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
