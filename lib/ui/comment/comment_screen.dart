import 'package:naql/models/comments.dart';
import 'package:naql/providers/comment_provider.dart';
import 'package:naql/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:naql/custom_widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:naql/custom_widgets/no_data/no_data.dart';
import 'package:naql/custom_widgets/safe_area/page_container.dart';
import 'package:naql/models/ad_details.dart';
import 'package:naql/networking/api_provider.dart';
import 'package:naql/providers/ad_details_provider.dart';

import 'package:naql/locale/app_localizations.dart';
import 'package:naql/models/chat_message.dart';
import 'package:naql/models/chat_msg_between_members.dart';
import 'package:naql/networking/api_provider.dart';
import 'package:naql/providers/auth_provider.dart';
import 'package:naql/providers/chat_provider.dart';
import 'package:naql/ui/chat/widgets/chat_msg_item.dart';
import 'package:naql/utils/app_colors.dart';
import 'package:naql/utils/commons.dart';
import 'package:naql/utils/error.dart';
import 'package:naql/utils/urls.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';
import 'dart:math' as math;
import 'package:url_launcher/url_launcher.dart';
import 'package:naql/ui/home/home_screen.dart';


class CommentScreen extends StatefulWidget {


  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  double _height = 0, _width = 0;
  AuthProvider _authProvider;
  HomeProvider _homeProvider;
  ApiProvider _apiProvider = ApiProvider();
  TextEditingController _messageController = TextEditingController();
  LocationData _locData;




  Widget _buildBodyItem() {

    return Column(
      children: <Widget>[

        FutureBuilder<AdDetails>(
            future: Provider.of<AdDetailsProvider>(context,
                listen: false)
                .getAdDetails(_homeProvider.currentAds) ,
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




                    return   Container(
                      padding: EdgeInsets.all(10),
                      child: Text(snapshot.data.adsTitle),
                    );
                  }
              }

              return Center(
                child: SpinKitFadingCircle(color: mainAppColor),
              );
            }),


        Expanded(
          child: FutureBuilder<List<Comments>>(
              future: Provider.of<CommentProvider>(context, listen: false)
                  .getCommentsList(_homeProvider.currentAds),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return SpinKitFadingCircle(color: mainAppColor);
                  case ConnectionState.active:
                    return Text('');
                  case ConnectionState.waiting:
                    return SpinKitFadingCircle(color: mainAppColor);
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      return NoData(
                        message:
                        _homeProvider.currentLang=="ar"?"لا يوجد تعليقات":"No comments found",
                      );
                    } else {
                      if (snapshot.data.length > 0) {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                                width: _width,
                                height: _height * 0.15,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[

                                    Image.network(snapshot.data[index].commentBy,width: 50,height: 50,),
                                    Padding(padding: EdgeInsets.all(5)),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(snapshot.data[index].commentBy,style: TextStyle(fontSize: 14,color: accentColor)),
                                        Padding(padding: EdgeInsets.all(5)),
                                        Container(
                                          width: 300,
                                          child: Text(snapshot.data[index].commentDetails,style: TextStyle(fontSize: 16,color: mainAppColor,),maxLines: 2,),
                                        ),
                                        Text(snapshot.data[index].commentDate,style: TextStyle(fontSize: 14,color: accentColor)),
                                      ],
                                    )


                                  ],
                                ),
                              );
                            });
                      } else {
                        return NoData(
                          message:
                          AppLocalizations.of(context).translate('no_msgs'),
                        );
                      }
                    }
                }
                return SpinKitFadingCircle(color: mainAppColor);
              }),
        ),

        Divider(),
        Container(
          height: 50,
          margin: EdgeInsets.symmetric(horizontal: _width * 0.03),
          width: _width,
          child: CustomTextFormField(
            enableHorizontalMargin: false,
            controller: _messageController,
            hintTxt: _homeProvider.currentLang=="ar"?"اكتب تعليقك هنا ...":"Add your comment here ...",
            suffix: IconButton(
              icon: Icon(Icons.send,color: mainAppColor,),
              onPressed: () async {


                final results = await _apiProvider
                    .post(Urls.ADD_COMMENT , body: {
                  "ads_id":  _homeProvider.currentAds,
                  "comment_details":_messageController.text.toString(),
                  "user_id": _authProvider.currentUser.userId,


                });


                if (results['response'] == "1") {
                  Commons.showToast(context, message: results["message"] );
                  Navigator.pop(context);

                } else {
                  Commons.showError(context, results["message"]);

                }


              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      automaticallyImplyLeading: false,
      title: Text("اضافة تعليق",
          style: Theme.of(context).textTheme.headline1),
      centerTitle: true,
      backgroundColor: mainAppColor,
      actions: <Widget>[
        GestureDetector(
          child: Icon(Icons.arrow_forward,color: Colors.white,size: 35,),
          onTap: (){
            Navigator.pop(context);
          },
        ),
        Padding(padding: EdgeInsets.all(5)),

      ],
    );
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _authProvider = Provider.of<AuthProvider>(context);
    _homeProvider = Provider.of<HomeProvider>(context);

    return PageContainer(
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: Scaffold(
          appBar: appBar,
          body: _buildBodyItem(),
        ),
      ),
    );
  }
}
