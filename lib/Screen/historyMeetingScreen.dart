import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uni_talk/resources/firestore_methods.dart';

class HistoryMeetingScreen extends StatefulWidget {
  const HistoryMeetingScreen({super.key});

  @override
  State<HistoryMeetingScreen> createState() => _HistoryMeetingScreenState();
}

class _HistoryMeetingScreenState extends State<HistoryMeetingScreen> {
  bool _isDelayed = true;
  var timer;

  @override
  void initState() {
    _isDelayed = true;
    super.initState();
    timer = Timer(Duration(milliseconds: 1500), () {
      setState(() {
        _isDelayed = false;
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    timer;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (_isDelayed)
        ? Shimmer.fromColors(
            baseColor: Color.fromARGB(255, 0, 17, 255),
            highlightColor: Color.fromARGB(255, 0, 242, 255),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 8,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      dummyShimmer(60, 60),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          dummyShimmer(20, 260),
                          SizedBox(
                            height: 8,
                          ),
                          dummyShimmer(20, 230),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          )
        : StreamBuilder(
            stream: FirestoreMethods().meetingsHistory,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Shimmer.fromColors(
                  baseColor: Color.fromARGB(255, 0, 17, 255),
                  highlightColor: Color.fromARGB(255, 0, 242, 255),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            dummyShimmer(60, 60),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                dummyShimmer(20, 260),
                                SizedBox(
                                  height: 8,
                                ),
                                dummyShimmer(20, 230),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                );
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
                          side: BorderSide(
                              color: Color.fromARGB(255, 171, 215, 245)),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(50),
                              bottomRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10))),
                      tileColor: Color.fromARGB(255, 212, 231, 247),
                      leading: Icon(
                        Icons.history,
                        size: 30,
                        color: Colors.black,
                      ),
                      title: Text(
                        "Room No: ${(snapshot.data! as dynamic).docs[index]['roomName']}",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          "Joined on: ${DateFormat.yMMMd().format((snapshot.data! as dynamic).docs[index]['createdAt'].toDate())}",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey)),
                    ),
                  ),
                ),
              );
            });
  }

  Widget dummyShimmer(double h, double w) {
    return Container(
      height: h,
      width: w,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
