import 'package:community_food_app/button_component.dart';
import 'package:community_food_app/input_field_component.dart';
import 'package:community_food_app/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:community_food_app/auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ShelterSignupScreen extends StatefulWidget {
  const ShelterSignupScreen({super.key});

  @override
  State<ShelterSignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<ShelterSignupScreen> {
  final _formGlobalKey = GlobalKey<FormState>();

  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final UserHelper _helper = UserHelper();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty || value.length < 5) {
      return 'You must enter atleast 5 characters';
    }
    return null;
  }

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty || !value.contains('mail.')) {
      return 'You must enter correct email address';
    }
    return null;
  }

  String? _nameValidator(String? value) {
    if (value == null || value.isEmpty || value.length < 2) {
      return 'You must enter your name';
    }
    return null;
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is disposed
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signUp() async {
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    if (user != null && mounted && _formGlobalKey.currentState!.validate()) {
      showToast(message: 'User is successfully created');
      _formGlobalKey.currentState!.reset();
      _helper.saveRestaurantUser(user, name);
      Navigator.pushNamed(context, '/shelter_main_page');
    } 
  }

  _signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);

        await _firebaseAuth.signInWithCredential(credential);
        if (mounted) {
          Navigator.pushNamed(context, '/shelter_main_page');
        }

      }
    } catch (e) {
      showToast(message: 'Some error occured: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Text(
          'Sign Up',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 3, 71, 50),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(36),
          child: Form(
            key: _formGlobalKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //NAME FIELD

                InputField(
                  label: 'Shelter Name',
                  validation: _nameValidator,
                  controller: _nameController,
                ),

                const SizedBox(height: 30),

                //EMAIL FIELD

                InputField(
                  label: 'Email Address',
                  validation: _emailValidator,
                  controller: _emailController,
                ),

                const SizedBox(height: 30),

                //PASSWORD FIELD

                InputField(
                  label: 'Password',
                  validation: _passwordValidator,
                  controller: _passwordController,
                ),

                const SizedBox(height: 100),

                // LOGIN BUTTON
                ButtonComponent(
                  text: 'Sign Up!',
                  onTap: _signUp,
                  textColor: 'black',
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'OR',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    elevation: 10,
                    foregroundColor: const Color.fromARGB(255, 22, 74, 42),
                  ),
                  icon: Icon(MdiIcons.google),
                  label: const Text('Sign In with Google'),
                  onPressed: () {
                    _signInWithGoogle();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// () {
//                     if (_formGlobalKey.currentState!.validate()) {
//                       _signUp();
//                       _formGlobalKey.currentState!.reset();
//                     }
//                   },