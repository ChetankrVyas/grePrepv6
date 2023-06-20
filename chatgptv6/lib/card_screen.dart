import 'dart:collection';

import 'package:chatgptv6/word.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CardScreen extends StatefulWidget {

  const CardScreen({Key? key, required this.aplhabet ,required this.queueWords,required this.ttWords}) : super(key: key);
  final String aplhabet;
  // final List<Word> listWords;
  final int ttWords;
  final Queue<Word> queueWords;
  @override

  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  int index = 0;

  bool answer = false;

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
              child: widget.queueWords.isEmpty ? Container(child: const Text('Words Completed'),) : !answer
                  ? Container(
                      height: MediaQuery.of(context).size.height*0.6,
                      decoration: const BoxDecoration(
                        color: Color(0xff74235d),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Spacer(),
                            Text(widget.queueWords.first.word, style: const TextStyle(color: Colors.white, fontSize: 30),),
                            /// Word
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        answer = !answer;
                                      });
                                    },
                                    child: const Text("See meaning")),
                                ElevatedButton(
                                    onPressed: () {///
                                      // String uid = FirebaseAuth.instance.currentUser!.uid.toString();
                                      String uid = "yrt62k4tViW9aJ3cxpbv3jgMdg83";
                                      FirebaseFirestore.instance.collection("usersData").doc(uid).collection(widget.aplhabet).doc(widget.queueWords.first.id).delete().then((doc)=>print("Delete Word successfully"));
                                      setState(() {
                                        widget.queueWords.removeFirst();
                                      });
                                    },
                                    child: const Text('I know this word'))
                              ],
                            ),
                          ],
                        ),
                    ),
                  )
                  : Container(
                height: MediaQuery.of(context).size.height*0.6,
                decoration: const BoxDecoration(
                  color: Color(0xff74235d),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RichText(text: TextSpan(
                                text: "Word : ",
                                style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),
                                children: [
                                  TextSpan(
                                    text: widget.queueWords.first.word,
                                    style:const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.normal),
                                  )
                                ]
                              )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RichText(text: TextSpan(
                                  text: "Meaning : ",
                                  style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),
                                  children: [
                                    TextSpan(
                                      text: widget.queueWords.first.meaning,
                                      style:const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.normal),
                                    )
                                  ]
                              )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RichText(text: TextSpan(
                                  text: "Example : ",
                                  style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),
                                  children: [
                                    TextSpan(
                                      text: widget.queueWords.first.example,
                                      style:const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.normal),
                                    )
                                  ]
                              )),
                            ),
                          const Spacer(),

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

                              }, child: const Text('Next Word')),
                            ),
                          ],
                        ),
                    ),
                  ),
            ),
          ),
          Container(
            child: Row(
              children: [
                Text("Words Learned : ${widget.queueWords.length.toInt()}"),
                Text('Total Words : ${widget.ttWords}'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
