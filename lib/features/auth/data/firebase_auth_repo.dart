import 'package:bloc_clean_architecture/features/auth/domain/entities/app_user.dart';
import 'package:bloc_clean_architecture/features/auth/domain/repos/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<AppUser?> loginWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      //create user
      AppUser user =
          AppUser(uid: userCredential.user!.uid, email: email, name: '');
      return user;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<AppUser?> registerWithEmailPassword(
      String name, String email, String password) async{
   try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      //create user
      AppUser user =
          AppUser(uid: userCredential.user!.uid, email: email, name: '');
      return user;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<AppUser?> getCurrentUser() async {
   final firebaseUser = firebaseAuth.currentUser;

   if(firebaseUser == null){
    return null;
   }

   //user exists
   return AppUser(uid: firebaseUser.uid, email: firebaseUser.email!, name: '');
  }
}
