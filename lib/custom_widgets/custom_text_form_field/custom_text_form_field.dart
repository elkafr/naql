import 'package:flutter/material.dart';
import 'package:naql/utils/app_colors.dart';



class CustomTextFormField extends StatefulWidget {
  final bool enableHorizontalMargin;
final bool enabled;
  final String initialValue;
  final String hintTxt;
  final TextInputType inputData;
  final bool isPassword;
  final Function validationFunc;
  final Function onChangedFunc;
  final bool suffixIconIsImage;
  final Widget prefix;
  final Widget suffix;
  final String suffixIconImagePath;
  final int maxLength;
  final int maxLines;
  final Widget prefixIcon;
  final bool prefixIconIsImage;
  final String prefixIconImagePath;
  final String labelTxt;
    final bool expands;
    final TextEditingController controller;
  CustomTextFormField(
      {this.hintTxt,
this.enableHorizontalMargin:true,
      this.inputData,
      this.isPassword: false,
      this.validationFunc,
      this.onChangedFunc,
      this.initialValue,
      this.suffix,
      this.maxLength,
      this.prefixIconIsImage: false,
      this.suffixIconIsImage: false,
      this.prefixIconImagePath,
      this.suffixIconImagePath,
      this.enabled : true,
      this.maxLines = 1,
     this.expands = false,
     this.labelTxt,
      this.prefix,
      this.prefixIcon,
      this.controller});

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obsecureText = true;
   FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _focusNode.dispose();

    super.dispose();
  }

  Widget _buildTextFormField() {
    return Container(
      color: accentColor,
      child: TextFormField(

        expands: widget.expands,
        controller: widget.controller,
        enabled: widget.enabled,
        maxLines: widget.maxLines ?? 1,
        focusNode: _focusNode,
        maxLength: widget.maxLength,
        initialValue: widget.initialValue,
        style:
        TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400 ) ,
        decoration: InputDecoration(

            border: OutlineInputBorder(

              borderSide: BorderSide(
                  color: _focusNode.hasFocus ? mainAppColor : hintColor),
            ),

            contentPadding: EdgeInsets.symmetric(horizontal: 12.0 ,vertical: 10),
            suffixIcon: !widget.suffixIconIsImage
                ? widget.suffix
                : _focusNode.hasFocus
                ? Image.asset(
              widget.suffixIconImagePath,
              color: mainAppColor,
              height: 25,
              width: 25,
            )
                : Image.asset(
              widget.suffixIconImagePath,
              color: Colors.grey,
              height: 25,
              width: 25,
            ),
            prefix: widget.prefix,
            prefixIcon: !widget.prefixIconIsImage
                ? widget.prefixIcon
                : _focusNode.hasFocus
                ?  Image.asset(
              widget.prefixIconImagePath,
              color: mainAppColor,
              height: 25,
              width: 25,
            )

                : Image.asset(
              widget.prefixIconImagePath,
              color: hintColor,
              height: 25,
              width: 25,
            ),
            hintText: widget.hintTxt,
            labelText: widget.labelTxt,
            errorStyle: TextStyle(fontSize: 12.0),
            hintStyle: TextStyle(
                color: _focusNode.hasFocus ? mainAppColor : hintColor,
                fontSize: 14,
                fontWeight: FontWeight.w400),
            suffix: widget.isPassword
                ? GestureDetector(
              onTap: () {
                setState(() {
                  _obsecureText = !_obsecureText;
                });
              },
              child:  Icon(
                _obsecureText
                    ? Icons.remove_red_eye
                    : Icons.visibility_off,
                color: _focusNode.hasFocus ? mainAppColor : hintColor,
                size: 20,
              ),
            )
                : SizedBox(
              height: 20,
            )),

        keyboardType: widget.inputData,
        obscureText: widget.isPassword ? _obsecureText : false,
        validator: widget.validationFunc,
        onChanged: widget.onChangedFunc,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
      
          margin: EdgeInsets.symmetric(horizontal: widget.enableHorizontalMargin ?  constraints.maxWidth * 0.07 :0),
          child: _buildTextFormField());
    });
  }
}
