import 'package:flutter/material.dart';

class ResponseAlertDialog extends StatelessWidget {
  final String alertTitle;
  final String alertMessage;
  final String alertBtn;
  final Function onPressedAlertBtn; 
  const ResponseAlertDialog(
      {Key key, this.alertTitle, this.alertMessage, this.alertBtn, this.onPressedAlertBtn})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: SingleChildScrollView(
        child:  Column(
          children: <Widget>[
            Center(
                child: Text(
              alertTitle,
              style: Theme.of(context).textTheme.title,
            )),
            SizedBox(
              height: 10,
            ),
            Text(
              alertMessage,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(
              height: 15,
            ),
            Divider(
              height: 2,
              color: Colors.black,
            ),
            SizedBox(
              height: 15,
            ),
           
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  onPressedAlertBtn();
                },
                child: Text(alertBtn,
                    style: TextStyle(color: Theme.of(context).primaryColor)))
          ],
        ),
      ),
    );
  }
}
