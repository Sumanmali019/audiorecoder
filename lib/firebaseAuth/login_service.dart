import 'package:audiorecoed/firebaseAuth/export_firebase.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

String? uid;
String? userEmail;

class Authentication {
  loginservice() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return const Homepage();
        } else {
          return const Singup();
        }
      },
    );
  }

  signup(String emailID, String password) async {
    await Firebase.initializeApp();
    User? user;
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailID,
        password: password,
      );
      user = userCredential.user;
      if (user != null) {
        uid = user.uid;
        userEmail = user.email;
        Get.to(() => const Homepage());
      }
      print('Logged in successfully');
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak password':
          const SnackBar(content: Text('The password provided is too weak'));
          break;
        case 'email-already-in-use':
          const SnackBar(
              content: Text('The account already exists for that email.'));
          break;
        default:
          print('error');
      }
    }
  }

  signin(String emailID, String password) async {
    User? user;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailID,
        password: password,
      );
      user = userCredential.user;
      if (user != null) {
        uid = user.uid;
        userEmail = user.email;
        Get.to(() => const Homepage());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    }
  }

  signOut() async {
    await _auth.signOut();
    uid = null;
    userEmail = null;
    Get.to(() => const Singup());
    return 'User signed out';
  }
}
