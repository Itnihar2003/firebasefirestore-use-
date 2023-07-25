import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demoapp/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // QuerySnapshot snapshot =
  //     await FirebaseFirestore.instance.collection("users").get();
  // for (var doc in snapshot.docs) {
  //   print(doc.data());
  // }
  // Map<String, dynamic> docoment3 = {
  //   "name": "pankajini behera",
  //   "email": "beherapankajini30@gmail.com"
  // };
  // FirebaseFirestore.instance.collection("users").add(docoment3);
  // print("saved");
  runApp(MaterialApp(
    home: homepage(),
  ));
}
