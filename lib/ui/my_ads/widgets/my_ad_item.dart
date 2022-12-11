import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:naql/custom_widgets/buttons/custom_button.dart';
import 'package:naql/locale/app_localizations.dart';
import 'package:naql/models/ad.dart';
import 'package:naql/networking/api_provider.dart';
import 'package:naql/providers/auth_provider.dart';
import 'package:naql/ui/edit_ad/edit_ad_screen.dart';
import 'package:naql/utils/app_colors.dart';
import 'package:naql/utils/commons.dart';
import 'package:naql/utils/urls.dart';
import 'package:provider/provider.dart';

class MyAdItem extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;
  final Ad ad;

  const MyAdItem({Key key, this.animationController, this.animation, this.ad})
      : super(key: key);
  @override
  _MyAdItemState createState() => _MyAdItemState();
}

class _MyAdItemState extends State<MyAdItem> {
  bool _isLoading = false;
  ApiProvider _apiProvider = ApiProvider();
  AuthProvider _authProvider;
  @override
  Widget build(BuildContext context) {
    _authProvider = Provider.of<AuthProvider>(context);
    return AnimatedBuilder(
        animation: widget.animationController,
        builder: (BuildContext context, Widget child) {
          return FadeTransition(
              opacity: widget.animation,
              child: new Transform(
                  transform: new Matrix4.translationValues(
                      0.0, 50 * (1.0 - widget.animation.value), 0.0),
                  child: LayoutBuilder(builder: (context, constraints) {
                    return Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              left: constraints.maxWidth * 0.02,
                              right: constraints.maxWidth * 0.02,
                              bottom: constraints.maxHeight * 0.1),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            border: Border.all(
                              color: hintColor.withOpacity(0.4),
                            ),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Stack(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                 Container(
                 decoration: BoxDecoration(
                 borderRadius: BorderRadius.only(topRight: Radius.circular(10.0),
    bottomRight: Radius.circular(10.0))
                 ),
                 child:  ClipRRect(
                                     borderRadius: BorderRadius.only(
                   topRight: Radius.circular(_authProvider.currentLang == 'ar' ? 10 :0),
    bottomRight: Radius.circular(_authProvider.currentLang == 'ar' ? 10 :0),
    bottomLeft: Radius.circular((_authProvider.currentLang != 'ar' ? 10 :0),
    ),
    topLeft: Radius.circular((_authProvider.currentLang != 'ar' ? 10 :0))
    ),
                                      child: Image.network(
                                        widget.ad.adsPhoto,
                                        height: constraints.maxHeight,
                                        width: constraints.maxWidth * 0.3,
                                        fit: BoxFit.cover,
                                      ))),
                                  Expanded(
                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical:
                                                constraints.maxHeight * 0.04,
                                            horizontal:
                                                constraints.maxWidth * 0.02),
                                        width: constraints.maxWidth * 0.62,
                                        child: Text(
                                          widget.ad.adsTitle,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              height: 1.4),
                                          maxLines: 3,
                                        ),
                                      ),
                                      Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal:
                                                  constraints.maxWidth * 0.02),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0)),
                                            border: Border.all(
                                              color: Color(0xffC50F1D),
                                            ),
                                          ),
                                          child: RichText(
                                            text: TextSpan(
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily: 'Cairo',
                                                  color: Color(0xffC50F1D)),
                                              children: <TextSpan>[
                                                 TextSpan(
                                                    text: widget.ad.adsCatName),




                                              ],
                                            ),
                                          )),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal:
                                                constraints.maxWidth * 0.01,
                                            vertical:
                                                constraints.maxHeight * 0.025),
                                        child: Row(
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: constraints.maxWidth *
                                                      0.02 ),
                                              width:
                                                  constraints.maxWidth * 0.22,
                                              child: CustomButton(
                                                height: 35,
                                                defaultMargin: false,
                                                btnLbl: AppLocalizations.of(context).translate('edit'),
                                                onPressedFunction: () {
                                                   Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditAdScreen(
                                  ad: widget.ad,
                                  

                                )));
                                                },
                                              ),
                                            ),
                                          
                                          
                                            Container(
                                                width:
                                                    constraints.maxWidth * 0.22,
                                                child: CustomButton(
                                                  onPressedFunction: () async {
                                                    setState(() {
                                                      _isLoading = true;
                                                    });
                                                    final results =
                                                        await _apiProvider.post(
                                                            Urls.DELETE_AD_URL +
                                                                "?id=${widget.ad.adsId}&user_id=${_authProvider.currentUser.userId}&api_lang=${_authProvider.currentLang}");

                                                    setState(() =>
                                                        _isLoading = false);
                                                    if (results['response'] ==
                                                        "1") {
                                                      Commons.showToast(context,
                                                          message: results[
                                                              "message"]);
                                                      Navigator
                                                          .pushReplacementNamed(
                                                              context,
                                                              '/my_ads_screen');
                                                    } else {
                                                      Commons.showError(context,
                                                          results["message"]);
                                                    }
                                                  },
                                                  height: 35,
                                                  defaultMargin: false,
                                                  btnColor: Colors.white,
                                                  btnStyle: TextStyle(
                                                      color: mainAppColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                  btnLbl: AppLocalizations.of(context).translate('delete'),
                                                )),
                                          ],
                                        ),
                                      )
                                    ],
                                  ))
                                ],
                              ),
                            ],
                          ),
                        ),
                        _isLoading
                            ? Center(
                                child: SpinKitFadingCircle(color: mainAppColor),
                              )
                            : Container()
                      ],
                    );
                  })));
        });
  }
}
