class UserModel{
   String name;
   String email;
   String phoneNumber;
   String uid;

  UserModel(
  {required this.name,
     required this.email,
    required this.phoneNumber,
  required this.uid}
      );
  //from map
  factory UserModel.fromMap(Map<String,dynamic>map){
    return UserModel(name: map['name'] ?? '', email: map['email'] ?? '', phoneNumber: map['phoneNumber'] ?? '', uid: map['uid'] ?? '');
  }
  //to map
Map<String,dynamic> toMap(){
    return{
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
      "uid": uid
    };
}
}