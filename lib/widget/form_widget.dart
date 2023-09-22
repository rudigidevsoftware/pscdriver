import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class FormProfile extends StatelessWidget {
  final String formName;
  final String formValue;
  const FormProfile({Key? key, required this.formName, required this.formValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(formName,
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500)),
          ),
          Expanded(
            flex: 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    formValue,
                    style: TextStyle(fontSize: 12.sp),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                const SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 12.sp,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class FormEditProfile extends StatelessWidget {
  final String formName;
  final TextEditingController controller;
  final String message;
  final HexColor borderColor;
  final HexColor fillColor;
  final HexColor textColor;
  const FormEditProfile(
      {Key? key,
      required this.controller,
      required this.message,
      required this.borderColor,
      required this.fillColor,
      required this.textColor,
      required this.formName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                  borderRadius: BorderRadius.circular(20)),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                  borderRadius: BorderRadius.circular(20)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                  borderRadius: BorderRadius.circular(20)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                  borderRadius: BorderRadius.circular(20)),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              contentPadding: const EdgeInsets.all(15),
              fillColor: fillColor,
              label: Text(
                formName,
                style: TextStyle(color: textColor),
              )),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return message;
            } else {
              return null;
            }
          },
        ));
  }
}
