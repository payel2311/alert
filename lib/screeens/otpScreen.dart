//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newproject/provider/user_information.dart';
import 'package:newproject/screeens/Button.dart';
import 'package:newproject/screeens/LogInScreen.dart';
import 'package:newproject/screeens/ProfilePage.dart';
import 'package:newproject/utils/util.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';
class OtpScreen extends StatefulWidget {
  final String verificationId;
  const OtpScreen({super.key,required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? otpCode;
  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: isLoading ==true? const Center(child: CircularProgressIndicator()): Center(
          child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
      child: Column(
        children: [
        Container(
        width: 200,
        height: 300,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.purple.shade100,
        ),
        child: Image.asset("assets/veri.png",),
      ),
      const SizedBox(height: 20),
      const Text("Verify",
        style: TextStyle(fontSize: 30,
        ),
      ),
          const SizedBox(height: 20,),
          Pinput(length: 6,
          showCursor: true,
          onCompleted: (value){
            setState(() {
              otpCode=value;
            });
          }
            ,),
          const SizedBox(height: 40),
          SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.purple.shade200),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.black),
                  ),
                  onPressed: () {
                    if (otpCode !=null){
                      verifyOtp(context, otpCode!);
                    }
                    else{
                      showSnackBar(context, "Enter 6 digit Otp");
                    }
                  },
                  child: const Text(
                    'OK', style: TextStyle(fontSize: 20),

                  )
              )
          ),
          const SizedBox(height: 20,),
          const Text("Didn't recieve Otp"),

    ]
      ),
          )
    )

    )
    );
  }
  void verifyOtp(BuildContext context,String userOtp)
  {
    final ap=Provider.of<AuthProvider>(context,listen: false);
    ap.verifyOtp(context:context,verificationId: widget.verificationId,userOtp: userOtp,onSuccess: (){
      ap.checkExistingUser().then((value) async{
        if(value==true){

        }
        else{

          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>  LogInScreen(onTap: (){})),(route)=>false);
        }

      });
    });

  }

}
