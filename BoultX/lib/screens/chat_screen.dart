import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

// ignore: deprecated_member_use
final fire = Firestore.instance;
User loggedUser;

class _ChatScreenState extends State<ChatScreen> {
  // ignore: deprecated_member_use

  // ignore: deprecated_member_use
  final auth = FirebaseAuth.instance;
  final messageTextController = TextEditingController();

  String msg;

  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    final usure = await auth.currentUser;
    if (usure != null) {
      loggedUser = usure;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () async {
                await auth.signOut();
                Navigator.pop(context);
                //Implement logout functionality
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Color(0xffff000080),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Bstream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        msg = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageTextController.clear();
                      fire.collection('messages').add({
                        'text': msg,
                        'Sender': loggedUser.email,
                      });
                      //Implement send functionality.
                    },
                    child: Icon(Icons.send_outlined),
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

class Bstream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: fire.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.red,
            ),
          );
        }
        final msgs = snapshot.data.docs.reversed;
        List<Widget> mess = [];
        for (var vrs in msgs) {
          var txt = vrs['text'];
          print(txt);
          var send = vrs['Sender'];
          var cu = loggedUser.email;
          final msgWidget = msgBubble(
            sender: send,
            text: txt,
            isMe: send == cu,
          );
          mess.add(msgWidget);
        }

        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
            children: mess,
          ),
        );
      },
    );
  }
}

class msgBubble extends StatelessWidget {
  msgBubble({this.text, this.sender, this.isMe});
  final text, sender, isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(sender.toString()),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    topLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))
                : BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
            elevation: 20,
            color: isMe ? Colors.blue : Colors.green,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                text,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
