import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class FlutterEventAppFirebaseUser {
  FlutterEventAppFirebaseUser(this.user);
  final User user;
  bool get loggedIn => user != null;
}

FlutterEventAppFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<FlutterEventAppFirebaseUser> flutterEventAppFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<FlutterEventAppFirebaseUser>(
            (user) => currentUser = FlutterEventAppFirebaseUser(user));
