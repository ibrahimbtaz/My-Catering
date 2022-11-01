import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mycatering/asset/asset.dart';
import 'package:mycatering/login/auth.dart';

class MainProfile extends StatelessWidget {
  MainProfile({Key? key}) : super(key: key);

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _title() {
    return const Text('MainProfile');
  }

  Widget _userUid() {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            backgroundImage:
                Image.network(FirebaseAuth.instance.currentUser!.photoURL ?? "")
                    .image,
            radius: 60,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            FirebaseAuth.instance.currentUser!.displayName ?? "",
            style: const TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            FirebaseAuth.instance.currentUser!.email ?? "",
            style: const TextStyle(fontSize: 20, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _signOutButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: maincolor,
        textStyle:
            TextStyle(color: white, fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      onPressed: signOut,
      child: Text('Sign Out'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _userUid(),
            _signOutButton(),
          ],
        ),
      ),
    );
  }
}
