import 'package:flutter/material.dart';
import 'package:naql/models/chat_message.dart';
import 'package:naql/networking/api_provider.dart';
import 'package:naql/providers/auth_provider.dart';
import 'package:naql/providers/received_msgs_provider.dart';
import 'package:naql/ui/chat/chat_screen.dart';
import 'package:naql/ui/my_chats/my_chats_screen.dart';
import 'package:naql/utils/app_colors.dart';
import 'package:naql/utils/commons.dart';
import 'package:naql/utils/urls.dart';
import 'package:provider/provider.dart';

class ChatItem extends StatefulWidget {
  final AnimationController animationController;
  final Animation animation;
  final ChatMessage chatMessage;

  const ChatItem(
      {Key key, this.animationController, this.animation, this.chatMessage})
      : super(key: key);

  @override
  _ChatItemState createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  ApiProvider _apiProvider = ApiProvider();
  ReceivedMsgsProvider _receivedMsgsProvider;
  AuthProvider _authProvider ;

  @override
  Widget build(BuildContext context) {
    _receivedMsgsProvider = Provider.of<ReceivedMsgsProvider>(context);
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
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute
                        (builder: (context)=> ChatScreen(
                          senderId: widget.chatMessage.senderUserId,
                          senderImg: widget.chatMessage.messageSenderImage,
                          senderName: widget.chatMessage.messageSender,
                        )
                         ));
                      },
                      child: Container(
                          height: constraints.maxHeight,
                          width: constraints.maxWidth,
                          margin: EdgeInsets.only(
                              left: constraints.maxWidth * 0.04,
                              right: constraints.maxWidth * 0.04,
                              bottom: constraints.maxHeight * 0.1),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: constraints.maxWidth * 0.03),
                                    child: CircleAvatar(
                                      radius: constraints.maxHeight * 0.25,
                                      backgroundImage: NetworkImage(
                                          widget.chatMessage.messageSenderImage),
                                    ),
                                  ),
                                  Expanded(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        widget.chatMessage.messageSender,
                                        style: TextStyle(
                                            color: accentColor,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14),
                                      ),
                                      Text(
                                        widget.chatMessage.messageContent,
                                        style: TextStyle(
                                            color: mainAppColor,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            bottom: constraints.maxHeight * 0.02),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                                margin: EdgeInsets.only(
                                                    left: _authProvider.currentLang == 'ar'?constraints.maxWidth *
                                                        0.02 :0 ,right:_authProvider.currentLang != 'ar'?constraints.maxWidth *
                                                        0.02 :0 , ) ,
                                                child: Image.asset(
                                                    'assets/images/time.png')),
                                            Text(
                                              widget.chatMessage.messageDate,
                                              style: TextStyle(
                                                  color: hintColor, fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: constraints.maxWidth * 0.02),
                                    child: IconButton(
                                      onPressed: () async {
                                        _receivedMsgsProvider.setIsLoading(true);
                                        final results = await _apiProvider
                                            .get(Urls.DELETE_MESSAGE_URL +"?user1_id=${widget.chatMessage.senderUserId}&user_id=${_authProvider.currentUser.userId}");
                                        _receivedMsgsProvider.setIsLoading(false);

                                        if (results['response'] == "1") {
                                          Commons.showToast(context,
                                              message: results["message"]);
                                         Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyChatsScreen()));
                                        } else {
                                          Commons.showError(
                                              context, results["message"]);
                                        }
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Color(0xffC50F1D),
                                        size: constraints.maxHeight * 0.3,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )),
                    );
                  })));
        });
  }
}
