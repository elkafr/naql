import 'package:flutter/material.dart';
import 'package:naql/utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  final double height ;
  final Color btnColor;
  final String btnLbl;
  final Function onPressedFunction;
  final TextStyle btnStyle;
  final Color borderColor;
   final bool defaultMargin;


  const CustomButton(
      {Key key,
      this.btnLbl,
      this.height,
      this.borderColor,
      this.onPressedFunction,
      this.btnColor,
      this.btnStyle,
      this.defaultMargin: true
   })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height:  height ==  null? 52 : height,
        margin: EdgeInsets.symmetric(
            horizontal: defaultMargin?
               MediaQuery.of(context).size.width * 0.07 : 0.0,
            vertical: MediaQuery.of(context).size.height * 0.01),
        child: Builder(
            builder: (context) => RaisedButton(
                  onPressed: () {
                    onPressedFunction();
                  },
                  elevation: 0,
                  shape: new RoundedRectangleBorder(

                    side: BorderSide(color:borderColor != null ? borderColor : mainAppColor  )
                    ),
                  color: btnColor != null
                      ? btnColor
                      : Theme.of(context).primaryColor,
                  child: Container(
                      alignment: Alignment.center,
                      child: new Text(
                        '$btnLbl',
                        style: btnStyle == null
                            ? Theme.of(context).textTheme.button
                            : btnStyle,
                      )),
                )));
  }
}
