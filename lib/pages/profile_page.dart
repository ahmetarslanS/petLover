import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petlover/values/app_routes.dart';


class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  File? _image;

  Future getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                SizedBox(height: 20),
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child: _image == null ? Icon(Icons.person, size: 50) : null,
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    'Name - Surname',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                SizedBox(height: 20),
                ProfileOption(title: 'Personal Info', icon: Icons.person),
                ProfileOption(title: 'Submitted Animals', icon: Icons.pets),
                ProfileOption(title: 'Adopted Animals', icon: Icons.family_restroom),
              ],
            ),
          ),
          ProfileOption(
            title: 'Log Out',
            icon: Icons.logout,
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.loginScreen, (route) => false);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: Icon(Icons.camera_alt),
        tooltip: 'Change Profile Photo',
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  const ProfileOption({Key? key, required this.title, required this.icon, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      color: Theme.of(context).colorScheme.secondary,
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        onTap: onTap,
      ),
    );
  }
}