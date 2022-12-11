import 'package:flutter/material.dart';
import 'package:naql/models/category.dart';
import 'package:naql/utils/app_colors.dart';
import 'package:naql/utils/app_colors.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel category;
    final AnimationController animationController;
  final Animation animation;

  const CategoryItem({Key key, this.category, this.animationController, this.animation}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: constraints.maxHeight *0.05),
            width: constraints.maxWidth *0.8,
            height: constraints.maxHeight *0.6,
            decoration: BoxDecoration(
              color: category.isSelected ?  Colors.white : Color(0xffF3F3F3),
              border: Border.all(
                width: 1.0,
                color: category.isSelected ? mainAppColor: Color(0xffF3F3F3),
              ),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child:  category.catId != '0' ?
            ClipRRect(
    borderRadius: BorderRadius.all( Radius.circular(10.0)),
    child: Image.network(category.catImage,fit: BoxFit.none,width: 35,height: 35)) :
            Image.asset(category.catImage),
          ),
          Container(
            alignment: Alignment.center,
            width: constraints.maxWidth,
            child: Text(category.catName,style: TextStyle(

              color: category.isSelected ?mainAppColor:Colors.black,fontSize: category.catName.length > 1 ?13 : 13,

            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,),
          ),

        ],
      );
    });
  }
}
