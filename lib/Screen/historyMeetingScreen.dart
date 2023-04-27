import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uni_talk/resources/firestore_methods.dart';

class HistoryMeetingScreen extends StatelessWidget {
  const HistoryMeetingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirestoreMethods().meetingsHistory,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: (snapshot.data! as dynamic).docs.length,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(50))),
                        tileColor: Color.fromARGB(255, 229, 243, 250),
                        leading: Icon(
                          Icons.history,
                          size: 30,
                          color: Colors.black,
                        ),
                        title: Text(
                          "Room No: ${(snapshot.data! as dynamic).docs[index]['roomName']}",
                          style: TextStyle(fontSize: 22),
                        ),
                        subtitle: Text(
                            "Joined on: ${DateFormat.yMMMd().format((snapshot.data! as dynamic).docs[index]['createdAt'].toDate())}",
                            style: TextStyle(fontSize: 16)),
                      ),
                    )),
          );
        });
  }
}
