import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
dynamic usuario;
bool is_Sing_In = false;
Future<String> signInWithGoogle() async {
  is_Sing_In = false;
  GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final authResult = await _auth.signInWithCredential(credential);
  final User user = authResult.user;

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final User currentUser = _auth.currentUser;
  assert(user.uid == currentUser.uid);

  usuario = user;
  is_Sing_In = true;
  return 'signInWithGoogle succeeded: $user';
}

optenerusuario() async {
  return usuario;
}

Future<bool> isSingIn() async {
  final currentUser = await _auth.currentUser;
  // final currentUser = googleSignIn.currentUser;
  if (currentUser != null) {
    usuario = currentUser;
  }
  return currentUser != null;
}

// void signOutGoogle() async {
//   await googleSignIn.signOut();
//   usuario = null;
//   print("User Sign Out");
// }

Future<bool> signOutUser() async {
  User user = await _auth.currentUser;
  print('FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2');
  googleSignIn.disconnect();
  usuario = null;
  is_Sing_In = false;
  await _auth.signOut();
  return Future.value(true);
}
