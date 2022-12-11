import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:naql/custom_widgets/buttons/custom_button.dart';
import 'package:naql/custom_widgets/no_data/no_data.dart';
import 'package:naql/locale/app_localizations.dart';
import 'package:naql/providers/add_ad_provider.dart';
import 'package:naql/ui/add_ad/add_ad_screen.dart';
import 'package:naql/utils/error.dart';
import 'package:naql/utils/app_colors.dart';
import 'package:provider/provider.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;



class AddAdBottomSheet extends StatefulWidget {
  const AddAdBottomSheet({Key key}) : super(key: key);
  @override
  _AddAdBottomSheetState createState() => _AddAdBottomSheetState();
}

class _AddAdBottomSheetState extends State<AddAdBottomSheet> {


  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: Column(children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: constraints.maxWidth,
                  decoration: BoxDecoration(
                    color: mainAppColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                  ),
                  child: Text(
                  AppLocalizations.of(context).translate('add_ad'),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  )),
            
              Expanded(
             
                child: FutureBuilder<List<String>>(
                    future: 
                     Provider.of<AddAdProvider>(context,
                            listen: false)
                        .getAdPromises() ,
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
                            if (snapshot.data.length > 0) {
                       return     ListView.builder(
            itemCount: snapshot.data.length,
             itemBuilder: (BuildContext context, int index) {
                
                 return Column(
                   children: <Widget>[
                       Container(
                  margin: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: constraints.maxWidth * 0.03),
                  alignment: Alignment.center,
                  child:Html(data: snapshot.data[index])
                         ,
                ),
               index != snapshot.data.length -1 ? Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: constraints.maxWidth * 0.05),

                ) : Container(),
                   ],
                 );
             }
          );
                            } else {
                              return NoData(message: AppLocalizations.of(context).translate('no_results'));
                            }
                          }
                      }
                      return Center(
                        child: SpinKitFadingCircle(color: mainAppColor),
                      );
                    }),
              ),
            
            
              Container(
                margin: EdgeInsets.only(bottom: constraints.maxHeight * 0.02),
                child: CustomButton(
                  btnLbl: AppLocalizations.of(context).translate('ok'),
                  onPressedFunction: () {
                    
                      Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddAdScreen(
                                     

                                )));
                
                   
                  },
                ),
              ),
            ]),
          ));
    });
  }
}
