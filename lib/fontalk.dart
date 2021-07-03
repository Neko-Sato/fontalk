import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Fontalk {
  late String host;
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
    return Fontalk._(Firebase.apps.first);
  }

  Future<Map<String, dynamic>> send(String path,
      [Map<String, String> data = const <String, String>{}]) async {
    Uri url = Uri.http(this.host, path);
    String body = json.encode(data);
    Map<String, String> headers = {
      "Authorization": "Bearer ${await this.account.user!.getIdToken()}",
      "Content-Type": "application/json",
    };
    http.Response temp = await http.post(url, body: body, headers: headers);
    Map<String, dynamic> response = json.decode(temp.body);
    print(response.toString());
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
    await this.user!.delete();
  }
}
