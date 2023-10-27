import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notification_important),
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 34, 6, 83),
                Color.fromRGBO(155, 118, 219, 1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          alignment: Alignment.center,
          child: const DiceRoller(),
        ),
      ),
    ),
  );
}

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});
  @override
  State<DiceRoller> createState() => _DiceRollerState();
}

class _DiceRollerState extends State<DiceRoller> {
  // String _image = 'assets/images/dice-images/dice-6.png';
  int randomNumber = 6;
  void diceRoller() async {
    // setState(() {
    //   randomNumber = Random().nextInt(6) + 1;
    //   // _image = 'assets/images/dice-images/dice-$randomNumber.png';
    // });
    int value = Random().nextInt(6) + 1;

    // Send a POST request to the Node.js server
    final response = await http.post(
      Uri.parse('http://localhost:3002/storeValue'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'value': value}),
    );

    if (response.statusCode == 200) {
      print('Value stored successfully.');
    } else {
      print('Failed to store value. Error: ${response.reasonPhrase}');
    }

    setState(() {
      randomNumber = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // image......
        Image.asset(
          // _image,
          'assets/images/dice-images/dice-$randomNumber.png',
          height: 300,
          width: 300,
        ),
        // const Image(
        //   image: AssetImage('$_image'),
        //   height: 300,
        //   width: 300,

        //   // color: Color.fromARGB(255, 44, 48, 63),
        // ),
        const SizedBox(
          height: 36,
        ),
        ElevatedButton(
          onPressed: diceRoller,
          child: const Text(
            'Roll Dice',
            style: TextStyle(
                color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
