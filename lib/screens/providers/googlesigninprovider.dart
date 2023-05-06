// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:page_transition/page_transition.dart';
// import '../../api/api_screen.dart';
// import '../../shareedpreference/share_preference.dart';
// import '../authentication/login_partner_screen.dart';
// import '../authentication/login_screen.dart';
//
//
// class GoogleSignInProvider with ChangeNotifier{
//
//   ApiScreen apiScreen = ApiScreen();
//
//   String? loginWith = "Google";
//   String? methodUID;
//   String? password;
//   String? email;
//   String? name;
//   String? photoUrl;
//
//
//   final googleSignIn = GoogleSignIn(scopes: ['email', 'profile', 'openid', 'https://www.googleapis.com/auth/user.phonenumbers.read']);
//   final auth = FirebaseAuth.instance;
//
//   User? user1 =  FirebaseAuth.instance.currentUser;
//
//   bool _isLoading = false;
//   bool get isLoading => _isLoading;
//
//   set isLoading(bool value) {
//     _isLoading = value;
//     notifyListeners();
//   }
//
//   GoogleSignInAccount? _user;
//   GoogleSignInAccount get user => _user!;
//
//
//   // TODO For Login
//   Future googleLogIn(context) async{
//
//     DateTime now = DateTime.now();
//     Duration offset = now.timeZoneOffset;
//
//     String utcHourOffset = (offset.isNegative ? '-' : '+') +
//         offset.inHours.abs().toString().padLeft(2, '0');
//     String utcMinuteOffset = (offset.inMinutes - offset.inHours * 60)
//         .toString().padLeft(2, '0');
//
//     String dateTimeWithOffset = '$utcHourOffset:$utcMinuteOffset';
//     print(dateTimeWithOffset);
//
//     try{
//       isLoading = true;
//       final googleUser = await googleSignIn.signIn();
//       if(googleUser == null) return;
//       _user = googleUser;
//
//       final googleAuth = await googleUser.authentication;
//
//       final credential = GoogleAuthProvider.credential(
//           accessToken: googleAuth.accessToken,
//           idToken: googleAuth.idToken
//       );
//
//       final UserCredential authResult = await auth.signInWithCredential(credential);
//       final User? user = authResult.user;
//
//
//       print("name ${user?.displayName}");
//       print("email ${user?.email}");
//       print("methodUID ${user?.uid}");
//       print("photo ${user?.photoURL}");
//       print("Phone Number ${user?.providerData}");
//       print("of set $dateTimeWithOffset");
//
//
//       password = user?.uid;
//       email = user?.email;
//       name = user?.displayName;
//       photoUrl = user?.photoURL;
//       methodUID = user?.uid;
//
//       // for(var i in user!.providerData){
//       //   print(i.providerId);
//       // }
//
//       if(_user != null){
//         apiScreen.addPartner(
//             loginWith.toString(),
//             methodUID, password,
//             email,
//             name, photoUrl,
//             dateTimeWithOffset.toString(),
//             context);
//
//
//       }return;
//
//
//     }catch(e){
//       print(e.toString());
//       ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//               backgroundColor: Colors.redAccent,
//               dismissDirection: DismissDirection.startToEnd,
//               behavior: SnackBarBehavior.floating,
//               margin: EdgeInsets.only(
//                   bottom: MediaQuery.of(context).size.height - 200,
//                   right: 20,
//                   left: 20
//               ),
//               content: Text(e.toString(),
//                 style: const TextStyle(color: Colors.white,
//                     fontSize: 17, fontWeight: FontWeight.w600),)));
//     } finally{
//       isLoading = false;
//     }
//     notifyListeners();
//   }
//
//   // TODO For Logout
//   Future logout(context) async{
//     await googleSignIn.disconnect();
//     FirebaseAuth.instance.signOut();
//     MySharedPrefClass.preferences!.setBool("loggedIn", false);
//     Navigator.push(
//         context,
//         PageTransition(
//             type: PageTransitionType.topToBottom,
//             duration: const Duration(milliseconds: 1000),
//             alignment: Alignment.bottomCenter,
//             child: const LoginScreen()));
//     notifyListeners();
//   }
//
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../api/api_screen.dart';
import '../../shareedpreference/share_preference.dart';



class GoogleSignInProvider with ChangeNotifier {

  ApiScreen apiScreen = ApiScreen();

  String? loginWith = "Google";
  String? methodUID;
  String? password;
  String? email;
  String? name;
  String? photoUrl;


  final googleSignIn = GoogleSignIn(scopes: [
    'email',
    'profile',
    'openid',
    'https://www.googleapis.com/auth/user.phonenumbers.read'
  ]);
  final auth = FirebaseAuth.instance;

  User? user1 = FirebaseAuth.instance.currentUser;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;


  // TODO For Login
  Future googleLogIn(context) async {
    DateTime now = DateTime.now();
    Duration offset = now.timeZoneOffset;

    // ----------
    String dateTime = now.toIso8601String();
    // - or -
    // String dateTime = intl.DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(now);
    // ----------
    String utcHourOffset = (offset.isNegative ? '-' : '+') +
        offset.inHours.abs().toString().padLeft(2, '0');
    String utcMinuteOffset = (offset.inMinutes - offset.inHours * 60)
        .toString().padLeft(2, '0');

    String dateTimeWithOffset = '$utcHourOffset:$utcMinuteOffset';
    print(dateTimeWithOffset);

    try {
      isLoading = true;
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken
      );

      final UserCredential authResult = await auth.signInWithCredential(
          credential);
      final User? user = authResult.user;


      print("name ${user?.displayName}");
      print("email ${user?.email}");
      print("methodUID ${user?.uid}");
      print("photo ${user?.photoURL}");
      print("Phone Number ${user?.providerData}");
      print("Offset $dateTimeWithOffset");

      password = user?.uid;
      email = user?.email;
      name = user?.displayName;
      photoUrl = "";
      methodUID = user?.uid;


      // for(var i in user!.providerData){
      //   print(i.providerId);
      // }

      if (_user != null) {
        MySharedPrefClass.preferences?.setString("Email", email!);
        MySharedPrefClass.preferences?.setString("Name", name!);
        MySharedPrefClass.preferences?.setString("Password", password!);

        apiScreen.addPartner(
            loginWith.toString(),
            methodUID,
            password,
            email,
            name,
            photoUrl,
            dateTimeWithOffset,
            context
        );
      } else {
        Navigator.pop(context);
      }
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.redAccent,
              dismissDirection: DismissDirection.startToEnd,
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(
                  bottom: MediaQuery
                      .of(context)
                      .size
                      .height - 200,
                  right: 20,
                  left: 20
              ),
              content: Text(e.toString(),
                style: const TextStyle(color: Colors.white,
                    fontSize: 17, fontWeight: FontWeight.w600),)));
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }
}