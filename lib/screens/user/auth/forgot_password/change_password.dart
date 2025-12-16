import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:janadem/constants/assets.dart';
import 'package:janadem/screens/widgets/textform_widget.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  final formKey = GlobalKey<FormState>();

  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  bool passwordVisible = true;
  bool passwordConfirmVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Listener(
            behavior: HitTestBehavior.opaque,
            onPointerDown: (_) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Create New Password',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff2C2C2C)
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Kindly enter a unique password',
                        style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff2C2C2C)
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Password',
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff2C2C2C)
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: TextFormField(
                              cursorColor: const Color(0xff1A1B22),
                              cursorWidth: 1,
                              cursorHeight: 20,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.text,
                              obscureText: passwordVisible,
                              controller: passwordController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                                border: textFieldBorder(const Color(0xff797979)),
                                focusedBorder: textFieldBorder(const Color(0xff797979)),
                                disabledBorder: textFieldBorder(const Color(0xff797979)),
                                enabledBorder: textFieldBorder(const Color(0xff797979)),
                                errorBorder: textFieldBorder(const Color(0xffFF3636)),
                                focusedErrorBorder: textFieldBorder(const Color(0xffFF3636)),
                                filled: true,
                                fillColor: Colors.white,
                                suffixIcon: GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      passwordVisible = !passwordVisible;
                                    });
                                  },
                                  child: !passwordVisible
                                      ? SvgPicture.asset('${Assets().icn}visible.svg', height: 20, width: 20, fit: BoxFit.scaleDown, color: const Color(0xff1F1F1F))
                                      : SvgPicture.asset('${Assets().icn}not_visible.svg', height: 20, width: 20, fit: BoxFit.scaleDown, color: const Color(0xff1F1F1F)),
                                ),
                                hintText: 'Input your password',
                                hintStyle: GoogleFonts.inter(
                                    color: const Color(0xffBCBCBC),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17
                                ),
                                errorStyle: GoogleFonts.inter(
                                    color: const Color(0xffFF3636),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13
                                ),

                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'It is necessary to fill in the field';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Password',
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff2C2C2C)
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: TextFormField(
                              cursorColor: const Color(0xff1A1B22),
                              cursorWidth: 1,
                              cursorHeight: 20,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.text,
                              obscureText: passwordConfirmVisible,
                              controller: passwordConfirmController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                                border: textFieldBorder(const Color(0xff797979)),
                                focusedBorder: textFieldBorder(const Color(0xff797979)),
                                disabledBorder: textFieldBorder(const Color(0xff797979)),
                                enabledBorder: textFieldBorder(const Color(0xff797979)),
                                errorBorder: textFieldBorder(const Color(0xffFF3636)),
                                focusedErrorBorder: textFieldBorder(const Color(0xffFF3636)),
                                filled: true,
                                fillColor: Colors.white,
                                suffixIcon: GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      passwordConfirmVisible = !passwordConfirmVisible;
                                    });
                                  },
                                  child: !passwordConfirmVisible
                                      ? SvgPicture.asset('${Assets().icn}visible.svg', height: 20, width: 20, fit: BoxFit.scaleDown, color: const Color(0xff1F1F1F))
                                      : SvgPicture.asset('${Assets().icn}not_visible.svg', height: 20, width: 20, fit: BoxFit.scaleDown, color: const Color(0xff1F1F1F)),
                                ),
                                hintText: 'Confirm Password',
                                hintStyle: GoogleFonts.inter(
                                    color: const Color(0xffBCBCBC),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17
                                ),
                                errorStyle: GoogleFonts.inter(
                                    color: const Color(0xffFF3636),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13
                                ),

                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'It is necessary to fill in the field';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () async {
                            if(formKey.currentState!.validate()){

                            } else {

                            }
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: const Color(0xff056C5F),
                              splashFactory: NoSplash.splashFactory,
                              elevation: 0
                          ),
                          child: Text(
                            'Change Password',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
