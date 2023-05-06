import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../constants/spinkit.dart';
import '../providers/facebooksigninprovider..dart';
import '../providers/googlesigninprovider.dart';
import 'authservice_screen..dart';


class LoginScreen extends StatefulWidget {
  static const routeName = '/loginScreen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final fireStore = FirebaseFirestore.instance;
  bool isLoggedIn = false;
  Map userObj = {};

  @override
  Widget build(BuildContext context) {
    var googleProvider = Provider.of<GoogleSignInProvider>(context, listen: false);
    var facebookProvider = Provider.of<FacebookSignInProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: backgroundColorLoginScreen,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 200),
              child: Image.asset("assets/images/wosh.png"),
            ),
            const SizedBox(
              height: 100,
            ),
            InkWell(
              onTap: () async {
                await AuthService().signInWithFacebook();
                facebookProvider.signInWithFacebook(context);
              },
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                margin:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50),
                decoration: BoxDecoration(
                    color: singInWithFacebookButtonColor,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        offset: Offset(0, 0.1),
                        blurRadius: 10.0,
                      )
                    ]),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    const Icon(
                      FontAwesomeIcons.squareFacebook,
                      color: facebookColor,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Sign in with Facebook",
                      style: GoogleFonts.openSans(
                          color: facebookLogoColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
            Center(
                child: Consumer<GoogleSignInProvider>(
                  builder: (context, authProvider, child) => authProvider.isLoading
                      ?  Loading()
                      : InkWell(
                    onTap: () {
                      googleProvider.googleLogIn(context);
                    },
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      margin:
                      const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50),
                      decoration: BoxDecoration(
                          color: singInWithFacebookButtonColor,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black38,
                              offset: Offset(0, 0.1),
                              blurRadius: 10.0,
                            )
                          ]),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Image.asset(
                            "assets/images/googlelogo.png",
                            height: 30,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Sign in with Google",
                            style: GoogleFonts.openSans(
                                color: singInWithGoogleButtonColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                )
            )

            // InkWell(
            //   onTap: () {
            //     // AuthService().signInWithGoogle().then((value) {
            //     //   fireStore
            //     //       .collection('users')
            //     //       .doc('auth')
            //     //       .collection('googleUsers')
            //     //       .add({
            //     //     'name': AuthService().name,
            //     //     'email': AuthService().email,
            //     //     'phoneNo': AuthService().phoneNo,
            //     //     'imageUrl': AuthService().imageUrl
            //     //   });
            //     //   Navigator.push(
            //     //       context,
            //     //       PageTransition(
            //     //           type: PageTransitionType.topToBottom,
            //     //           duration: const Duration(milliseconds: 1000),
            //     //           alignment: Alignment.bottomCenter,
            //     //           child: const MyVehicles()));
            //     // }).catchError((e) {
            //     //   print(e);
            //     //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //     //       backgroundColor: Colors.redAccent,
            //     //       dismissDirection: DismissDirection.startToEnd,
            //     //       content: Text(
            //     //         e.toString(),
            //     //         style:
            //     //             const TextStyle(color: Colors.white, fontSize: 17),
            //     //       )));
            //     // });
            //     googleProvider.googleLogIn(context);
            //   },
            //   child: Container(
            //     height: 60,
            //     width: MediaQuery.of(context).size.width,
            //     margin:
            //     const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50),
            //     decoration: BoxDecoration(
            //         color: singInWithFacebookButtonColor,
            //         borderRadius: BorderRadius.circular(8.0),
            //         boxShadow: const [
            //           BoxShadow(
            //             color: Colors.black38,
            //             offset: Offset(0, 0.1),
            //             blurRadius: 10.0,
            //           )
            //         ]),
            //     child: Row(
            //       children: [
            //         const SizedBox(
            //           width: 20,
            //         ),
            //         Image.asset(
            //           "assets/images/googlelogo.png",
            //           height: 30,
            //         ),
            //         const SizedBox(
            //           width: 20,
            //         ),
            //         Text(
            //           "Sign in with Google",
            //           style: GoogleFonts.openSans(
            //               color: singInWithGoogleButtonColor,
            //               fontWeight: FontWeight.bold,
            //               fontSize: 18),
            //         )
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
