import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void showWaitingAlert(BuildContext context){
  Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        elevation: 0,
        content: Container(
          color: Colors.white,
          child: Text(
            'The functionality is being finalized.',
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.normal,
              color: const Color(0xFF2F3556),
              fontSize: 16,
            ),
          ),
        ),
        actions: [
          TextButton(
              onPressed: (){
                Get.back();
              },
              child:  Text(
                'Close',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2F3556),
                  fontSize: 16,
                ),
              )
          )
        ],
      )
  );
}