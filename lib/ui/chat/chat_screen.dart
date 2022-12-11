import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:naql/custom_widgets/custom_text_form_field/custom_text_form_field.dart';
import 'package:naql/custom_widgets/no_data/no_data.dart';
import 'package:naql/custom_widgets/safe_area/page_container.dart';
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
import 'dart:math' as math;
import 'package:url_launcher/url_launcher.dart';

class ChatScreen extends StatefulWidget {
  final String senderId;
  final String senderName;
  final String senderImg;
  final String senderPhone;
  final String adsId;

  const ChatScreen(
      {Key key,
      this.senderId,
      this.senderName,
      this.senderImg,
      this.senderPhone,
        this.adsId,
      })
      : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  double _height = 0, _width = 0;
  AuthProvider _authProvider;
  ApiProvider _apiProvider = ApiProvider();
  TextEditingController _messageController = TextEditingController();

  Widget _buildBodyItem() {
    return Column(
      children: <Widget>[
        Container(
          height: _height * 0.1,
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
          child: Row(
            children: <Widget>[

              Text(
                widget.senderName,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  launch("tel://${widget.senderPhone}");
                },
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: _width * 0.025),
                    child: Image.asset('assets/images/callnow.png')),
              ),
             /* GestureDetector(
                onTap: (){
                  launch(
                      "https://wa.me/${widget.senderPhone}");
                },
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: _width * 0.025),
                    child: Image.asset('assets/images/whats.png')),
              ) */
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder<List<ChatMsgBetweenMembers>>(
              future: Provider.of<ChatProvider>(context, listen: false)
                  .getChatMessageList(widget.senderId),
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
                      return Error(
                          //  errorMessage: snapshot.error.toString(),
                          errorMessage:
                              AppLocalizations.of(context).translate('error'),
                          onRetryPressed: () {
                            //  setState(() {
                            //    _refreshHandle();
                            //  });
                          });
                    } else {
                      if (snapshot.data.length > 0) {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: _width,
                                height: _height * 0.15,
                                child: ChatMsgItem(
                                  chatMessage: snapshot.data[index],
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
            hintTxt: AppLocalizations.of(context).translate('enter_msg'),
            suffix: IconButton(
              icon: Icon(Icons.send),
              onPressed: () async {
                if (_messageController.text.trim().length > 0) {
                  FocusScope.of(context).requestFocus(FocusNode());

                  final results = await _apiProvider.post(Urls.SEND_URL, body: {
                    "message_sender": _authProvider.currentUser.userId,
                    "message_recever": widget.senderId,
                    "message_content": _messageController.text,
                    "message_ads": "0",
                  });

                  if (results['response'] == "1") {
                    setState(() {
                      _messageController.clear();
                    });
                  } else {
                    Commons.showError(context, results["message"]);
                  }
                } else {
                  Commons.showToast(context,
                      message: AppLocalizations.of(context)
                          .translate('please_enter_msg'));
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
      leading: IconButton(
        icon: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            return authProvider.currentLang == 'ar'
                ? Image.asset(
                    'assets/images/back.png',
                    color: Colors.white,
                  )
                : Transform.rotate(
                    angle: 180 * math.pi / 180,
                    child: Image.asset(
                      'assets/images/back.png',
                      color: Colors.white,
                    ));
          },
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(AppLocalizations.of(context).translate('chat'),
          style: Theme.of(context).textTheme.headline1),
      centerTitle: true,
      backgroundColor: mainAppColor,
    );
    _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    _width = MediaQuery.of(context).size.width;
    _authProvider = Provider.of<AuthProvider>(context);

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
