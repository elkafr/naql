import 'package:flutter/material.dart';
import 'package:naql/locale/app_localizations.dart';

import 'package:naql/providers/register_provider.dart';
import 'package:naql/utils/app_colors.dart';
import 'package:provider/provider.dart';

class SelectCountryBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: mainAppColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.00),
                    topRight: Radius.circular(15.00),
                  ),
                  border: Border.all(color: mainAppColor)),
              alignment: Alignment.center,
              width: constraints.maxWidth,
              height: 50,
              child: Text(
                AppLocalizations.of(context).translate('choose_country'),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ),
          
                  
                Consumer<RegisterProvider>(
                  builder: (context,registerProvider,child){
                    return     ListView.builder(
                            shrinkWrap: true,
                            itemCount: registerProvider.countryList.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      registerProvider.setUserCountry(registerProvider.countryList[index]);
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 40,
                                      child: Text(
                                        registerProvider.countryList[index].countryName,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                  index !=  registerProvider.countryList.length - 1
                                      ? Divider()
                                      : Container()
                                ],
                              );
                            });
                  }
                )
          ],
        ),
      );
    });
  }
}
