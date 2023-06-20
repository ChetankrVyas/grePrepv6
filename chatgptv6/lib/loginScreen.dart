import 'package:chatgptv6/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static String verifyId = "";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text("+91 "),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                child: TextField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff74235d)),
                      ),
                      hintText: '+91 Enter Mobile Number'),
                  controller: _phoneNumber,
                ),
              ), 
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
                onPressed: () async {
                  await Firebase.initializeApp();
                  // await FirebaseAuth.instance.signOut();
                  print(_phoneNumber.text);
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: '+91 ${_phoneNumber.text}',
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException e) {
                      print("Error: ${e.message}");
                    },
                    codeSent: (String verificationId, int? resendToken) {
                      print("Code Send");
                      LoginScreen.verifyId = verificationId;
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const OtpScreen()));
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {},
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: const Color(0xff74235d),
                ),
                child: const Text("Sign In"))
          ],
        ),
      ),
    );
  }
}
