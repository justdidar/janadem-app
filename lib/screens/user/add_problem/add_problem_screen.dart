import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:janadem/constants/assets.dart';

class AddProblemScreen extends StatefulWidget {
  const AddProblemScreen({super.key});

  @override
  State<AddProblemScreen> createState() => _AddProblemScreenState();
}

class _AddProblemScreenState extends State<AddProblemScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String photoPath = '';
  bool sending = false;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        photoPath = image.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff056C5F),
        surfaceTintColor: const Color(0xff056C5F),
        title: Text(
          'Problem Location',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Listener(
          behavior: HitTestBehavior.opaque,
          onPointerDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                const SizedBox(height: 15),

                photoPath == ''
                    ? GestureDetector(
                  onTap: pickImage,
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[400],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.photo_camera,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                  ),
                )
                    : ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey,
                    child: Center(
                      child: Stack(
                        children: [
                          Center(
                            child: Image.file(
                              File(photoPath),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      photoPath = '';
                                    });
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(5),
                                      color: const Color.fromRGBO(
                                          235, 67, 53, 0.54)
                                          .withOpacity(0.3),
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 3),
                                    padding: const EdgeInsets.all(5),
                                    child: SvgPicture.asset(
                                        '${Assets().icn}trash.svg'),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: pickImage,
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(5),
                                      color: const Color.fromRGBO(
                                          44, 44, 44, 0.46)
                                          .withOpacity(0.3),
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 3),
                                    padding: const EdgeInsets.all(5),
                                    child: SvgPicture.asset(
                                        '${Assets().icn}edit.svg'),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: TextFormField(
                    controller: titleController,
                    maxLines: 1,
                    cursorColor: const Color(0xff1A1B22),
                    cursorWidth: 1,
                    cursorHeight: 20,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Problem Title',
                      hintStyle: GoogleFonts.inter(
                        color: const Color(0xffBCBCBC),
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xff797979)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xff797979)),
                      ),
                    ),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xff797979)),
                    ),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: TextFormField(
                      controller: descriptionController,
                      maxLines: null,
                      expands: true,
                      textAlignVertical: TextAlignVertical.top,
                      cursorColor: const Color(0xFF8C8C8C),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Problem Description',
                        hintStyle: GoogleFonts.inter(
                          color: const Color(0xffBCBCBC),
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          sending = true;
                        });

                        Future.delayed(const Duration(seconds: 1), () {
                          setState(() {
                            titleController.clear();
                            descriptionController.clear();
                            photoPath = '';
                            sending = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Submitted!')),
                          );
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: const Color(0xff056C5F),
                        splashFactory: NoSplash.splashFactory,
                        elevation: 0,
                      ),
                      child: sending
                          ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                          : Text(
                        'Confirm',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
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
    );
  }
}