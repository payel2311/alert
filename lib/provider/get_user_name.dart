import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class GetUser extends StatelessWidget {

  final String documentId;
  GetUser({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('client');
    return FutureBuilder(future: users.doc(documentId).get(), builder: ((context,snapshot){ if(snapshot.connectionState==ConnectionState.done){
      Map<String,dynamic>data=snapshot.data!.data() as Map<String,dynamic>;
      return Text('Name: ${data['Name']}'
          'Phone number: ${data['Phone Number']}'
      );
    }
return Text('loading...');
    })); Placeholder();
  }
}
