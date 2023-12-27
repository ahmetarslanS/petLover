import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:petlover/pages/upload_animal.dart';
import 'dart:io';

import 'package:petlover/values/app_colors.dart';

class PreviewPage extends StatelessWidget {
  const PreviewPage({super.key, required this.picture});

  final XFile picture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('What a lovely pet!',),
        //Make background color gradient
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.pink, AppColors.purple, AppColors.darkPurple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        toolbarHeight: 60,
        ),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Image.file(File(picture.path), fit: BoxFit.cover, width: 320),
          const SizedBox(height: 30),
          Text(picture.name),
          const SizedBox(height: 30),
         //Make the ElevatedButtons side by side
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Retake'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UploadAnimalPage(),
                ),
              );

            },
            child: const Text('Use Photo'),
          ),
        ]
          ),
  ]),
      ),
    );
  }
}