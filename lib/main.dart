import 'package:flutter/material.dart';
import 'secondpage.dart';
void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: MyHomePage(title: '',),
  ));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => Firstpage();
}

/// This is the private State class that goes with MyStatefulWidget.
class Firstpage extends State<MyHomePage> {
  bool on = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Page'),
      ),
      body: Container(
        alignment: FractionalOffset.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.flag,
                color: on ? Colors.blue : Colors.black,
                size: 60,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  // Toggle light when tapped.
                  on = !on;
                });
              },
              child: Container(
                color: Colors.yellow,
                padding: const EdgeInsets.all(8),
                // Change button text when light changes state.
                child: Text(on ? 'Blue' : 'Black'),
              ),
            ),

            ElevatedButton(
              child: const Text('Open page'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Secondpage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
