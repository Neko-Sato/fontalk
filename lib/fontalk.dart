import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io' show SocketException;

class Fontalk {
  late String host = "softbank060076071178.bbtec.net";
  late FirebaseApp firebaseApp;
  late FirebaseAuth firebaseAuth;
  late FirebaseMessaging firebaseMessaging;
  late Account account;

  Fontalk._(this.firebaseApp) {
    this.firebaseAuth = FirebaseAuth.instanceFor(app: this.firebaseApp);
    this.firebaseMessaging = FirebaseMessaging.instance;
    this.firebaseMessaging.app = this.firebaseApp;
    this.account = Account(this);
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
    Uri url = Uri.https(this.host, path);
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

class Account {
  late Fontalk fontalk;
  User? get user => this.fontalk.firebaseAuth.currentUser;

  Account(this.fontalk);

  Future<bool> isSignedIn() async {
    return this.user != null;
  }

  Future<String> signIn(AuthCredential credential) async {
    String temp;
    try {
      await this.fontalk.firebaseAuth.signInWithCredential(credential);
      temp = 'successfully-signin';
    } on FirebaseAuthException catch (e) {
      temp = e.code;
    }
    return temp;
  }

  Future<String> register(String email, String password) async {
    String temp;
    try {
      await this
          .fontalk
          .firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      temp = 'new-account';
    } on FirebaseAuthException catch (e) {
      temp = e.code;
    }
    return temp;
  }

  Future<void> signOut() async {
    await this.fontalk.firebaseAuth.signOut();
  }

  Future<void> delete() async {
    await this.fontalk.send('/user/delete');
    await this.user!.delete();
  }

  Future<bool> isAvailableUserId(String value) async {
    Map response = await this
        .fontalk
        .send('/user/is_available_user_id', {'user_id': value});
    return response["message"] == 'Available';
  }

  Future<void> setUp({String? name, String? userId}) async {
    await this.fontalk.send('/user/setup', {'name': name, 'user_id': userId});
  }
}
