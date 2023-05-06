
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';

class ConvertLatLongToAddressProvider with ChangeNotifier{


  String? address;
  late String formattedDate;

  // TODO Convert TO Address
  converToAddress(double? latitude , longitude) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude!, longitude);
    Placemark placemark = placemarks[0];
    address = '${placemark.street}, ${placemark.locality}, ${placemark.country}';
    notifyListeners();
    print(address);
  }

//  TODO Convert DateTime

  formatDateRange(String? startDatetimeString, String? endDatetimeString) {
    DateTime? startDatetime = DateTime.parse(startDatetimeString!);
    DateTime? endDatetime = DateTime.parse(endDatetimeString!);

    formattedDate = DateFormat('dd MMM, ').format(startDatetime);
    formattedDate += DateFormat('h:mm').format(startDatetime);
    formattedDate += '-' + DateFormat('h:mm a').format(endDatetime).toLowerCase();
    notifyListeners();

    print(formattedDate);
  }



}