import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/main.dart';

class Test {
  final int id;
  final int rank;
  final String name;

  Test({required this.id, required this.rank, required this.name});

  factory Test.fromJson(Map<String, dynamic> json) {
    return Test(
      id: json["id"],
      rank: json["rank"],
      name: json["name"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "rank": rank,
      "name": name,
    };
  }
}

class FirebaseFirestoreScreen extends StatelessWidget {
  const FirebaseFirestoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Firebase Firestore"),
      body: ListView(
        children: [
          GestureDetector(
            onTap: () async {
              String _yourDomain = "tyger";
              DynamicLinkParameters dynamicLinkParams = DynamicLinkParameters(
                uriPrefix: "https://$_yourDomain.page.link",
                link: Uri.parse("https://$_yourDomain.page.link/test"),
                androidParameters: const AndroidParameters(
                  packageName: "com.tyger.flutter_velog_sample",
                  minimumVersion: 0,
                ),
              );
              ShortDynamicLink dynamicLink = await FirebaseDynamicLinks.instance
                  .buildShortLink(dynamicLinkParams);

              String url = dynamicLink.shortUrl.toString();
              logger.e(url);
              // FirebaseFirestore _firestore = FirebaseFirestore.instance;
              // for (int i = 0; i < 10; i++) {
              //   await _firestore
              //       .collection("read_test")
              //       .doc()
              //       .set(Test(id: i, rank: i + 1, name: "Tyger$i").toJson());
              // }
            },
            child: Container(
              width: 100,
              height: 60,
              color: Colors.black,
              child: Center(child: Text("C")),
            ),
          )
        ],
      ),
    );
  }
}
