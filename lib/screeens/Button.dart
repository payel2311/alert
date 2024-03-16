
import 'package:newproject/main.dart';
import 'package:newproject/screeens/flutter_sound.dart';
import 'package:newproject/screeens/map.dart';
import 'package:newproject/screeens/mymap.dart';
import 'package:shake/shake.dart';

import 'widget.dart';
import 'package:flutter/material.dart';
//import 'fourth.dart';
//import 'package:shake/shake.dart';
//import 'voice.dart';
class ButtonPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.red.shade200,
          title: const Text('')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                  ShakeDetector detector = ShakeDetector.autoStart(
                onPhoneShake: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Shake!'),
                    ),
                  );
                  // Do stuff on phone shake
                },
                minimumShakeCount: 1,
                shakeSlopTimeMS: 500,
                shakeCountResetTime: 3000,
                shakeThresholdGravity: 2.7,
              );

                // Handle button tap
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(200, 100)),
              ),
              child: Text('SHAKE!',style: TextStyle(fontSize: 30,color: Colors.red.shade300,fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 16), // Add some spacing between buttons
            ElevatedButton(
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  Mapp()),
                );

                // Handle button tap

              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(200, 100)),
                // Adjust the values according to your needs
              ),
              child: Text('ALERT!',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.red.shade600),),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  AudioRecorder()),
                  );
                  // Handle button tap
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(200, 100)),
                // Adjust the values according to your needs
              ),
              child: Text('RECORD!', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.red.shade900),),
            ),
            // Add more buttons as needed
          ],
        ),
      ),

    );
  }
}