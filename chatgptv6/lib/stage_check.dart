import 'package:chatgptv6/homeScreen.dart';
import 'package:chatgptv6/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StageCheck extends StatefulWidget {
  const StageCheck({Key? key}) : super(key: key);

  @override
  State<StageCheck> createState() => _StageCheckState();
}

class _StageCheckState extends State<StageCheck> {
  // FirebaseAuth.instance.
  bool ans = false;
  @override
  void initState() {
    // TODO: implement initState
    Check();
    super.initState();
  }
  void Check() async{
    await Firebase.initializeApp();
    if(FirebaseAuth.instance.currentUser != null){
      setState(() {
        print("a");
        ans =true;
      });
    }else{
      setState(() {
        ans = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return ans ? const HomeScreen() : const LoginScreen() ;
  }
}
