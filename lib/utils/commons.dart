import 'dart:convert';



import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:naql/utils/app_colors.dart';
import 'package:toast/toast.dart';



class Commons {
  // static const baseURL = "https://api.chucknorris.io/";

  // static const tileBackgroundColor = const Color(0xFFF1F1F1);
  // static const chuckyJokeBackgroundColor = const Color(0xFFF1F1F1);
  // static const chuckyJokeWaveBackgroundColor = const Color(0xFFA8184B);
  // static const gradientBackgroundColorEnd = const Color(0xFF601A36);
  // static const gradientBackgroundColorWhite = const Color(0xFFFFFFFF);
  // static const mainAppFontColor = const Color(0xFF4D0F29);
  // static const appBarBackGroundColor = const Color(0xFF4D0F28);
  // static const categoriesBackGroundColor = const Color(0xFFA8184B);
  // static const hintColor = const Color(0xFF4D0F29);
  // static const mainAppColor = const Color(0xFF4D0F29);
  // static const gradientBackgroundColorStart = const Color(0xFF4D0F29);
  // static const popupItemBackColor = const Color(0xFFDADADB);

  static Widget chuckyLoader() {
    return Center(child: SpinKitFoldingCube(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven ? Color(0xFFFFFFFF) : Color(0xFF311433),
          ),
        );
      },
    ));
  }

  static void showError(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(message,style: TextStyle(
                color: Colors.black,
                fontSize: 15
              ),),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15)),
              actions: <Widget>[
                FlatButton(
                  child: Text("Ok"),
                  textColor: Colors.black,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  static Widget chuckyLoading(String message) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(padding: EdgeInsets.all(10), child: Text(message)),
        chuckyLoader(),
      ],
    );
  }



  static void  showToast(BuildContext context, {@required  String message,Color color}) {
  return Toast.show(message, context,
      backgroundColor: color == null ? mainAppColor: color,
      duration: Toast.LENGTH_LONG,
      gravity: Toast.BOTTOM);
}

  // static Future logout(BuildContext context) async {
  //   final storage = new FlutterSecureStorage();
  //   await storage.deleteAll();

  //   Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(builder: (context) => LoginScreen()));
  // }


// handleUnauthenticated(BuildContext context) {
//   showDialog(
//       barrierDismissible: false, // user must tap button!
//       context: context,
//       builder: (_) {
//         return ResponseAlertDialog(
//           alertTitle: 'عفواً',
//           alertMessage: 'يرجي تسجيل الدخول مجدداً',
//           alertBtn: 'موافق',
//           onPressedAlertBtn: () {
//             Navigator.pop(context);
//             SharedPreferencesHelper.remove("user");
//             Navigator.of(context).pushNamedAndRemoveUntil(
//                 '/login_screen', (Route<dynamic> route) => false);
//           },
//         );
//       });
// }

// showErrorDialog(var message, BuildContext context) {
//   showDialog(
//       barrierDismissible: false, // user must tap button!
//       context: context,
//       builder: (_) {
//         return ResponseAlertDialog(
//           alertTitle: 'عفواً',
//           alertMessage: message,
//           alertBtn: 'موافق',
//           onPressedAlertBtn: () {},
//         );
//       });
// }

// showToast(String message, context, {Color color}) {
//   return Toast.show(message, context,
//       backgroundColor: color == null ? cPrimaryColor : color,
//       duration: Toast.LENGTH_LONG,
//       gravity: Toast.BOTTOM);
// }

 static String mapStyles = '''[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dadada"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#c9c9c9"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]''';

}
