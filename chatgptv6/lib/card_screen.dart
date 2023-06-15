import 'dart:collection';

import 'package:chatgptv6/word.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class CardScreen extends StatefulWidget {

  const   CardScreen({Key? key, required this.aplhabet ,required this.queueWords}) : super(key: key);
  final String aplhabet;
  // final List<Word> listWords;
  final Queue<Word> queueWords;
  @override

  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  int index = 0;

  bool answer = false;
  int ttWords = 0;
  int doneWords = 0;
  
  // String alphabet = "";
  // List<Word> listWords = [];
  // print(widget.list.word);
  @override

  @override
  Widget build(BuildContext context) {

    // print(widget.listWords);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: widget.queueWords.length == 0 ? Container(child: Text('Words Completed'),) : !answer
                  ? Container(
                      height: MediaQuery.of(context).size.height*0.6,
                      decoration: BoxDecoration(
                        color: Color(0xff74235d),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Spacer(),
                            Text(widget.queueWords.first.word, style: TextStyle(color: Colors.white, fontSize: 30),),
                            /// Word
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        answer = !answer;
                                      });
                                    },
                                    child: Text("See meaning")),
                                ElevatedButton(
                                    onPressed: () {///
                                      // String uid = FirebaseAuth.instance.currentUser!.uid.toString();
                                      String uid = "yrt62k4tViW9aJ3cxpbv3jgMdg83";
                                      FirebaseFirestore.instance.collection("usersData").doc(uid).collection(widget.aplhabet).doc(widget.queueWords.first.id).delete().then((doc)=>print("Delete Word successfully"));
                                      setState(() {
                                        widget.queueWords.removeFirst();
                                      });
                                    },
                                    child: Text('I know this word'))
                              ],
                            ),
                          ],
                        ),
                    ),
                  )
                  : Container(
                height: MediaQuery.of(context).size.height*0.6,
                decoration: BoxDecoration(
                  color: Color(0xff74235d),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RichText(text: TextSpan(
                                text: "Word : ",
                                style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),
                                children: [
                                  TextSpan(
                                    text: '${widget.queueWords.first.word}',
                                    style:TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.normal),
                                  )
                                ]
                              )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RichText(text: TextSpan(
                                  text: "Meaning : ",
                                  style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),
                                  children: [
                                    TextSpan(
                                      text: '${widget.queueWords.first.meaning}',
                                      style:TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.normal),
                                    )
                                  ]
                              )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RichText(text: TextSpan(
                                  text: "Example : ",
                                  style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),
                                  children: [
                                    TextSpan(
                                      text: '${widget.queueWords.first.example}',
                                      style:TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.normal),
                                    )
                                  ]
                              )),
                            ),
                          Spacer(),

                            Center(
                              child: ElevatedButton(onPressed: (){
                                // String uid = FirebaseAuth.instance.currentUser!.uid.toString();
                                // FirebaseFirestore.instance.collection("users").doc(uid).collection(widget.aplhabet).doc(widget.listWords[index].id).delete().then((doc)=>print("Delete Word successfully"));
                                setState(() {
                                  widget.queueWords.add(widget.queueWords.first);
                                  // index++;
                                  widget.queueWords.removeFirst();
                                  answer = !answer;
                                });

                              }, child: Text('Next Word')),
                            ),
                          ],
                        ),
                    ),
                  ),
            ),
          ),
          ElevatedButton(onPressed: ()async{
            await FirebaseAuth.instance.signOut();
            // String uid = FirebaseAuth.instance.currentUser!.uid.toString();
            // print("UID : ${uid}");

          }, child: Text('LOG OUT'))
        ],
      ),
    );
  }
}
