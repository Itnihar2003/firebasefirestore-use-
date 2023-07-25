import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class homepage extends StatelessWidget {
  homepage({super.key});
  TextEditingController mail = TextEditingController();
  TextEditingController name = TextEditingController();
  //data save in firebase
  void saved() {
    String savedname = name.text.toString();
    String savedmail = mail.text.toString();

    if (savedmail == "" || savedname == "") {
      print("error");
    } else {
      Map<String, dynamic> newdata = {"name": savedname, "mail": savedmail};
      FirebaseFirestore.instance.collection("users").add(newdata);
      print("saved");
    }
  }

  StreamController increasedata = StreamController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("loginpage"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    hintText: "name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
                style: TextStyle(color: Color.fromARGB(255, 6, 6, 6)),
                controller: name,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: "email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
                style: TextStyle(color: Color.fromARGB(255, 17, 17, 17)),
                controller: mail,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: saved, child: Text("saved")),
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("users").snapshots(),
              builder: (context, snapshot) {
                // List<Column> showdata = [];
                if (snapshot.hasData) {
                  // final docs = snapshot.data!.docs.reversed.toList();
                  // for (var doc in docs) {
                  //   // Map<String, dynamic> data = {
                  //   //   "name": doc["name"],
                  //   //   "mail": doc["mail"]
                  //   // };
                  //   final data = Column(mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [Text(doc["name"]), Text(doc["mail"])],
                  //   );
                  //   showdata.add(data);
                  // }
                  // return Expanded(
                  //     child: ListView(
                  //   children: showdata,
                  // ));
                  return SizedBox(
                    width: 400,
                    height: 200,
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> showdata =
                            snapshot.data!.docs[index].data()
                                as Map<String, dynamic>;

                        return ListTile(
                          title: Text(showdata["name"]),
                          subtitle: Text(showdata["mail"]),
                        );
                      },
                    ),
                  );
                } else {
                  return Text("nodata");
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
