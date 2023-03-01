import 'package:firebase_auth/firebase_auth.dart';

class FireBaseConstance {
  static var currentUser = FirebaseAuth.instance.currentUser;
}
