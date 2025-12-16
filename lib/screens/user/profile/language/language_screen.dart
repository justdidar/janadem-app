import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class LanguageScreen extends ConsumerStatefulWidget {
  const LanguageScreen({super.key});

  @override
  ConsumerState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends ConsumerState<LanguageScreen> {

  late String selectedLanguage;

  @override
  void initState() {
    selectedLanguage = 'Kazakh';
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Language',
          style: GoogleFonts.inter(
              fontSize: 19,
              fontWeight: FontWeight.w500,
              color: Colors.black
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: ListView(
              children: [
                Text(
                  'Suggested',
                  style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black
                  ),
                ),
                RadioListTile(
                  title: Text(
                    'Kazakh',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 15
                    ),
                  ),
                  activeColor: const Color(0xff056C5F),
                  value: 'Kazakh',
                  groupValue: selectedLanguage,
                  contentPadding: EdgeInsets.zero,
                  onChanged: (value) {
                    setState(() {
                      selectedLanguage = value.toString();
                    });
                  },
                  controlAffinity: ListTileControlAffinity.trailing,
                ),
                RadioListTile(
                  title: Text(
                    'Russian',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 15
                    ),
                  ),
                  activeColor: const Color(0xff056C5F),
                  value: 'Russian',
                  groupValue: selectedLanguage,
                  contentPadding: EdgeInsets.zero,
                  onChanged:(value) {
                    setState(() {
                      selectedLanguage = value.toString();
                    });
                  },
                  controlAffinity: ListTileControlAffinity.trailing,
                ),
                RadioListTile(
                  title: Text(
                    'English',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 15
                    ),
                  ),
                  activeColor: const Color(0xff056C5F),
                  value: 'English',
                  groupValue: selectedLanguage,
                  contentPadding: EdgeInsets.zero,
                  onChanged:(value) {
                    setState(() {
                      selectedLanguage = value.toString();
                    });
                  },
                  controlAffinity: ListTileControlAffinity.trailing,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}