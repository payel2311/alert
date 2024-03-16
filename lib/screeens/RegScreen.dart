import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:newproject/provider/auth_provider.dart';
import 'package:provider/provider.dart';
class RegScreen extends StatefulWidget {
  const RegScreen({super.key});

  @override
  State<RegScreen> createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
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
                  child: Image.asset("assets/reg.png",),
                ),
                const SizedBox(height: 20),
                const Text("Registration",
                  style: TextStyle(fontSize: 30,
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
                        onPressed: () => SendPhoneNumber(),
                        child: const Text(
                          'Login', style: TextStyle(fontSize: 20),

                        )
                    )
                )


              ],
            ),),
        ),
      ),
    );
  }

  void SendPhoneNumber() {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    String phoneNumber = phoneController.text.trim();
    ap.signInWithPhone(context, "+${country.phoneCode}$phoneNumber");
  }
}