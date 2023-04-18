import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  final TextEditingController? controller;
  final IconData? data;
  final String? hintText;
  bool? isObsecre=true;
  bool? enabled=true;

  CustomTextField({
    this.controller, this.data, this.hintText, this.isObsecre, this.enabled
});


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: EdgeInsets.all(8.0),
      margin:  EdgeInsets.all(10.0),
      child: TextFormField(
        enabled: enabled,
        controller: controller,
        obscureText: isObsecre!,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            data,
            color: Color(0xff023e8a),
          ),
          focusColor: Theme.of(context).primaryColor ,
          hintText: hintText,
        ),
      )


    );
  }
}
