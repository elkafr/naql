import 'package:naql/ui/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:naql/custom_widgets/ad_item/ad_item.dart';
import 'package:naql/custom_widgets/no_data/no_data.dart';
import 'package:naql/custom_widgets/safe_area/page_container.dart';
import 'package:naql/locale/app_localizations.dart';
import 'dart:math' as math;
import 'package:naql/models/ad.dart';
import 'package:naql/providers/favourite_provider.dart';
import 'package:naql/providers/home_provider.dart';
import 'package:naql/ui/ad_details/ad_details_screen.dart';

import 'package:naql/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:naql/utils/error.dart';


import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:naql/custom_widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:naql/custom_widgets/safe_area/page_container.dart';
import 'package:naql/locale/app_localizations.dart';
import 'package:naql/models/commission_app.dart';
import 'package:naql/providers/auth_provider.dart';
import 'package:naql/providers/commission_app_provider.dart';
import 'package:naql/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'package:naql/providers/home_provider.dart';
import 'package:naql/utils/error.dart';
import 'package:naql/custom_widgets/buttons/custom_button.dart';
import 'package:naql/ui/account/pay_commission_screen.dart';
import 'package:naql/providers/navigation_provider.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen>
  with TickerProviderStateMixin{
double _height = 0 , _width = 0;
  AnimationController _animationController;
NavigationProvider _navigationProvider;
HomeProvider _homeProvider;

  @override
  void initState() {
    _animationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

Widget _buildBodyItem(){
  return Column(
    children: <Widget>[
         SizedBox(
            height: 70,
          ),
              Container(
          height: _height - 150,
          width: _width,
          child:FutureBuilder<List<Ad>>(
                  future:  Provider.of<FavouriteProvider>(context,
                          listen: true)
                      .getFavouriteAdsList(),
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
                          if (snapshot.data.length > 0) {
                     return     ListView.builder(
            itemCount: snapshot.data.length,
             itemBuilder: (BuildContext context, int index) {
                var count = snapshot.data.length;
                      var animation = Tween(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                          parent: _animationController,
                          curve: Interval((1 / count) * index, 1.0,
                              curve: Curves.fastOutSlowIn),
                        ),
                      );
                      _animationController.forward();
               return Container(
                height: 145,
                                        width: _width,
                 child: InkWell(
                   onTap: (){

                     _homeProvider.setCurrentAds(snapshot
                         .data[index].adsId);
                       Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AdDetailsScreen(
                                                            ad: snapshot
                                                                .data[index],
                                                          )));
                   },
                   child: AdItem(
                     insideFavScreen: true,
                     animationController: _animationController,
                     animation: animation,
                     ad: snapshot.data[index],
                   )));
             }
          );
                          } else {
                            return NoData(message: AppLocalizations.of(context).translate('no_results'));
                          }
                        }
                    }
                    return Center(
                      child: SpinKitFadingCircle(color: mainAppColor),
                    );
                  })
        
        )
    ],
  );
}

@override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _navigationProvider = Provider.of<NavigationProvider>(context);
    _homeProvider = Provider.of<HomeProvider>(context);

    return PageContainer(
      child: Scaffold(
          body: Stack(
        children: <Widget>[
          _buildBodyItem(),
          Container(
              height: 60,
              decoration: BoxDecoration(
                color: omarColor,


              ),
              child: Row(
                children: <Widget>[

                  Spacer(
                    flex: 3,
                  ),
                  Text( AppLocalizations.of(context).translate('favourite'),
                      style: Theme.of(context).textTheme.headline1),
                  Spacer(
                    flex: 3,
                  ),
                ],
              ))
        ],
      )),
    );
  }
}