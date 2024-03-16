import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:newproject/provider/auth_provider.dart';
import 'package:newproject/screeens/Button.dart';
import 'package:newproject/screeens/RegScreen.dart';
import 'package:provider/provider.dart';

class LogInScreen extends StatefulWidget {
  final void Function()? onTap;

  const LogInScreen({super.key,required this.onTap});

void login(){}
  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController phoneController = TextEditingController();
  Country country = Country(phoneCode: "91",
      countryCode: "IN",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "India",
      example: "India",
      displayName: "India",
      displayNameNoCountryCode: "IN",
      e164Key: "");

  @override
  Widget build(BuildContext context) {
    phoneController.selection = TextSelection.fromPosition(
      TextPosition(offset: phoneController.text.length,),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
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
                  child: Icon(
                    Icons.person,
                    size: 120,
                    color: Theme.of(context).colorScheme.inverseSurface,
                  )
                ),
                const SizedBox(height: 20),
                const Text("Login",
                  style: TextStyle(fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: phoneController,
                  onChanged: (value) {
                    setState(() {
                      phoneController.text = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Enter your phone number",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    prefixIcon: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: () {
                          showCountryPicker(
                              context: context, onSelect: (value) {
                            setState(() {
                              country = value;
                            });
                          });
                        },
                        child: Text("${country.flagEmoji} + ${country
                            .phoneCode}",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),

                    ),
                    suffixIcon: phoneController.text.length > 9 ? Container(
                      padding: const EdgeInsets.all(10.0),
                      width: 30,
                      height: 30,
                      child: const Icon(Icons.done,
                        color: Colors.green,
                        size: 20,),
                    ) : null,
                  ),
                ),
                const SizedBox(height: 20),
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
                        onPressed: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ButtonPage()))
                        },
                        child: const Text(
                          'Login', style: TextStyle(fontSize: 20),

                        )
                    )
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? "),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> RegScreen()));
                      },
                      child: const Text("Register here",style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],

                )


              ],
            ),),
        ),
      ),
    );
  }
}