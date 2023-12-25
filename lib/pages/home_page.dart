import 'package:flutter/material.dart';
import 'package:petlover/values/app_colors.dart';
import 'package:petlover/values/app_theme.dart';
import '../utils/extensions.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                  child: const Center(
                    child: Text('Map'),
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
                  height: size.height * 0.364,
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
                  IconButton(icon: Icon(Icons.settings), onPressed: () {}, iconSize: 30,),
                  const Text('Settings', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const VerticalDivider(
                color: Colors.black54,
                thickness: 2,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Icon(Icons.pets),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(70, 70),
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(10),
                ),
              ),
              const VerticalDivider(
                color: Colors.black54,
                thickness: 2,

              ),
              Column(
                children: [
                  IconButton(icon: Icon(Icons.person), onPressed: () {}, iconSize: 30,
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
