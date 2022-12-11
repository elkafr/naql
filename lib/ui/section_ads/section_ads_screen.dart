import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:naql/custom_widgets/ad_item/ad_item.dart';
import 'package:naql/custom_widgets/no_data/no_data.dart';
import 'package:naql/custom_widgets/safe_area/page_container.dart';
import 'package:naql/locale/app_localizations.dart';
import 'package:naql/models/ad.dart';
import 'package:naql/providers/auth_provider.dart';
import 'package:naql/providers/home_provider.dart';
import 'package:naql/providers/section_ads_provider.dart';
import 'package:naql/ui/ad_details/ad_details_screen.dart';
import 'package:naql/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:naql/utils/error.dart';
import 'dart:math' as math;

class SectionAdsScreen extends StatefulWidget {
  final String catId;
  final String adCatName;

  const SectionAdsScreen({Key key, this.catId, this.adCatName}) : super(key: key);
  @override
  _SectionAdsScreenState createState() => _SectionAdsScreenState();
}

class _SectionAdsScreenState extends State<SectionAdsScreen> with TickerProviderStateMixin{
double _height = 0 , _width = 0;
HomeProvider _homeProvider;
AnimationController _animationController;

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
  return ListView(
    children: <Widget>[
         SizedBox(
            height: 80,
          ),
              Container(
          height: _height - 80,
          width: _width,
          child: FutureBuilder<List<Ad>>(
                  future:  Provider.of<SectionAdsProvider>(context,
                          listen: false)
                      .getAdsList(widget.catId) ,
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
                              errorMessage: snapshot.error.toString(),
                           // errorMessage: "حدث خطأ ما ",
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
                 height: _height*.19,
                                        width: _width,
                 child: InkWell(
                   onTap: (){

                     _homeProvider.setCurrentAds(snapshot
                         .data[index].adsId);


                      Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdDetailsScreen(
                                  ad: snapshot.data[index],
                                  

                                )));
                   },
                   child: AdItem(
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
                  }),
        )
    ],
  );
}

@override
  Widget build(BuildContext context) {
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
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
                  IconButton(
                    icon: Consumer<AuthProvider>(
                      builder: (context,authProvider,child){
                        return authProvider.currentLang == 'ar' ? Image.asset(
                      'assets/images/back.png',
                      color: Colors.white,
                    ): Transform.rotate(
                            angle: 180 * math.pi / 180,
                            child:  Image.asset(
                      'assets/images/back.png',
                      color: Colors.white,
                    ));
                      },
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Text(widget.adCatName,
                      style: Theme.of(context).textTheme.headline1),
                  Spacer(
                    flex: 3,
                  ),
                ],
              )),
        ],
      )),
    );
  }
}