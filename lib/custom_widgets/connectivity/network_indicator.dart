
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';


class NetworkIndicator extends StatefulWidget {
  final Widget child;
  const NetworkIndicator({this.child});
  @override
  _NetworkIndicatorState createState() => _NetworkIndicatorState();
}

class _NetworkIndicatorState extends State<NetworkIndicator> {
  Widget _buildBodyItem(double height) {
    return ListView(
      children: <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
            SizedBox(
          height: height * 0.2,
        ),
          Icon(
                            Icons.signal_wifi_off,
                            size: height * 0.25,
                            color: Colors.grey[400],
                          ),
    
        Container(
          margin: EdgeInsets.only(
            top: 10
          ),
            child: Text(
              'عفواً ... لايوجد اتصال بالإنترنت',
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'NotoKufi',
                  fontWeight: FontWeight.w400),
            )),
             Container(
               margin: EdgeInsets.only(top: height * 0.025),
            child: Text(
              'إفحص جهاز الراوتر الخاص بك',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[400],
                  fontFamily: 'NotoKufi',
                  fontWeight: FontWeight.w400),
            ))
            , Container(
               margin: EdgeInsets.only(top: height * 0.025),
            child: Text(
              'أعد الاتصال بالشبكة',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[400],
                  fontFamily: 'NotoKufi',
                  fontWeight: FontWeight.w400),
            )),
        Container(
          height:height * 0.09 ,
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.25,
              vertical: height*0.02
            ),
          child: Builder(
              builder: (context) => RaisedButton(
                    onPressed: () {
                   
                    },
                    elevation: 500,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25.0)),
                    color:Theme.of(context).primaryColor,
                    child: Container(
                        alignment: Alignment.center,
                        child: new Text(
                         'تحديث الصفحة',
                          style: TextStyle(
                              fontFamily: 'NotoKufi',
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 20.0),
                        )),
                  )))    
        ],
      )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (
        BuildContext context,
        ConnectivityResult connectivity,
        Widget child,
      ) {
        if (connectivity == ConnectivityResult.none) {
          final appBar = AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              title: Text(
                'نقل',
                style: TextStyle(
                    color: Color(0xffFFFFFF),
                    fontFamily: 'NotoKufi0',
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
              centerTitle: true,
              actions: <Widget>[]);
          final height = MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top;
          return Scaffold(
            appBar: appBar,
            body: _buildBodyItem(height),
          );
        } else {
          return child;
        }
      },
      builder: (BuildContext context) {
        return widget.child;
      },
    );
  }
}
