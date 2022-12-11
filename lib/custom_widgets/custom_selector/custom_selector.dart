import 'package:flutter/material.dart';

class CustomSelector extends StatelessWidget {
  final Widget title;
  final Widget icon;

  const CustomSelector(
      {Key key, this.title, this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
  
            return Container(
              
              padding: const EdgeInsets.all(8.0),
             
              height: constraints.maxHeight ,
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Color(0xffBFBFBF)),
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child:   icon,
                    ),
                       Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: title)
                      ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      size: 20,
                      color: Color(0xffBFBFBF),
                    ),
                  )
                ],
              ),
            );
         
    });
  }
}
