import 'package:community_food_app/button_component.dart';
import 'package:community_food_app/input_field_component.dart';
import 'package:flutter/material.dart';

class ShelterLoginPage extends StatefulWidget {
  const ShelterLoginPage({super.key});

  @override
  State<ShelterLoginPage> createState() => _ShelterLoginPageState();
}

class _ShelterLoginPageState extends State<ShelterLoginPage> {
  final _formGlobalKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Text(
          'Log in',
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
                const SizedBox(height: 30),

                //EMAIL FIELD

                InputField(
                  label: 'Email Address',
                  validation: _emailValidator,
                ),

                const SizedBox(height: 30),

                //PASSWORD FIELD

                InputField(
                  label: 'Password',
                  validation: _passwordValidator,
                ),

                const SizedBox(height: 20),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(
                      color: Color.fromARGB(255, 94, 240, 150),
                      fontSize: 16,
                    ),
                  ),
                ),

                const SizedBox(height: 100),

                // LOGIN BUTTON
                ButtonComponent(
                  text: 'Login',
                  onTap: () {
                    if (_formGlobalKey.currentState!.validate()) {
                      Navigator.pushNamed(context, '/shelter_main_page');
                      _formGlobalKey.currentState!.reset();
                    }
                  },
                  textColor: 'black',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
