import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UploadAnimalPage extends StatefulWidget {
  const UploadAnimalPage({super.key});

  @override
  _UploadAnimalPageState createState() => _UploadAnimalPageState();
}

class _UploadAnimalPageState extends State<UploadAnimalPage> {
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedAnimalType;
  String? _selectedBreed;
  Color _backgroundColor = Colors.white;
  final List<String> _catBreeds =  ["Amerikan Kedisi", "Bengal kedisi", "Birman kedisi", "Bombay kedisi", "British Shorthair", "Cornish Rex", "Cymric kedisi", "Ege kedisi", "Exotic Shorthair", "Foldex kedisi", "Havana kedisi", "İran kedisi", "Maine Coon", "Mavi Rus kedisi", "Oriental Shorthair", "Peterbald kedisi", "Rex kedisi", "Scottish Fold", "Sibirya kedisi", "Singapura kedisi", "Siyam kedisi", "Sphynx kedisi"];
  final List<String> _dogBreeds = ["Afgan Tazısı", "Africanis", "Airedale teriyeri", "Alaska kurdu", "Alman Pinscher", "Alpine Dachsbracke", "Amerikan pit bull teriyeri", "Amerikan Staffordshire teriyeri", "Amerikan tüysüz teriyeri", "Anadolu çoban köpeği", "Buldog", "Bull teriyer", "Çov-çov", "Danua", "Doberman", "Golden Retriever", "Gordon Seter", "Greyhound", "Gürcü çoban köpeği","Jack Russell Terrier", "Kafkas çoban köpeği", "Karakaçan Çoban Köpeği", "Kuvasz", "Lhasa Apso", "Napoli mastifi", "Pyrenees çoban köpeği", "Rottweiler", "Saint Bernard", "Tesem", "Tibet mastifi", "Tosa", "Vizsla", "Westphälische Dachsbracke", "Whippet", "Yunan çoban köpeği", "Zerdava"];
  List<String> _currentBreeds = [];

  final CollectionReference animalsCollection =
  FirebaseFirestore.instance.collection('animals');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.pets),
            SizedBox(width: 8),
            Text('ADD PET'),
            SizedBox(width: 8),
            Icon(Icons.pets),
          ],
        ),
        backgroundColor: Colors.blue.shade200,
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        color: _backgroundColor,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Container(
                color: Colors.grey[300],
                child: const GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(38.38866, 27.04457),
                    zoom: 15.0,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: ListView(
                children: <Widget>[
                  buildDropdownTile('Choose Pet', _selectedAnimalType, ['Cat', 'Dog'],
                          (String? newValue) {
                        String? initialBreed;
                        if (newValue == 'Cat') {
                          _changeBackgroundColor(Colors.pink.shade100);
                          initialBreed = _catBreeds.isNotEmpty ? _catBreeds[0] : null;
                        } else if (newValue == 'Dog') {
                          _changeBackgroundColor(Colors.orange);
                          initialBreed = _dogBreeds.isNotEmpty ? _dogBreeds[0] : null;
                        }

                        setState(() {
                          _selectedAnimalType = newValue;
                          _currentBreeds =
                          newValue == 'Cat' ? _catBreeds : _dogBreeds;
                          _selectedBreed = initialBreed;
                        });
                      }),
                  buildDropdownTile('Choose Breed', _selectedBreed, _currentBreeds,
                          (String? newValue) {
                        setState(() {
                          _selectedBreed = newValue;
                        });
                      }),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      uploadAnimal();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListTile buildDropdownTile(String title, String? value, List<String> items,
      ValueChanged<String?> onChanged) {
    return ListTile(
      title: Text(title),
      trailing: DropdownButton<String>(
        value: value,
        onChanged: (String? newValue) {
          if (newValue == 'Cat') {
            _changeBackgroundColor(Colors.pink.shade100);
          } else if (newValue == 'Dog') {
            _changeBackgroundColor(Colors.orange);
          }
          onChanged(newValue);
        },
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(fontSize: 12),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _changeBackgroundColor(Color color) {
    setState(() {
      _backgroundColor = color;
    });
  }

  void uploadAnimal() {
    animalsCollection
        .add({
      'animalType': _selectedAnimalType,
      'breed': _selectedBreed,
      'description': _descriptionController.text,
    })
        .then((value) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Animal uploaded successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.of(context).popUntil(ModalRoute.withName('/home'));
    })
        .catchError((error) {
      print('Error uploading animal to Firestore: $error');
    });
  }
}
