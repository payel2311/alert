import 'package:flutter/material.dart';
import 'package:newproject/screeens/LogInScreen.dart';
import 'package:newproject/screeens/otpScreen.dart';
import 'package:provider/provider.dart';
import 'Button.dart';
import 'package:newproject/provider/auth_provider.dart';
import 'RegScreen.dart';
class FirstPage extends StatelessWidget {
  const FirstPage({super.key});
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context,listen:false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Image.asset('assets/iconcheck.png',width: 300.00,height: 400.00),
            ElevatedButton(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.black)
              ),
              onPressed: () { {
                ap.isSignedIn== true ? Navigator.push(context,MaterialPageRoute(builder: (context)=> ButtonPage()))
                    : Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  RegScreen()),
                );
              }},
              child: Text('ALERT',style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),

            )
          ],
        ),
      ),
    );
  }
}