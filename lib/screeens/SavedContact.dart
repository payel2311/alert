import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newproject/provider/get_user_name.dart';
import 'package:newproject/screeens/AddInfo.dart';
import 'package:pinput/pinput.dart';

class SavedContact extends StatefulWidget {
  const SavedContact({Key? key}):super(key:key);

  @override
  State<SavedContact> createState() => _SavedContactState();
}

class _SavedContactState extends State<SavedContact> {
  final user= FirebaseAuth.instance.currentUser!;
  List<String> docIDs = [];

  Future getDocId() async{
    await FirebaseFirestore.instance.collection('client').get().then((snapshot) => snapshot.docs.forEach((document) {
      print(document.reference);
      docIDs.add(document.reference.id);
}),);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Contacts'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20,),
          Expanded(child: FutureBuilder(future: getDocId(),builder: (context,snapshot){return ListView.builder(itemCount: docIDs.length, itemBuilder: (context,index){
          return ListTile(title: GetUser(documentId: docIDs[index],));

          }
          );
          }
          )

          ),
            ElevatedButton(
              onPressed: () {
                //storeData();
                Navigator.push(context,MaterialPageRoute(builder: (context)=> AddInfo()));
              },
              child: Text('Add Contact'),
            ),

      ],

        )
      ),
    );

  }
}
