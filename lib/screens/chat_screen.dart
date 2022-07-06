import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constant.dart';

import '../message_bubble.dart';
var loggedInUser;
class ChatScreen extends StatefulWidget {
  static String id = 'chat_Screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var msgtext;
  final _fireStore = FirebaseFirestore.instance;

  final _auth = FirebaseAuth.instance;
final msgTextController=TextEditingController();
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    getCurrentUser();
  }

  ////for show email
  getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

////for get message
//   void getMessages() async {
//     var messages = await _fireStore.collection('messages').get(); // Table
//     for (var message in messages.docs) {
//       print(message.data());
//     }
//   }
//
//   void getMessagesStream() async {
//     Stream<QuerySnapshot> snapShots =
//         _fireStore.collection('messages').snapshots();
//     await for (var snapShot in snapShots) {
//       for (var messg in snapShot.docs) {
//         print(messg.data());
//       }
//     }
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
                _auth.signOut();
                Navigator.pop(context);
                //getMessagesStream();
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: _fireStore.collection('messages').snapshots(),
              builder: (context, snapShot) {
                List<Widget> columnListWidget = [];
                  QuerySnapshot table=snapShot.data;
                final rowsMessages =table.docs.reversed; // Rows from the table.
                for (var messeg in rowsMessages) {
                  Map messagMap = messeg.data();
                  var messageText = messagMap['text'];
                  var messageSender = messagMap['sender'];

                  final currentUser=loggedInUser.email;
                  final message = Messages(
                    text: messageText,
                    sender: messageSender,
                    isMe: currentUser==messageSender,
                  );
                  columnListWidget.add(message);
                }
                return Expanded(
                  child: ListView(
                    reverse: true,
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
                    // El shakl Eli 3ala mazagiiiiiiiii
                    children: columnListWidget,
                  ),
                );
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: msgTextController,
                      onChanged: (value) {
                        msgtext = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      msgTextController.clear();
                      _fireStore
                          .collection('messages')
                          .add({'text': msgtext, 'sender': loggedInUser.email});
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


