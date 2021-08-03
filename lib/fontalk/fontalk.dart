import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

part 'account.dart';
part 'talks.dart';

class Fontalk {
  late String host = "softbank060076071178.bbtec.net";
  late FirebaseApp firebaseApp;
  late FirebaseAuth firebaseAuth;
  late FirebaseMessaging firebaseMessaging;
  late Account account;
  late Talks talks;

  Fontalk._(this.firebaseApp) {
    this.firebaseAuth = FirebaseAuth.instanceFor(app: this.firebaseApp);
    this.firebaseMessaging = FirebaseMessaging.instance;
    this.firebaseMessaging.app = this.firebaseApp;
    this.account = Account(this);
    this.talks = Talks(this);
  }

  static Future<Fontalk> initialize() async {
    await Firebase.initializeApp();
    Fontalk instance = Fontalk._(Firebase.apps.first);
    while (true) {
      try {
        await instance.send('/test');
        break;
      } on SocketException {
        print("error");
      }
      await Future.delayed(Duration(seconds: 10));
    }
    return instance;
  }

  Future<Map<String, dynamic>> send(String path,
      [Map<String, dynamic> data = const <String, dynamic>{}]) async {
    //Uri url = Uri.https(this.host, path);
    Uri url = Uri.http("192.168.3.200", path);
    String body = json.encode(data);
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    if (await this.account.isSignedIn()) {
      headers["Authorization"] =
          "Bearer ${await this.account.user!.getIdToken()}";
    }
    http.Response temp = await http.post(url, body: body, headers: headers);
    Map<String, dynamic> response = json.decode(temp.body);
    print("$path: ${data.toString()} -> ${response.toString()}");
    return response;
  }
}
