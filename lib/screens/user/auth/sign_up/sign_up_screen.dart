import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:janadem/constants/assets.dart';
import 'package:janadem/screens/user/auth/login/login_screen.dart';
import 'package:janadem/screens/widgets/textform_widget.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpScreen extends StatefulWidget {
  final int status;
  const SignUpScreen({super.key, required this.status});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();

  final maskFormatter = MaskTextInputFormatter(
    mask: '+#(###) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  bool passwordVisible = true;
  bool passwordConfirmVisible = true;
  bool registerButtonPressed = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Listener(
            behavior: HitTestBehavior.opaque,
            onPointerDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text('Sign Up', style: GoogleFonts.inter(fontSize: 23, fontWeight: FontWeight.w400)),
                    Text('Kindly enter your details', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 10),

                    _buildTextField(label: 'Name', controller: nameController),
                    _buildTextField(label: 'Surname', controller: lastnameController),
                    _buildPhoneField(),
                    _buildTextField(label: 'Email', controller: emailController, keyboardType: TextInputType.emailAddress),
                    _buildDateField(),
                    _buildPasswordField(label: 'Password', controller: passwordController, visible: passwordVisible, onToggle: () => setState(() => passwordVisible = !passwordVisible)),
                    _buildPasswordField(label: 'Confirm Password', controller: passwordConfirmController, visible: passwordConfirmVisible, onToggle: () => setState(() => passwordConfirmVisible = !passwordConfirmVisible), confirm: true),
                    const SizedBox(height: 10),

                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: registerButtonPressed ? null : _registerUser,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff056C5F),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          elevation: 0,
                        ),
                        child: registerButtonPressed
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text('Sign Up', style: GoogleFonts.inter(fontSize: 17, color: Colors.white)),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account?', style: GoogleFonts.inter(fontSize: 15)),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () => Get.offAll(() => const LoginScreen(status: 1)),
                          child: Text('Login', style: GoogleFonts.inter(fontSize: 15, color: const Color(0xff469BD8))),
                        ),
                      ],
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

  Future<void> _registerUser() async {
    if (!formKey.currentState!.validate()) return;

    setState(() => registerButtonPressed = true);

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );


      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': nameController.text.trim(),
        'lastname': lastnameController.text.trim(),
        'phone': phoneNumberController.text.trim(),
        'email': emailController.text.trim(),
        'dateOfBirth': dateOfBirthController.text.trim(),
      });



      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration was successful!'))
      );

      await Future.delayed(const Duration(milliseconds: 800));


      Get.offAll(() => const LoginScreen(status: 1));

    } on FirebaseAuthException catch (e) {
      String message = 'Registration failed';
      if (e.code == 'email-already-in-use') message = 'Email is already used';
      if (e.code == 'weak-password') message = 'Weak password';
      Get.snackbar('Error', message, snackPosition: SnackPosition.BOTTOM);
    } finally {
      setState(() => registerButtonPressed = false);
    }
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.inter(fontSize: 14)),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            border: textFieldBorder(const Color(0xff797979)),
            filled: true,
            fillColor: Colors.white,
          ),
          validator: (v) => v == null || v.isEmpty ? 'It is necessary to fill in the field' : null,
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildPhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Phone Number', style: GoogleFonts.inter(fontSize: 14)),
        const SizedBox(height: 5),
        TextFormField(
          controller: phoneNumberController,
          inputFormatters: [maskFormatter],
          decoration: InputDecoration(
            hintText: '+7(700) 000-00-00',
            border: textFieldBorder(const Color(0xff797979)),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Date of birth', style: GoogleFonts.inter(fontSize: 14)),
        const SizedBox(height: 5),
        TextFormField(
          controller: dateOfBirthController,
          readOnly: true,
          decoration: InputDecoration(
            hintText: 'DD/MM/YYYY',
            suffixIcon: IconButton(
              icon: SvgPicture.asset('${Assets().icn}calendar.svg'),
              onPressed: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  initialDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  dateOfBirthController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
                }
              },
            ),
            border: textFieldBorder(const Color(0xff797979)),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool visible,
    required VoidCallback onToggle,
    bool confirm = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.inter(fontSize: 14)),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          obscureText: visible,
          decoration: InputDecoration(
            suffixIcon: IconButton(icon: Icon(visible ? Icons.visibility_off : Icons.visibility), onPressed: onToggle),
            border: textFieldBorder(const Color(0xff797979)),
            filled: true,
            fillColor: Colors.white,
          ),
          validator: (v) {
            if (v == null || v.isEmpty) return 'Required';
            if (!confirm && v.length < 8) return 'Password must be at least 8 characters';
            if (confirm && v != passwordController.text) return 'Passwords do not match';
            return null;
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
