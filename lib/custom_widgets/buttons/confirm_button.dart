import 'package:flutter/material.dart';
import 'package:naql/utils/app_colors.dart';


class ConfirmButton extends StatelessWidget {

final String btnLbl;
final Function onPressedFunction;

  const ConfirmButton({Key key, this.btnLbl, this.onPressedFunction}) : super(key: key);


  @override
  Widget build(BuildContext context) {
  return Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: Builder(
              builder: (context) => RaisedButton(
                    onPressed: () {
                  onPressedFunction();
                    },
                    elevation: 500,
           
                    color: Theme.of(context).primaryColor,
                    child: Container(
                      color: mainAppColor,
                        alignment: Alignment.center,
                        child: new Text(
                         btnLbl,
                          style:  Theme.of(context).textTheme.button,
                        )),
                  )));
  }
}