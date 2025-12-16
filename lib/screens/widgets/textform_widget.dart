import 'package:flutter/material.dart';

OutlineInputBorder textFieldBorder(Color color){
  return OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(
      width: 1,
      color: color,
    ),
  );
}