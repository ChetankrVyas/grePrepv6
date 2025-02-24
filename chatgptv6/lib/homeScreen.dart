import 'dart:collection';

import 'package:chatgptv6/card_screen.dart';
import 'package:chatgptv6/word.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  List<String> alpha = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'];
  // List<Word> listWords = [];
  Queue<Word> queueWords = Queue<Word>();
  int ttWords = 0;
  // String uid = "BtRS06qEiBedlPlGP8VzYOBa5Tq2";

  Future<int> getWords(String alphabet) async{
    // String uid = FirebaseAuth.instance.currentUser!.uid.toString();
    ///
    queueWords = Queue<Word>();
    String uid = "yrt62k4tViW9aJ3cxpbv3jgMdg83";
    await FirebaseFirestore.instance.collection("usersData").doc(uid).collection(alphabet).get().then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        // print('he');

        queueWords.add(Word(word: doc['word'], meaning: doc['meaning'], example: doc['example'],id: doc.id.toString()));
      }
    });
    // await FirebaseFirestore.instance.collection('users')
    return 1;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
      ),
      body: ListView.builder(
        itemCount: alpha.length,
          itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async{
                  await Firebase.initializeApp();
                  // print(FirebaseAuth.instance.currentUser!.uid.toString());
                  // if(await getWords(alpha[index]) == 1){
                  await getWords(alpha[index]);
                  String uid = "yrt62k4tViW9aJ3cxpbv3jgMdg83";
                 var document = await FirebaseFirestore.instance.collection('users').doc(uid).get();
                  Map<String, dynamic> ? data= document.data();
                  ttWords = data?['total'][alpha[index]];
                  // print(queueWords.first.word);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CardScreen(aplhabet: alpha[index],queueWords : queueWords,ttWords: ttWords,)));
                  // };
                },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xff74235d),
                      // border: Border.all(),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        // shape: BoxShape.circle
                    ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Practice "${alpha[index]}" set of words',style: const TextStyle(color: Colors.white,fontSize: 18),),
                            const Icon(Icons.arrow_forward_ios_sharp,color: Colors.white,)
                          ],
                        ),
                      )),
              ),
            );
          }
      )
    );
  }
}
