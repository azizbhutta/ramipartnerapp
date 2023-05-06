import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:ramipartnerapp/model/schedule_model.dart';
import '../screens/authentication/login_screen.dart';
import '../screens/drawer.dart';
import '../shareedpreference/share_preference.dart';


class ApiScreen {

var data;
bool isLoggedIn = false;

// TODO List Of GetScheduleModelClass
  List<GetScheduleModelClass> scheduleList = [];




// TODO Add Partner
addPartner(String? loginWith, methodUID, password, email, name, photoUrl,offset,
    context) async {
  print("My loginWith $loginWith");
  print("My methodUID $methodUID");
  print("My password $password");
  print("My email $email");
  print("My name $name");
  print("photoUrl $photoUrl");
  print("of set $offset");


  MySharedPrefClass.preferences?.setString('nickName', name);
  MySharedPrefClass.preferences?.setString('email', email);

  Map<String, dynamic> addPartnerBody = {
    "loginWith": loginWith,
    "methodUID": methodUID,
    "password": password,
    "email": email,
    "name": name,
    "photoUrl": photoUrl,
    "utcTimeZoneOffset": offset,

  };

  try {
    final response = await http.post(
      Uri.parse('https://wosh-dev.herokuapp.com/api/partner/addPartner'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(addPartnerBody),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      print("Data $data");
      print("Partner Added Successfully");
      print(data["id"]);
      print(data["result"]);
      MySharedPrefClass.preferences?.setString("partnerID", data["id"]);
      Fluttertoast.showToast(
          msg: "Partner Added Successfully",
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 18);
      Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.topToBottom,
              duration: const Duration(milliseconds: 1000),
              alignment: Alignment.bottomCenter,
              child:  MyDrawer()));
    } else {
      print("Failed");
      Fluttertoast.showToast(
          msg: response.body,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 18);
    }
  } catch (e) {
    print(e.toString());
    Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 18);
  }
}

// TODO Partner Login
partnerLogin(String username, password, context) async {
  print("My Username $username");
  print("My Password $password");

  try {
    print("Hello ${MySharedPrefClass.preferences!.getString("id")}");
    final response = await http.post(
        Uri.parse(
            'https://wosh-dev.herokuapp.com/api/authorization/partner/login'),
        body: {
          "username": username,
          "password": password,
        });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      print("Data $data");
      print("Login Successfully");
      MySharedPrefClass.preferences!.setBool("loggedIn", true);
      MySharedPrefClass.preferences?.setString("Access_Token", data["token"]);
      Fluttertoast.showToast(
          msg: "Login Successfully",
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 18);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyDrawer()));
      // Navigator.pushNamed(context, BottomNavigationBarScreen.routeName);
    } else if (response.statusCode == 401) {
      Fluttertoast.showToast(
          msg: "User with this email is already exist",
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 18);
    }
    else {
      print("Failed");
      Fluttertoast.showToast(
          msg: response.statusCode.toString(),
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 18);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
  } catch (e) {
    print(e.toString());
    Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 18);
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}

// TODO addPartnerExtraDetails
  partnerExtraDetails(String name, phoneNumber, context) async{

    print("My name $name");
    print("My phoneNumber $phoneNumber");
    print("Id is ${MySharedPrefClass.preferences?.getString("partnerID")}");

    Map<String, dynamic> addExtraDetails = {
      "id": MySharedPrefClass.preferences?.getString("partnerID"),
      "nickName": name,
      "preferredPhoneNumber": phoneNumber,
    };

    try {
      final response = await http.post(
        Uri.parse('https://wosh-dev.herokuapp.com/api/partner/addPartnerExtraDetails'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(addExtraDetails)
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print("Data $data");
        print("Extra Details Added");
        Fluttertoast.showToast(
            msg: "Extra Details Added",
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 18);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyDrawer()));
      } else {
        print("Failed");
        Fluttertoast.showToast(
            msg: response.body,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            fontSize: 18);
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 18);
    }
  }


//  TODO GetPartnerExtraDetails

  // getpartnerExtraDetails(String name, phoneNumber, context) async{
  //
  //   print("My name $name");
  //   print("My phoneNumber $phoneNumber");
  //   print("Id is ${MySharedPrefClass.preferences?.getString("partnerID")}");
  //
  //   Map<String, dynamic> getExtraDetails = {
  //     "id": MySharedPrefClass.preferences?.getString("partnerID"),
  //     "nickName": name,
  //     "preferredPhoneNumber": phoneNumber,
  //   };
  //
  //   try {
  //     final response = await http.post(
  //         Uri.parse('https://wosh-dev.herokuapp.com/api/partner/getPartnerExtraDetails'),
  //         headers: <String, String>{
  //           'Content-Type': 'application/json',
  //           'Accept': 'application/json',
  //         },
  //         body: jsonEncode(getExtraDetails)
  //     );
  //
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body.toString());
  //       print("Data $data");
  //       print("Extra Details get");
  //       Fluttertoast.showToast(
  //           msg: "Extra Details get",
  //           backgroundColor: Colors.green,
  //           textColor: Colors.white,
  //           fontSize: 18);
  //       Navigator.pushReplacement(
  //           context, MaterialPageRoute(builder: (context) => MyDrawer()));
  //     } else {
  //       print("Failed");
  //       Fluttertoast.showToast(
  //           msg: response.body,
  //           backgroundColor: Colors.redAccent,
  //           textColor: Colors.white,
  //           fontSize: 18);
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //     Fluttertoast.showToast(
  //         msg: e.toString(),
  //         backgroundColor: Colors.redAccent,
  //         textColor: Colors.white,
  //         fontSize: 18);
  //   }
  // }




  // TODO My Schedule
  Stream<List<GetScheduleModelClass>> mySchedule() async* {

    print("Id is ${MySharedPrefClass.preferences?.getString("partnerID")}");

    Map<String, dynamic> mySchedule = {
      "id": MySharedPrefClass.preferences?.getString("partnerID"),
    };

    try {
      final response = await http.post(
          Uri.parse('https://wosh-dev.herokuapp.com/api/partner/getSchedule'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode(mySchedule)
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print("Data $data");
        print("MySchedule Details");
        for(var i in data){
          scheduleList.add(GetScheduleModelClass.fromJson(i));
        }
        Fluttertoast.showToast(
            msg: "MySchedule Details",
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 18);

      } else {
        print("Failed");
        Fluttertoast.showToast(
            msg: response.body,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            fontSize: 18);
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(
          msg: e.toString(),
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 18);
    }
  }

}