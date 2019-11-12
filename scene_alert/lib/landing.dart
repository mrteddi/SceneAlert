import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scene_alert/history.dart';
import 'package:scene_alert/map.dart';
import 'package:scene_alert/settings.dart';
import 'package:geolocator/geolocator.dart';
import 'package:scene_alert/globals.dart' as globals;
import 'package:scene_alert/theme.dart';
//import 'package:scene_alert/logout.dart';

class LandingPage extends StatefulWidget {
  @override
  State<LandingPage> createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {

  int _selectedPage = 1;
  final _pageOptions = [
    //Logout(),
    Center( child: Text('Future Widget') ),
    CrimeMap(),
    CrimeHistory(),
  ];

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scene Alert',

      theme: Provider.of<ThemeChanger>(context).getTheme(),

      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Scene Alert'),
          actions: <Widget>[
            Builder( 
              builder: (context) =>
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return Settings();
                  }));
                },
              ),
            ),
          ],
        ),
        body:
      
        IndexedStack(
          index: _selectedPage,
          children: _pageOptions,
        ),
      
        //  _pageOptions[_selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          //backgroundColor: Theme.of(context).accentColor,
          currentIndex: _selectedPage,
          onTap: (int index){
            setState(() {
              _selectedPage = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              title: Text('Map')
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              title: Text('History')
            )

          ],
        ),
      )  
    );
  }

  Future getLocation() async {
    GeolocationStatus geolocationStatus  = await Geolocator().checkGeolocationPermissionStatus();

    print( "Checking Location------------------------------------------");
    print( geolocationStatus.value );
    Position position = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
    if( !(position ?? false) ) {
      position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    }

    globals.lat = position.latitude;
    globals.lon = position.longitude;

    return position;
  }

}