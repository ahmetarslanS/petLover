import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:petlover/pages/camera_page.dart';
import 'package:petlover/values/app_colors.dart';
import '../utils/extensions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petlover/values/app_routes.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(38.38866, 27.04457);


  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }




  @override
  Widget build(BuildContext context) {
    final size = context.mediaQuerySize;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.pink, AppColors.purple, AppColors.darkPurple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title:
            Text('PET LOVER', style: Theme.of(context).textTheme.titleMedium),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(' Hello, User', style: TextStyle(fontSize: 24)),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  //Add a box decoration border
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  height: size.height * 0.35,

                    child: const GoogleMap(
                    initialCameraPosition: CameraPosition(
                      //Coordinates for Izmir University of Economics
                      target:  LatLng(38.38866, 27.04457),
                      zoom: 11.0,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.yellow[100],
                  ),
                  height: size.height * 0.05,
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  child:
                      const Text(
                        'Pets Nearby',
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  height: size.height * 0.293,
                  padding: const EdgeInsets.all(10.0),
                  child: const Text('Top Rescuers',
                      style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(5.0),
        color: Colors.pink[100],
        child: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: [
                  IconButton(icon: const Icon(Icons.settings), onPressed: () {}, iconSize: 34,),
                  const Text('Settings', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const VerticalDivider(
                color: Colors.black54,
                thickness: 2,
              ),
              ElevatedButton(
                onPressed: () async {
                  await availableCameras().then(
                        (value) => Navigator.push(
                        context, MaterialPageRoute(
                        builder: (_) => CameraPage(cameras: value))
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(70, 70),
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(10),
                ),
                child: const Icon(Icons.pets,),
              ),
              const VerticalDivider(
                color: Colors.black54,
                thickness: 2,
              ),
              Column(
                children: [
                  IconButton(icon: const Icon(Icons.person), onPressed: () {}, iconSize: 34,
                  ),
                  const Text('Profile', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
