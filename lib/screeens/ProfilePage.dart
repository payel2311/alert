

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newproject/model/user_model.dart';
import 'package:newproject/screeens/Button.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';
import 'widget.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isEditing = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  @override
  void dispose(){
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
  }
  void initState() {
    super.initState();
    // Set initial values (for demonstration purposes)
    _nameController.text = 'John Doe';
    _emailController.text = 'john.doe@example.com';
    _phoneNumberController.text = '+1 (123) 456-7890';
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveChanges() {
    CollectionReference collRef = FirebaseFirestore.instance.collection('user');
    // Implement your logic to save changes to the profile
    collRef.add({// For now, let's just print the updated values
      'Name' : _nameController.text,
      'Email': _emailController.text,
      'Phone Number': _phoneNumberController.text,

  }
    );

    // You can add logic to save the changes to a database or server here
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Profile Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: _toggleEditing,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 16.0),
            Text('Name:'),
            _isEditing
                ? TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Enter your name',
              ),
            )
                : Text(_nameController.text),
            SizedBox(height: 16.0),
            Text('Email:'),
            _isEditing
                ? TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Enter your email',
              ),
            )
                : Text(_emailController.text),
            SizedBox(height: 16.0),
            Text('Phone Number:'),
            _isEditing
                ? TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(
                hintText: 'Enter your phone number',
              ),
            )
                : Text(_phoneNumberController.text),
            SizedBox(height: 24.0),
            if (_isEditing)
              ElevatedButton(
                onPressed: () {
                  //storeData();
                  _saveChanges();
                  _toggleEditing();
                },
                child: Text('Save Changes'),
              ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('user').snapshots(),
              builder: (context,snapshot){
                List<Row> clientWidgets = [];
                if(snapshot.hasData){
                  final clients= snapshot.data?.docs.reversed.toList();
                  for (var client in clients!){
                    final clientWidget= Row(
                      children: [
                        Text(client['Name']),
                        Text(client['Email']),
                        Text(client['Phone Number']),

                      ],
                    );
                  }
                }
                return Expanded(child: ListView(
                  children: clientWidgets,
                ),
                );
              }
            )
          ],
        ),
      ),
    );
  }
 /* void storeData() async{
    final ap= Provider.of<AuthProvider>(context as BuildContext,listen:false);
    UserModel userModel= UserModel(name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phoneNumber: _phoneNumberController.text.trim(), uid: "");
    ap.saveUserDataToFirebase(context: context as BuildContext, userModel: userModel,
        onSuccess: (){
      ap.saveUserDataToSP().then((value) => ap.setSignIn().then((value) => Navigator.pushAndRemoveUntil(context as BuildContext, MaterialPageRoute(builder: (context)=> ButtonPage()),(route) => false),));

    });
  }*/
}
