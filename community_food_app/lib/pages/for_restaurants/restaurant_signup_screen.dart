import 'package:community_food_app/input_field_component.dart';
import 'package:flutter/material.dart';
import 'package:community_food_app/button_component.dart';

class RestaurantSignupScreen extends StatefulWidget {
  const RestaurantSignupScreen({super.key});

  @override
  State<RestaurantSignupScreen> createState() => _RestaurantSignupScreenState();
}

class _RestaurantSignupScreenState extends State<RestaurantSignupScreen> {
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

  String? _nameValidator(String? value) {
    if (value == null || value.isEmpty || value.length < 2) {
      return 'You must enter your name';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  label: 'Restaurant Name',
                  validation: _nameValidator,
                ),

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

                const SizedBox(height: 100),

                // LOGIN BUTTON
                ButtonComponent(
                  text: 'Login',
                  onTap: () {
                    if (_formGlobalKey.currentState!.validate()) {
                      Navigator.pushNamed(context, '/restaurant_main_page');
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
