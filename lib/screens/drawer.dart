import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ramipartnerapp/shareedpreference/share_preference.dart';
import 'constants/colors.dart';
import 'myprofile.dart';
import 'myschedule.dart';
import 'myworkinghours.dart';


class MyDrawer extends StatefulWidget {
  static const routeName = '/myDrawer';
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  var currentPage = DrawerSections.myschedule;


  String name = "User Name";
  String emailStatic = "User@gmail.com";

  String? nickName = MySharedPrefClass.preferences?.getString('nickName');
  String? email = MySharedPrefClass.preferences?.getString('email');



  // TODO Text Widget For Changing AppBar
  Widget appBarText(){
    if(currentPage == DrawerSections.profile){
      return const Text(
        "My Profile",
        style: TextStyle(
            color: singInWithGoogleButtonColor,
            fontWeight: FontWeight.w600,
            fontSize: 20.0),
      );
    } else if (currentPage == DrawerSections.myschedule){
      return const Text(
        "My Schedule",
        style: TextStyle(
            color: singInWithGoogleButtonColor,
            fontWeight: FontWeight.w600,
            fontSize: 20.0),
      );
    } else if (currentPage == DrawerSections.myworkinghours){
      return const Text(
        "My Workinghours",
        style: TextStyle(
            color: singInWithGoogleButtonColor,
            fontWeight: FontWeight.w600,
            fontSize: 20.0),
      );
    } else if (currentPage == DrawerSections.logout){
      return const Text(
        "Logout",
        style: TextStyle(
            color: singInWithGoogleButtonColor,
            fontWeight: FontWeight.w600,
            fontSize: 20.0),
      );
    }
    else {
      return const Text(
        "Dashboard",
        style: TextStyle(
            color: singInWithGoogleButtonColor,
            fontWeight: FontWeight.w600,
            fontSize: 20.0),
      );
    }
  }

  @override
  Widget build(BuildContext context) {


    var container;
    if (currentPage == DrawerSections.profile) {
      container = const ProfileScreen();
    } else if (currentPage == DrawerSections.myschedule) {
      container = const MyScheduleScreen();
    } else if(currentPage == DrawerSections.myworkinghours){
      container = const MyWorkingHours();
    }else if(currentPage == DrawerSections.logout){
      container = const ProfileScreen();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColorLoginScreen,
        iconTheme: const IconThemeData(color: singInWithGoogleButtonColor),
        title: appBarText(),
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  singInWithFacebookButtonColor,
                  singInWithFacebookButtonColor
                ])),
            child: Column(
              children: [

                UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(
                      color: singInWithFacebookButtonColor
                  ),
                  accountName: Text(
                    nickName!.isEmpty ? name : nickName! ,
                    style: const TextStyle(
                        color: singInWithGoogleButtonColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w800),
                  ),
                  accountEmail: Text(
                    email!.isEmpty ? emailStatic : email!,
                    style: const TextStyle(
                      color: singInWithGoogleButtonColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                MyDrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget MyDrawerList() {
    return Container(
      padding: const EdgeInsets.only(top: 40),
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              singInWithFacebookButtonColor,
              singInWithFacebookButtonColor
            ])),
        child: Column(
          // shows the list of menu drawer
          children: [
            menuItem(1, "Profile", Icons.person,
                currentPage == DrawerSections.profile ? true : false),
            const Divider(thickness: 2),
            menuItem(2, "My Schedule", Icons.remember_me,
                currentPage == DrawerSections.myschedule ? true : false),
            const Divider(thickness: 2),
            menuItem(3, "My Working Hours", Icons.calendar_month,
                currentPage == DrawerSections.myworkinghours ? true : false),
            const Divider(thickness: 2),
            menuItem(4, "Logout", Icons.logout_outlined,
                currentPage == DrawerSections.logout ? true : false
            ),
            const Divider(thickness: 2),
          ],
        ),
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? backgroundColorLoginScreen1 : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.profile;
            } else if (id == 2) {
              currentPage = DrawerSections.myschedule;
            } else if(id == 3){
              currentPage = DrawerSections.myworkinghours;
            }else if(id == 4){
              currentPage = DrawerSections.logout;
            }
            else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Wrong Choice")));
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: singInWithGoogleButtonColor,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: const TextStyle(
                      color: singInWithGoogleButtonColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  profile,
  myschedule,
  myworkinghours,
  logout,
}
