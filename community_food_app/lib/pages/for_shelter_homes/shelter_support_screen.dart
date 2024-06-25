import 'package:community_food_app/button_component.dart';
import 'package:community_food_app/input_field_component.dart';
import 'package:flutter/material.dart';

class ShelterSupportScreen extends StatefulWidget {
  const ShelterSupportScreen({super.key});

  @override
  State<ShelterSupportScreen> createState() => _ShelterSupportScreenState();
}

class _ShelterSupportScreenState extends State<ShelterSupportScreen> {
  final _formGlobalKey = GlobalKey<FormState>();

  String? _inputValidator(String? value) {
    if (value == null || value.isEmpty || value.length < 2) {
      return 'Input can not be empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Send us a message',
                style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(255, 3, 71, 50),
                ),
              ),
              const SizedBox(height: 30),
              Form(
                key: _formGlobalKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ButtonComponent(
                      text: 'Submit',
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
            ],
          ),
        ),
      ),
    );
  }
}
