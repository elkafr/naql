import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:naql/custom_widgets/connectivity/network_indicator.dart';
import 'package:naql/locale/app_localizations.dart';
import 'package:naql/models/user.dart';
import 'package:naql/providers/auth_provider.dart';
import 'package:naql/providers/navigation_provider.dart';
import 'package:naql/shared_preferences/shared_preferences_helper.dart';
import 'package:naql/ui/add_ad/widgets/add_ad_bottom_sheet.dart';
import 'package:naql/utils/app_colors.dart';

import 'package:provider/provider.dart';


import 'package:naql/ui/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:naql/utils/app_colors.dart';
import 'package:naql/custom_widgets/dialogs/log_out_dialog.dart';
import 'package:naql/custom_widgets/safe_area/page_container.dart';
import 'package:naql/locale/app_localizations.dart';
import 'package:naql/providers/auth_provider.dart';
import 'package:naql/providers/home_provider.dart';
import 'package:naql/providers/navigation_provider.dart';
import 'package:naql/shared_preferences/shared_preferences_helper.dart';
import 'package:naql/ui/account/about_app_screen.dart';
import 'package:naql/ui/account/app_commission_screen.dart';
import 'package:naql/ui/account/contact_with_us_screen.dart';
import 'package:naql/ui/account/language_screen.dart';
import 'package:naql/ui/account/personal_information_screen.dart';
import 'package:naql/ui/account/terms_and_rules_Screen.dart';
import 'package:naql/ui/my_ads/my_ads_screen.dart';
import 'package:naql/ui/notification/notification_screen.dart';
import 'package:naql/ui/favourite/favourite_screen.dart';
import 'package:naql/ui/my_chats/my_chats_screen.dart';
import 'package:naql/ui/home/home_screen.dart';
import 'package:naql/ui/blacklist/blacklist_screen.dart';
import 'package:naql/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:naql/custom_widgets/safe_area/page_container.dart';
import 'package:naql/locale/app_localizations.dart';
import 'package:naql/providers/auth_provider.dart';
import 'package:naql/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:naql/providers/terms_provider.dart';
import 'package:naql/utils/error.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
 bool _initialRun = true;
   AuthProvider _authProvider;
 NavigationProvider _navigationProvider;
 HomeProvider _homeProvider ;

  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  void _iOSPermission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  void _firebaseCloudMessagingListeners() {
    var android = new AndroidInitializationSettings('mipmap/ic_launcher');
    var ios = new IOSInitializationSettings();
    var platform = new InitializationSettings(android, ios);
    _flutterLocalNotificationsPlugin.initialize(platform);
 
    if (Platform.isIOS) _iOSPermission();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
        _showNotification(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');

        Navigator.pushNamed(context, '/notification_screen');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');

        Navigator.pushNamed(context, '/notification_screen');
      },
    );
  }


 Future onSelectNotification(String payload) async {

   if (payload != null) {

     Navigator.push(
       context,
       MaterialPageRoute(builder: (context) {
         return NotificationScreen();
       }),
     );

   }
   print("notificationClicked");


 }


  _showNotification(Map<String, dynamic> message) async {
    var android = new AndroidNotificationDetails(
      'channel id',
      "CHANNLE NAME",
      "channelDescription",
    );
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await _flutterLocalNotificationsPlugin.show(
        0,
        message['notification']['title'],
        message['notification']['body'],
        platform);
  }



  Future<Null> _checkIsLogin() async {
    var userData = await SharedPreferencesHelper.read("user");
    if (userData != null) {
      _authProvider.setCurrentUser(User.fromJson(userData));
  _firebaseCloudMessagingListeners();
    }
   
  }
  


 

 @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialRun) { 
      _authProvider = Provider.of<AuthProvider>(context);
      _homeProvider = Provider.of<HomeProvider>(context);
       _checkIsLogin();
       _initialRun = false;
      
    }
  }



  @override
  Widget build(BuildContext context) {
    _navigationProvider = Provider.of<NavigationProvider>(context);
    return NetworkIndicator(
        child: Scaffold(
      body: _navigationProvider.selectedContent,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon:  Icon(Icons.home,
              color: Color(0xFFC7C7C7),
            ),
            activeIcon: Icon(Icons.home,
              color: mainAppColor,) ,
            title: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  _authProvider.currentLang=="ar"?"الرئيسية":"Home",
                  style: TextStyle(fontSize: 12.0),
                )),
          ),
          BottomNavigationBarItem(
            icon:  Icon(Icons.favorite,
               color: Color(0xFFC7C7C7),
            ),
             activeIcon: Icon(Icons.favorite,
             color: mainAppColor,) ,
            title: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  AppLocalizations.of(context).translate('favourite'),
                  style: TextStyle(fontSize: 12.0),
                )),
          ),
           BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(7),
              decoration: new BoxDecoration(
                color: mainAppColor,
                shape: BoxShape.circle,
              ),

              child: Image.asset(
                'assets/images/add.png',

              ),
            ),

            title: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Text('',style: TextStyle(height: 0.0),)),
          ),
           BottomNavigationBarItem(
            icon:  Icon(Icons.notifications,
               color: Color(0xFFC7C7C7),
            ),
             activeIcon: Icon(Icons.notifications,
             color: mainAppColor,) ,
            title: (_authProvider.currentUser!=null)?Padding(
                padding: const EdgeInsets.all(1.0),
                child: FutureBuilder<String>(
                    future: Provider.of<HomeProvider>(context,
                        listen: false)
                        .getUnreadNotify() ,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Center(
                            child: SpinKitFadingCircle(color: mainAppColor),
                          );
                        case ConnectionState.active:
                          return Text('');
                        case ConnectionState.waiting:
                          return Center(
                            child: SpinKitFadingCircle(color: mainAppColor),
                          );
                        case ConnectionState.done:
                          if (snapshot.hasError) {
                            return Error(
                              //  errorMessage: snapshot.error.toString(),
                              errorMessage: AppLocalizations.of(context).translate('error'),
                            );
                          } else {
                            return   Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text( AppLocalizations.of(context).translate("notifications"),style: TextStyle(
                                    color: Colors.black,fontSize: 12
                                ),),

                                snapshot.data!="0"?Container(
                                  alignment: Alignment.center,
                                  width: 18,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red),

                                  child: Container(

                                      child: Text( snapshot.data.toString(),style: TextStyle(
                                          color: Colors.white,fontSize: 15,height: 1.6
                                      ),)),
                                ):Text("",style: TextStyle(height: 0),),
                              ],
                            );
                          }
                      }
                      return Center(
                        child: SpinKitFadingCircle(color: mainAppColor),
                      );
                    })):Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  AppLocalizations.of(context).translate('notifications'),
                  style: TextStyle(fontSize: 12.0),
                )),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/chat.png',
              color: Color(0xFFC7C7C7),
            ),
            activeIcon: Image.asset(
              'assets/images/chat.png',
              color: mainAppColor,
            ),
            title: _authProvider.currentUser!=null?Padding(
                padding: const EdgeInsets.all(1.0),
                child: FutureBuilder<String>(
                    future: Provider.of<HomeProvider>(context,
                        listen: false)
                        .getUnreadMessage() ,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Center(
                            child: SpinKitFadingCircle(color: mainAppColor),
                          );
                        case ConnectionState.active:
                          return Text('');
                        case ConnectionState.waiting:
                          return Center(
                            child: SpinKitFadingCircle(color: mainAppColor),
                          );
                        case ConnectionState.done:
                          if (snapshot.hasError) {
                            return Error(
                              //  errorMessage: snapshot.error.toString(),
                              errorMessage: AppLocalizations.of(context).translate('error'),
                            );
                          } else {
                            return   Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text( AppLocalizations.of(context).translate("my_chats"),style: TextStyle(
                                    color: Colors.black,fontSize: 12
                                ),),

                                snapshot.data!="0"?Container(
                                  alignment: Alignment.center,
                                  width: 18,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red),

                                  child: Container(

                                      child: Text( snapshot.data.toString(),style: TextStyle(
                                          color: Colors.white,fontSize: 15,height: 1.6
                                      ),)),
                                ):Text("",style: TextStyle(height: 0),),
                              ],
                            );
                          }
                      }
                      return Center(
                        child: SpinKitFadingCircle(color: mainAppColor),
                      );
                    })):Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  AppLocalizations.of(context).translate('my_chats'),
                  style: TextStyle(fontSize: 12.0),
                )),
          ),


        
        ],
        currentIndex: _navigationProvider.navigationIndex,
        selectedItemColor: mainAppColor,
        unselectedItemColor: Color(0xFFC4C4C4),
        onTap: (int index) {
          if(index == 0 && _navigationProvider.navigationIndex ==0){
            _navigationProvider.setMapIsActive(!_navigationProvider.mapIsActive);
          }else  if ((index == 1 || index == 2 || index == 3 || index == 4) &&
                    _authProvider.currentUser == null){
              
                  Navigator.pushNamed(context, '/login_screen');
              
          } else  if(index == 2){
            showModalBottomSheet<dynamic>(
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    context: context,
                    builder: (builder) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: AddAdBottomSheet());
                    });
          }else{
 _navigationProvider.upadateNavigationIndex(index);
          }
         
          
        },
        elevation: 5,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
      ),
    ));
  }
}
