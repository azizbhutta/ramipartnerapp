import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ramipartnerapp/api/api_screen.dart';
import 'package:ramipartnerapp/model/schedule_model.dart';
import 'package:ramipartnerapp/screens/providers/converttoaddress_provider.dart';
import 'constants/colors.dart';
import 'constants/spinkit.dart';

class MyScheduleScreen extends StatefulWidget {
  static const routeName = '/myScheduleScreen';
  const MyScheduleScreen({Key? key}) : super(key: key);

  @override
  State<MyScheduleScreen> createState() => _MyScheduleScreenState();
}

class _MyScheduleScreenState extends State<MyScheduleScreen> {
  ApiScreen apiScreen = ApiScreen();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiScreen.scheduleList.clear();
  }




  @override
  Widget build(BuildContext context) {
    apiScreen.scheduleList.clear();
    final convertToAddressProvider =
        Provider.of<ConvertLatLongToAddressProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: singInWithFacebookButtonColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: StreamBuilder(
                  stream: apiScreen.mySchedule(),
                  builder: (context,
                      AsyncSnapshot<List<GetScheduleModelClass>> snapshot) {
                    return ListView.builder(
                        itemCount: apiScreen.scheduleList.length,
                        itemBuilder: (context, index) {
                          // TODO Convert Lat Long Into Addrees
                          convertToAddressProvider.converToAddress(
                              apiScreen.scheduleList[index].latitude,
                              apiScreen.scheduleList[index].longitude);
                          // TODO Convert DateTime
                          convertToAddressProvider.formatDateRange(
                            apiScreen.scheduleList[index].arrivalTimeFrom
                                .toString(),
                            apiScreen.scheduleList[index].arrivalTimeTo
                                .toString(),
                          );
                          // TODO Remove "#" symbol from the start of the hex color code
                          String color = apiScreen.scheduleList[index].reservationEvents![index].statusColor.toString();
                          String cleanedHexColor = color.replaceFirst("#", "");
                          String fullHexColor = "FF$cleanedHexColor";
                          Color containerColor = Color(int.parse(fullHexColor, radix: 16));
                          print(containerColor);
                          // TODO MyStatusText
                          String myStatusText = apiScreen.scheduleList[index].reservationEvents![index].statusText.toString();
                          print(myStatusText);


                          return Column(
                            children: [
                              Container(
                                height: 240,
                                width: MediaQuery.of(context).size.width,
                                // padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 3.0, horizontal: 20.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                    border:
                                        Border.all(color: Colors.grey.shade400),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.4),
                                        offset: const Offset(0.1, 0.1),
                                        blurRadius: 5,
                                      )
                                    ]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      apiScreen
                                          .scheduleList[index].customer!.name
                                          .toString(),
                                      style: const TextStyle(
                                          color: singInWithGoogleButtonColor,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 20.0),
                                    ),
                                    Divider(
                                      color: Colors.grey.withOpacity(0.2),
                                      thickness: 2.0,
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Consumer<ConvertLatLongToAddressProvider>(
                                        builder:
                                            (context, addressProvider, child) {
                                      return Text(
                                        'Location: ${addressProvider.address}',
                                        style: const TextStyle(
                                            color: backgroundColorLoginScreen,
                                            fontSize: 20.0),
                                      );
                                    }),
                                    Divider(
                                      color: Colors.grey.withOpacity(0.2),
                                      thickness: 2.0,
                                    ),
                                    const SizedBox(
                                      height: 4.0,
                                    ),
                                    Text(
                                    convertToAddressProvider.formattedDate.toString(),
                                      style: const TextStyle(
                                          color: backgroundColorLoginScreen,
                                          fontSize: 20.0),
                                    ),
                                    Divider(
                                      color: Colors.grey.withOpacity(0.2),
                                      thickness: 2.0,
                                    ),
                                    const SizedBox(
                                      height: 4.0,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children:  [
                                         Icon(
                                          Icons.circle,
                                          color: containerColor,
                                        ),

                                        const SizedBox(
                                          width: 4.0,
                                        ),
                                        myStatusText == "Pending payment" ?
                                        Column(
                                          children: [
                                            Text(
                                              "Status: ${myStatusText}",
                                              style: const TextStyle(
                                                  color: backgroundColorLoginScreen,
                                                  fontSize: 20.0),
                                            ),

                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              children: [
                                                MaterialButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  minWidth: 150,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(10)),
                                                  color: backgroundColorLoginScreen,
                                                  child: const Text(
                                                    "Confirm",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 17,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                MaterialButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  minWidth: 150,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(10)),
                                                  color: Colors.redAccent,
                                                  child: const Text(
                                                    "Can't Take It",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 17,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ) :Divider(
                                          color: Colors.grey.withOpacity(0.2),
                                          thickness: 2.0,
                                        ),
                                        Text(
                                          "Status: ${myStatusText}",
                                          style: const TextStyle(
                                              color: backgroundColorLoginScreen,
                                              fontSize: 20.0),
                                        )
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          );
                        }) ;
                  }

                  // Column(
                  //   children: [
                  //     Container(
                  //       height: 240,
                  //       width: MediaQuery.of(context).size.width,
                  //       // padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  //       margin: const EdgeInsets.symmetric(
                  //           vertical: 3.0, horizontal: 20.0),
                  //       decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius: BorderRadius.circular(10.0),
                  //           border: Border.all(color: Colors.grey.shade400),
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: Colors.grey.withOpacity(0.4),
                  //               offset: const Offset(0.1, 0.1),
                  //               blurRadius: 5,
                  //             )
                  //           ]),
                  //       child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           const Text(
                  //             "Alex James",
                  //             style: TextStyle(
                  //                 color: singInWithGoogleButtonColor,
                  //                 fontWeight: FontWeight.w600,
                  //                 fontSize: 20.0),
                  //           ),
                  //           Divider(
                  //             color: Colors.grey.withOpacity(0.2),
                  //             thickness: 2.0,
                  //           ),
                  //           const SizedBox(
                  //             height: 10.0,
                  //           ),
                  //           const Text(
                  //             "Location: Hanasi 129 st.,Haifa",
                  //             style: TextStyle(
                  //                 color: backgroundColorLoginScreen,
                  //                 fontSize: 20.0),
                  //           ),
                  //           Divider(
                  //             color: Colors.grey.withOpacity(0.2),
                  //             thickness: 2.0,
                  //           ),
                  //           const SizedBox(
                  //             height: 4.0,
                  //           ),
                  //           const Text(
                  //             "29 Mar, 8:00 - 9:00 PM",
                  //             style: TextStyle(
                  //                 color: backgroundColorLoginScreen,
                  //                 fontSize: 20.0),
                  //           ),
                  //           Divider(
                  //             color: Colors.grey.withOpacity(0.2),
                  //             thickness: 2.0,
                  //           ),
                  //           const SizedBox(
                  //             height: 4.0,
                  //           ),
                  //           Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //             children: const [
                  //               Icon(Icons.circle,color: Colors.yellow,),
                  //                Text(
                  //                 "Status: Waiting for My Confirmation",
                  //                 style: TextStyle(
                  //                     color: backgroundColorLoginScreen,
                  //                     fontSize: 20.0),
                  //               ),
                  //             ],
                  //           ),
                  //           Divider(
                  //             color: Colors.grey.withOpacity(0.2),
                  //             thickness: 2.0,
                  //           ),
                  //           Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //             children: [
                  //               MaterialButton(
                  //                 onPressed: () {
                  //                   Navigator.pop(context);
                  //                 },
                  //                 minWidth: 150,
                  //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  //                 color: backgroundColorLoginScreen,
                  //                 child: const Text(
                  //                   "Confirm",
                  //                   style: TextStyle(
                  //                       fontWeight: FontWeight.bold,
                  //                       fontSize: 17,
                  //                       color: Colors.white),
                  //                 ),
                  //               ),
                  //               const SizedBox(
                  //                 width: 20,
                  //               ),
                  //               MaterialButton(
                  //                 onPressed: () {
                  //                   Navigator.pop(context);
                  //                 },
                  //                 minWidth: 150,
                  //                 shape: RoundedRectangleBorder (borderRadius: BorderRadius.circular(10)),
                  //                 color: Colors.redAccent,
                  //                 child: const Text(
                  //                   "Can't Take It",
                  //                   style: TextStyle(
                  //                       fontWeight: FontWeight.bold,
                  //                       fontSize: 17,
                  //                       color: Colors.white),
                  //                 ),
                  //               ),
                  //             ],
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Expanded(
                  //   child: ListView.builder(
                  //     itemCount: 3,
                  //     itemBuilder: (context, index) {
                  //       return Column(
                  //         children: [
                  //           Container(
                  //             height: 200,
                  //             width: MediaQuery.of(context).size.width,
                  //             // padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  //             margin: const EdgeInsets.symmetric(
                  //                 vertical: 3.0, horizontal: 20.0),
                  //             decoration: BoxDecoration(
                  //                 color: Colors.white,
                  //                 borderRadius: BorderRadius.circular(10.0),
                  //                 border: Border.all(color: Colors.grey.shade400),
                  //                 boxShadow: [
                  //                   BoxShadow(
                  //                     color: Colors.grey.withOpacity(0.4),
                  //                     offset: const Offset(0.1, 0.1),
                  //                     blurRadius: 5,
                  //                   )
                  //                 ]),
                  //             child: Column(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: [
                  //                 const Text(
                  //                   "Alex James",
                  //                   style: TextStyle(
                  //                       color: singInWithGoogleButtonColor,
                  //                       fontWeight: FontWeight.w600,
                  //                       fontSize: 20.0),
                  //                 ),
                  //                 Divider(
                  //                   color: Colors.grey.withOpacity(0.2),
                  //                   thickness: 2.0,
                  //                 ),
                  //                 const SizedBox(
                  //                   height: 10.0,
                  //                 ),
                  //                 const Text(
                  //                   "Location: Hanasi 129 st.,Haifa",
                  //                   style: TextStyle(
                  //                       color: backgroundColorLoginScreen,
                  //                       fontSize: 20.0),
                  //                 ),
                  //                 Divider(
                  //                   color: Colors.grey.withOpacity(0.2),
                  //                   thickness: 2.0,
                  //                 ),
                  //                 const SizedBox(
                  //                   height: 4.0,
                  //                 ),
                  //                 const Text(
                  //                   "29 Mar, 8:00 - 9:00 PM",
                  //                   style: TextStyle(
                  //                       color: backgroundColorLoginScreen,
                  //                       fontSize: 20.0),
                  //                 ),
                  //                 Divider(
                  //                   color: Colors.grey.withOpacity(0.2),
                  //                   thickness: 2.0,
                  //                 ),
                  //                 const SizedBox(
                  //                   height: 4.0,
                  //                 ),
                  //                 Row(
                  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //                   children: const [
                  //                     Icon(Icons.circle,color: Colors.blue,),
                  //                     Text(
                  //                       "Status: Waiting for My Confirmation",
                  //                       style: TextStyle(
                  //                           color: backgroundColorLoginScreen,
                  //                           fontSize: 20.0),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ],
                  //       );
                  //     },
                  //   ),
                  // )
                  ),
            )
          ],
        ),
      ),
    );
  }
}
