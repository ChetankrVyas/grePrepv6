import 'package:chatgptv6/homeScreen.dart';
import 'package:chatgptv6/loginScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  List<String> alpha = [
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n' ',o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z'
  ];
  TextEditingController _otp = TextEditingController();
  // FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> findUserExist(String uid) async {
    bool ans = false;
    print("UID:  ${uid}");

    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        print("DOC ID : ${doc['uid']}");
        if (doc['uid'] == uid) {
          ans = true;
        }
      });
    });
    // await FirebaseFirestore.instance.collection('users').snapshots()
    return ans;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GRE prep'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff74235d)),
                      ),
                      hintText: 'OTP'),
                  controller: _otp,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () async {
                  await Firebase.initializeApp();

                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: LoginScreen.verifyId, smsCode: _otp.text);
                  await FirebaseAuth.instance.signInWithCredential(credential);
                  String uid =
                      FirebaseAuth.instance.currentUser!.uid.toString();
                  bool userCheck = await findUserExist(uid);

                  if (!userCheck) {
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(uid)
                        .set({
                      "uid": uid,
                    });
                    for (String char in alpha) {
                      FirebaseFirestore.instance
                          .collection(char)
                          .get()
                          .then((QuerySnapshot snapshot) {
                        snapshot.docs.forEach((doc) {
                          final userRef = FirebaseFirestore.instance
                              .collection("usersData");
                          userRef.doc(uid).collection(char).add({
                            "word": doc['word'],
                            "meaning": doc['meaning'],
                            "example": doc['example',
                          });
                        });
                      });
                    }
                  }
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                      (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
                  primary: Color(0xff74235d),
                ),
                child: Text("Verify")),
          ],
        ),
      ),
    );
  }
}
