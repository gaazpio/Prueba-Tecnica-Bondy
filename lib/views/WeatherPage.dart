import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WheatherPage extends StatefulWidget {
  const WheatherPage({Key? key}) : super(key: key);

  @override
  State<WheatherPage> createState() => _WheatherPageState();
}

class _WheatherPageState extends State<WheatherPage> with SingleTickerProviderStateMixin {

  //VARIABLES QUE USAMOS PARA LA PANTALLA, PARA LOS ESTADOS DEL TIEMPO
  DateTime now = DateTime.now();

  double sizeImg=0.8;

  String Ciudad = "";
  String dataInfo = "";

  double WindSpeed = 0.0;
  int WindSpeedEntero = 0;

  int humedad = 0;
  int nubes = 0;
  int estado = 0;

  String mainWeather = "";

  double temperatura = 0;
  int temperaturaEntero = 0;

  late AnimationController _controller;
  late Animation<Offset> _animation;

  bool esPequeno = true;


  //FUNCION PARA CAMBIAR EL TAMAÑO Y HACER UNA PEQUEÑA ANIMACION CADA VEZ QUE LO PULSAS

  void cambiarTamano() {
    setState(() {
      if (esPequeno) {
        sizeImg = 0.5; // Hacer grande
      } else {
        sizeImg = 0.8; // Hacer pequeño
      }
      esPequeno = !esPequeno; // Alternar entre pequeño y grande
    });
  }

  //FUNCION PARA LLAMAR A LA API Y CONECTARTE, LE PASAMOS LOS PARAMETROS DE LATITUD Y LONGITUD PARA VER DE QUE SITIO NOS DESCARGAMOS LOS DATOS

  void conectarApi(double latitud, double longitud) async {
    final url =
        "https://api.openweathermap.org/data/2.5/weather?lat=$latitud&lon=$longitud&appid=14a1ebdfd8a21d21210752adf9826abf";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print("CONECATADA CORRECTAMENTE");
      final data = json.decode(response.body);

      //CON EL setState actualizamos el estado de las variables declaradas arribas y les pones los datos correctos

      setState(() {
        WindSpeed = data['wind']['speed'] * 3.6;
        WindSpeedEntero = WindSpeed.toInt();

        dataInfo = data.toString();
        humedad = data['main']['humidity'];

        nubes = data['clouds']['all'];

        temperatura = data['main']['temp'] - 273.15;
        temperaturaEntero = temperatura.toInt();

        dynamic weatherData = data['weather'][0];
        mainWeather = weatherData['main'];

        //print(dataInfo);
      });
    } else {
      // Maneja errores de solicitud.
      print("Error al obtener datos meteorológicos: ${response.statusCode}");
    }
  }

  //FUNCION PARA OBTENER LA LOCALIZACION Y ASI TE MUESTRA LOS DATOS DE LA UBICACION QUE ESTAS

  void obtenerLocalizacionActual() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks.toString());
    setState(() {
      Ciudad = placemarks[0].locality.toString();
      conectarApi(position.latitude, position.longitude);
    });
  }


//CON EL INIT STATE INICIAMOS TODO EN CUANTO SE INICIA LA APLICACION
  //TAMBIEN HACEMOS LA ANIMACION DE QUE LA IMAGEN SE INICIE DESDE UN LADO


  @override
  void initState() {
    obtenerLocalizacionActual();
    super.initState();

      _controller = AnimationController(
        duration: Duration(seconds: 4),
        vsync: this,
      );
      _animation = Tween<Offset>(
        begin: Offset(5.0, 0.0,),
        end: Offset(0.0, 0.0),
      ).animate(CurvedAnimation(
        curve: Curves.easeInOut,
        parent: _controller,
      ));

      _controller.forward();
  }

  //REINICIAMOS POR SI ACASO EL CONTROLADOR DE LA APLI

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //FUNCION PARA QUE DEPENDIENDO DEL ESTADO TE MUESTRA UNA IMAGEN U OTRA

  Widget getImageBasedOnString(String stringValue,double scale) {
    if (stringValue.toLowerCase() == 'clouds') {
      return Image.asset('assets/6.png',
        scale: scale,
        width: 200.0,
        height: 220.0,
      );
    }
    else if (stringValue.toLowerCase() == 'clear') {
      return Image.asset('assets/1.png',
        scale: scale,
        width: 200.0,
        height: 220.0,);
    }
    else if (stringValue.toLowerCase() == 'rain ') {
      return Image.asset('assets/7.png',
        scale: scale,
        width: 200.0,
        height: 220.0,);
    }
    else if (stringValue.toLowerCase() == 'drizzle ') {
      return Image.asset('assets/7.png',
        scale: scale,
        width: 200.0,
        height: 220.0,);
    }
    else if (stringValue.toLowerCase() == 'mist ') {
      return Image.asset('assets/5.png',
        scale: scale,
        width: 200.0,
        height: 220.0,);
    }
    else if (stringValue.toLowerCase() == 'fog') {
      return Image.asset('assets/2.png',
        scale: scale,
        width: 200.0,
        height: 220.0,);
    }
    else if (stringValue.toLowerCase() == 'haze ') {
      return Image.asset('assets/5.png',
        scale: scale,
        width: 200.0,
        height: 220.0,);
    }
    else if (stringValue.toLowerCase() == 'thunderstorm ') {
      return Image.asset('assets/3',
        scale: scale,
        width: 200.0,
        height: 220.0,);
    }
    else if (stringValue.toLowerCase() == 'tornado ') {
      return Image.asset('assets/3.png',
        scale: scale,
        width: 200.0,
        height: 220.0,);
    }

    else {
      return Text("");
    }
  }


  @override
  Widget build(BuildContext context) {


    int mesNumero= now.month;
    int hora = now.hour;
    int minuto = now.minute;

    final String mesNombre = DateFormat.MMMM().format(now);
    final String diaNombre = DateFormat.EEEE().format(now);


    Color colorAppLet = Color.fromRGBO(68, 44, 64, 1.0);
    Color colorFondo = Color.fromRGBO(224, 198, 216, 1.0);

    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;

    return Scaffold(

      // MUESTRAMOS TODAS LAS VARIABLES COMO TEXTOS PARA QUE SE MUESTRA LA INFORMACION CORRECTA

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
            SizedBox(width: 8),
            AutoSizeText(
              '$Ciudad',
              textAlign: TextAlign.center,
              maxLines: 1,
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
              "${diaNombre},${mesNumero} ${mesNombre} ${hora}:${minuto}",
              style: TextStyle(fontSize: 19),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 125),
              child: Center(
                  child: Container(
                height: 400,
               // color: Colors.red,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Text(
                      "${temperaturaEntero}°",
                      style: TextStyle(
                          fontSize: 240,
                          fontWeight: FontWeight.bold,
                          color: colorAppLet),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Positioned(
                      top: 160,
                      left: 170,
                      child: SlideTransition(
                        position: _animation,
                        child:  GestureDetector(
                            onTap:(){
                          setState(() {
                            cambiarTamano();
                          });
                        },
                            child:Transform.scale(
                              scale: sizeImg,
                              child: getImageBasedOnString(mainWeather,sizeImg),
                            )
                          ),

                        )
                      ),
                    Positioned(
                      top: 260,
                      right: 220,
                      child:
                    Text(
                      "${mainWeather}",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: colorAppLet,
                      ),
                    ),
                    ),
                  ],
                ),
              )),
            ),



            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
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
                        ]
                    ),
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
  }
}
