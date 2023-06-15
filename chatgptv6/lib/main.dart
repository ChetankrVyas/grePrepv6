import 'dart:convert';

// import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chatgptv6/homeScreen.dart';
import 'package:chatgptv6/loginScreen.dart';
import 'package:chatgptv6/otp_screen.dart';
import 'package:chatgptv6/stage_check.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
const String chatGptApiKey = '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';
const String chatGptApiUrl = 'https://api.openai.com/v1/completions';
const List<String> messages = ["zealous", "zenith"];
FirebaseFirestore db = FirebaseFirestore.instance;


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   List<String> chatHistory = [];
//   TextEditingController messageController = TextEditingController();
//   @override
//   void initState() {
//     // TODO: implement initState
//     // await Firebase.initializeApp();
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('ChatGPT'),
//       ),
//       // body: Column(
//       //   children: [
//       //     Expanded(
//       //       child: ListView.builder(
//       //         itemCount: chatHistory.length,
//       //         itemBuilder: (context, index) {
//       //           return ListTile(
//       //             title: Text(chatHistory[index]),
//       //           );
//       //         },
//       //       ),
//       //     ),
//       //     Padding(
//       //       padding: EdgeInsets.all(8.0),
//       //       child: Row(
//       //         children: [
//       //           Expanded(
//       //             child: TextField(
//       //               controller: messageController,
//       //               decoration: InputDecoration(
//       //                 hintText: 'Type your message...',
//       //               ),
//       //             ),
//       //           ),
//       //           IconButton(
//       //             icon: Icon(Icons.send),
//       //             onPressed: ()  {
//       //               for(int i = 0; i < 4; i++){
//       //                 sendMessage(messageController.text);
//       //               }
//       //               messageController.clear();
//       //             },
//       //           ),
//       //         ],
//       //       ),
//       //     ),
//       //   ],
//       // ),
//       body: Column(
//         children: [
//           GestureDetector(
//             onTap: () async{
//               for(var message in messages){
//                   await sendMessage(message);
//               }
//               print("DONE : ****************************");
//             },
//             child: Text("Start"),
//           )
//         ],
//       )
//     );
//   }
//
//   Future<void> sendMessage(String word) async {
//     await Firebase.initializeApp();
//     final message = "Explain me the meaning of ${word}. Note that my first language is not english. I have been born and raised in India. Give me only one example and that example should be cutomized to the indian context. Give the output in json format. Use the following two keys: 1.meaning and 2.example. both, the meaning and example should contain simple english words and being and indian i should be able to relate with that example. it will make it easier for me to understand.";
//     Map < String, dynamic > requestBody = {
//       "model": "text-davinci-003",
//       // "messages": [{"role" : "user" , "content" : message}]
//       "prompt" : message,
//       "temperature": 0,
//       "max_tokens": 100,
//     };
//
//     final response = await http.post(
//       Uri.parse(chatGptApiUrl),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $chatGptApiKey',
//       },
//       body:json.encode(requestBody)
//     );
//
//
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       // print("data , ${data}");
//       final reply = data['choices'][0]['text'];
//       // final reply = data['choices'][0]['message']['content'];
//       // print(reply.toString());
//       final result = reply.toString();
//       final jsonData =  jsonDecode((result));
//       final meaning = jsonData['meaning'];
//       final exanple = jsonData['example'];
//       print("Word : ${word}");
//       print("Meaning: ${meaning}");
//       print("Example : ${exanple}");
//
//
//       db.collection("z").add({
//         "word" : word,
//         "meaning" : meaning,
//         "example" : exanple}).then((DocumentReference doc){
//           print("word upload succefully with doc id : ${doc.id}");
//       }).catchError((err) => print("error: ${err}"));
//       // db.collection("a").orderBy("word");
//       // setState(() {
//         // chatHistory.add('ChatGPT: ${reply.toString()}');
//       // });
//     } else {
//       print("failed");
//       setState(() {
//         chatHistory.add('Failed to send message');
//       });
//     }
//   }
// }
//
//
