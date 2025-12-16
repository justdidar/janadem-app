import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  var maskFormatter = MaskTextInputFormatter(
    mask: '+#(###) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  bool saveButtonPressed = false;
  bool passwordVisible = true;
  bool confirmPasswordVisible = true;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = _auth.currentUser;
    if(user != null){
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if(doc.exists){
        final data = doc.data()!;
        nameController.text = data['name'] ?? '';
        surnameController.text = data['lastname'] ?? '';
        phoneNumberController.text = data['phone'] ?? '';
        emailController.text = data['email'] ?? '';
      }
    }
  }

  Future<void> _saveProfile() async {
    if(!formKey.currentState!.validate()) return;
    final user = _auth.currentUser;
    if(user != null){
      setState(() => saveButtonPressed = true);

      try{

        await _firestore.collection('users').doc(user.uid).update({
          'name': nameController.text.trim(),
          'lastname': surnameController.text.trim(),
          'phone': phoneNumberController.text.trim(),
          'email': emailController.text.trim(),
        });

        if(emailController.text.trim() != user.email){
          await user.updateEmail(emailController.text.trim());
        }
        if(passwordController.text.isNotEmpty){
          if(passwordController.text == confirmPasswordController.text){
            await user.updatePassword(passwordController.text.trim());
          }
        }



        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated!'))
        );
      }catch(e){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${e.toString()}'))
        );
      }finally{
        setState(() => saveButtonPressed = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text('Edit Profile', style: GoogleFonts.inter(fontSize: 19, fontWeight: FontWeight.w500, color: Colors.black),),
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                const SizedBox(height: 20),
                buildTextField('Name', nameController, 'Name'),
                buildTextField('Surname', surnameController, 'Surname'),
                buildTextField('Phone Number', phoneNumberController, 'Phone Number', maskFormatter),
                buildTextField('Email', emailController, 'Email', null, TextInputType.emailAddress),
                buildPasswordField('Password', passwordController, passwordVisible, ()=> setState(()=> passwordVisible = !passwordVisible)),
                buildPasswordField('Confirm Password', confirmPasswordController, confirmPasswordVisible, ()=> setState(()=> confirmPasswordVisible = !confirmPasswordVisible)),

                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: _saveProfile,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      backgroundColor: const Color(0xff056C5F),
                      splashFactory: NoSplash.splashFactory,
                      elevation: 0,
                    ),
                    child: saveButtonPressed
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text('Save', textAlign: TextAlign.center, style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w400, color: Colors.white),),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller, String hintText,
      [MaskTextInputFormatter? formatter, TextInputType keyboardType = TextInputType.text]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0xff2C2C2C)),),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            inputFormatters: formatter != null ? [formatter] : [],
            cursorColor: const Color(0xff1A1B22),
            cursorWidth: 1,
            cursorHeight: 20,
            textAlignVertical: TextAlignVertical.center,
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
              hintText: hintText,
              hintStyle: GoogleFonts.inter(color: const Color(0xffBCBCBC), fontWeight: FontWeight.w400, fontSize: 17,),
              errorStyle: GoogleFonts.inter(color: const Color(0xffFF3636), fontWeight: FontWeight.w400, fontSize: 13,),
            ),
            validator: (value) {
              if(value == null || value.isEmpty) return 'It is necessary to fill in the field';
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget buildPasswordField(String label, TextEditingController controller, bool visible, VoidCallback onToggle){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.inter(fontSize: 14),),
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
          validator: (v){
            if(v == null || v.isEmpty) return null;

            if(label == 'Password' && v.length < 8) return 'Password must be at least 8 characters';
            if(label == 'Confirm Password' && v != passwordController.text) return 'Passwords do not match';
            return null;
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  OutlineInputBorder textFieldBorder(Color color){
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(color: color),
    );
  }

}
