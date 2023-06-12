import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _DataTableExample createState() => _DataTableExample();
}

class _DataTableExample extends State<MyApp> {
  int _selectedIndex = 0;
  static const customOutline = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(7),
    ),
    borderSide: BorderSide(
        //  style: BorderStyle.none,
        color: Colors.green,
        width: 1.3),
  );

  static const errorCustomOutline = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(7),
    ),
    borderSide: BorderSide(
        //  style: BorderStyle.none,
        color: Colors.red,
        width: 1.5),
  );

  static const customOutlineWithoutBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(7),
    ),
    borderSide:
        BorderSide(style: BorderStyle.none, color: Colors.red, width: 1.3),
  );

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  bool _showRegulation = false;
  bool _showRC = false;
  bool _showGaz = false;

  final firebaseDatabaseInstance = FirebaseDatabase.instance;
  Map<String, dynamic> fieldList = {};
  Map<String, dynamic> limitList = {};

  @override
  void initState() {
    // TODO: implement initState
//  final uuid = firebaseInstance.currentUser!.uid;
    DatabaseReference starCountRef =
        firebaseDatabaseInstance.ref().child('data_tkz');

    starCountRef.limitToLast(1).onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      setState(() {
        limitList = jsonDecode(jsonEncode(data));
      });
      print(limitList[limitList.keys.first]);
    });
    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;

      setState(() {
        fieldList = jsonDecode(jsonEncode(data));
        fieldList = Map.fromEntries(fieldList.entries.toList()
          ..sort((e1, e2) => e1.key.compareTo(e2.key)));
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final widgetOptions = <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 120,
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 17, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              SizedBox(
                                width: 200,
                                child: Text(
                                  "Résistantes chauffantes",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.orangeAccent),
                                ),
                              ),
                              Text(
                                "Appoint prioritaire",
                                style: TextStyle(color: Colors.orangeAccent),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.orangeAccent.shade100,
                            radius: 27,
                            child: Icon(Icons.thermostat),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 5,
                        bottom: 5,
                        left: 0,
                        right: 5,
                      ),
                      child: Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 17, horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.greenAccent.shade100,
                                  radius: 27,
                                  child: Icon(Icons.thermostat),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "${limitList.isNotEmpty ? limitList[limitList.keys.first]['Tmin'] : 0}°C",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.greenAccent),
                                ),
                                const Text(
                                  "Tmin",
                                  style: TextStyle(color: Colors.greenAccent),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 5,
                        bottom: 5,
                        left: 0,
                        right: 5,
                      ),
                      child: Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 17, horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.blueAccent.shade100,
                                  radius: 27,
                                  child: const Icon(Icons.thermostat),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "${limitList.isNotEmpty ? limitList[limitList.keys.first]['Tmax'] : 0}°C",
                                  style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.blueAccent),
                                ),
                                const Text(
                                  "Tmax",
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
          const SizedBox(
            height: 12,
          ),
          const Text(
            "Historique des données",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Expanded(
                  child: Center(
                      child: Text(
                'Date/Heure',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ))),
              Expanded(
                  child: Center(
                      child: Text(
                'Température',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ))),
              Expanded(
                  child: Center(
                      child: Text(
                'Humidité',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ))),
              Expanded(
                  child: Center(
                child: Text(
                  'Température\nde stockage',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              )),
            ],
          ),
          if (fieldList.isNotEmpty)
            for (var element in fieldList.entries) ...[
              Column(
                children: [
                  const Divider(
                    color: Colors.black54,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Center(
                              child: Text(element.key.replaceAll('_', ' ')))),
                      Expanded(
                          child: Center(
                              child: Text(
                                  '${element.value['Tempareture'] ?? ''}'))),
                      Expanded(
                          child: Center(
                              child:
                                  Text('${element.value['Humidite']}' ?? ''))),
                      Expanded(
                          child: Center(
                              child: Text(
                                  '${element.value['T_stockage']}' ?? ''))),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              )
            ],
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Démarrer/Arrêter la régulation',
                style: TextStyle(fontSize: 16),
              ),
              // This switch controls the existence of the green box
              CupertinoSwitch(
                value: _showRegulation,
                onChanged: (value) {
                  setState(() {
                    _showRegulation = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Ajouter les appoints de chaleur RC',
                  style: TextStyle(fontSize: 16)),
              // This switch controls the existence of the green box
              CupertinoSwitch(
                value: _showRC,
                onChanged: (value) {
                  setState(() {
                    _showRC = value;
                  });
                },
              ),
            ],
          ),

          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //
          //   children: [
          //   const Text("Ajouter les appoints de chaleur RC"),
          //   const SizedBox(
          //     height: 5,
          //   ),
          //   TextFormField(
          //     keyboardType: TextInputType.text,
          //     textCapitalization: TextCapitalization.words,
          //     // textInputAction: TextInputAction.next,
          //     decoration: const InputDecoration(
          //       filled: true,
          //       fillColor: Colors.greenAccent,
          //       prefixIcon: Icon(Icons.severe_cold),
          //       hintText: "19°C",
          //       focusedErrorBorder: errorCustomOutline,
          //       errorBorder: errorCustomOutline,
          //       focusedBorder: customOutline,
          //       enabledBorder: customOutlineWithoutBorder,
          //     ),
          //   ),
          //   Align(
          //     alignment: Alignment.bottomRight,
          //     child: ElevatedButton.icon(
          //       onPressed: () {},
          //       icon: const Icon(Icons.send),
          //       label: const Text('Envoyer'),
          //     ),
          //   )
          // ],),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Ajouter appoint de Gaz',
                  style: TextStyle(fontSize: 16)),
              // This switch controls the existence of the green box
              CupertinoSwitch(
                value: _showGaz,
                onChanged: (value) {
                  setState(() {
                    _showGaz = value;
                  });
                },
              ),
            ],
          ),

          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //   const Text("Ajouter appoint de Gaz"),
          //   const SizedBox(
          //     height: 5,
          //   ),
          //   TextFormField(
          //     keyboardType: TextInputType.text,
          //     textCapitalization: TextCapitalization.words,
          //     // textInputAction: TextInputAction.next,
          //     decoration: const InputDecoration(
          //       filled: true,
          //       fillColor: Colors.greenAccent,
          //       prefixIcon: Icon(Icons.severe_cold),
          //       hintText: "19°C",
          //       focusedErrorBorder: errorCustomOutline,
          //       errorBorder: errorCustomOutline,
          //       focusedBorder: customOutline,
          //       enabledBorder: customOutlineWithoutBorder,
          //     ),
          //   ),
          //   Align(
          //     alignment: Alignment.bottomRight,
          //     child: ElevatedButton.icon(
          //
          //       onPressed: () {},
          //       icon: const Icon(Icons.send),
          //       label: Text('Envoyer'),
          //     ),
          //   )
          // ],)
        ],
      )
    ];

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text(
          "TAKAZ ENG",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(15),
          topLeft: Radius.circular(15),
        ),
        child: BottomNavigationBar(
          selectedItemColor: Colors.white,
          backgroundColor: Colors.green,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Paramètres',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          // selectedItemColor: Colors.black,
          onTap: _onItemTapped,
        ),
      ),
    ));
  }
}
