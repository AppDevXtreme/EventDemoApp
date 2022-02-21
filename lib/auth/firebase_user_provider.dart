import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class PlusOneFirebaseUser {
  PlusOneFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

PlusOneFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<PlusOneFirebaseUser> plusOneFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<PlusOneFirebaseUser>(
        (user) => currentUser = PlusOneFirebaseUser(user));
