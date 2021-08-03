part of 'fontalk.dart';

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

  Future<void> setUp({String? name, String? userId, File? image}) async {
    await this.fontalk.send('/user/setup', {
      'name': name,
      'user_id': userId,
      'image': image == null ? null : await image.readAsBytes(),
    });
  }

  Future<Map<String, dynamic>> info() async {
    var response = await this.fontalk.send('/user/info');
    Map<String, dynamic> data = response["data"];
    if (data['image'] != null) {
      data.update('image', (value) => Uint8List.fromList(value.cast<int>()));
    }
    return data;
  }
}
