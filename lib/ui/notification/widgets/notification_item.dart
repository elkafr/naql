import 'package:flutter/material.dart';
import 'package:naql/models/notification_message.dart';
import 'package:naql/utils/app_colors.dart';


class NotificationItem extends StatelessWidget {
    final AnimationController animationController;
  final Animation animation;
  final NotificationMsg notificationMsg;
  final bool enableDivider ;

  const NotificationItem({Key key, this.animationController, this.animation, 
  this.notificationMsg,  this.enableDivider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child:LayoutBuilder(
            builder: (context,constraints){
              return Column(
                children: <Widget>[
                  Container(
                    height: constraints.maxHeight *0.8,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

      Container(
        margin: EdgeInsets.symmetric(horizontal: constraints.maxWidth *0.02),
        child: CircleAvatar(
                       backgroundColor: accentColor,
                       child: Icon(Icons.notifications,color:Colors.white,),
                     ),
      ),
                      Container(

                        height: constraints.maxHeight ,
                        width: constraints.maxWidth *0.8,
                        child: Column(

                         crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: constraints.maxWidth *0.8,
                            child: Text(notificationMsg.messageContent,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,style: TextStyle(
                              height: 1.5
                            ),
                            ),),
                             Row(

                              children: <Widget>[
                             Container(
                               margin: EdgeInsets.symmetric(horizontal: 7),
                               child:   Image.asset('assets/images/time.png')),
                                Text(notificationMsg.messageDate ,style: TextStyle(
                                  color:hintColor ,fontSize: 12
                                ),)
                              ],
                            ),


                          ],
                        ),
                      ),

      ],
                    ),
                  ),
                Divider(
             height: constraints.maxHeight *0.05,
                  thickness: 1.2,
                  color: Colors.grey[300],
                ),

                ],
              );
            }
    )));
    }
    );

  }
}