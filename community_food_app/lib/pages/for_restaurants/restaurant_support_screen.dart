import 'package:community_food_app/button_component.dart';
import 'package:community_food_app/input_field_component.dart';
import 'package:flutter/material.dart';

class RestaurantSupportScreen extends StatefulWidget {
  const RestaurantSupportScreen({super.key});

  @override
  State<RestaurantSupportScreen> createState() =>
      _RestaurantSupportScreenState();
}

class _RestaurantSupportScreenState extends State<RestaurantSupportScreen> {
  final _formGlobalKey = GlobalKey<FormState>();

  TextEditingController restaurantNameController = TextEditingController();

  String? _inputValidator(String? value) {
    if (value == null || value.isEmpty || value.length < 2) {
      return 'Input can not be empty';
    }
    return null;
  }

  @override
  void dispose() {
    restaurantNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 25, 16, 16),
          child: Column(
            children: [
              const Text(
                'Send us a message',
                style: TextStyle(
                  fontSize: 25,
                  color: Color.fromARGB(255, 3, 71, 50),
                ),
              ),
              const SizedBox(height: 50),
              Form(
                key: _formGlobalKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InputField(
                      label: 'Restaurant Name',
                      validation: _inputValidator, 
                      controller: restaurantNameController,
                    ),
                    const SizedBox(height: 30),
                    Material(
                      elevation: 10,
                      shadowColor: Colors.black45,
                      borderRadius: BorderRadius.circular(10),
                      type: MaterialType.card,
                      child: SizedBox(
                        height: 200,
                        child: TextFormField(
                          maxLines: null,
                          // expands: true,
                          decoration: const InputDecoration(
                            hintText: 'Write your message...',
                            hintStyle: TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 12),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: _inputValidator,
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
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
