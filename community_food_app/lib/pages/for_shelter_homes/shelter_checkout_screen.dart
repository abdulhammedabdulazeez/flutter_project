import 'package:community_food_app/button_component.dart';
import 'package:community_food_app/models/dummy_data.dart';
// import 'package:community_food_app/pages/for_shelter_homes/shelter_cart_screen.dart';
import 'package:community_food_app/pages/for_shelter_homes/shelter_home_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShelterCheckoutScreen extends StatefulWidget {
  const ShelterCheckoutScreen({super.key});

  @override
  State<ShelterCheckoutScreen> createState() => _ShelterCheckoutScreenState();
}

class _ShelterCheckoutScreenState extends State<ShelterCheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedRestaurant;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String? _name;
  String? _contactInfo;

  void _selectTimeRange() async {
    final start = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (start != null && mounted) {
      final end = await showTimePicker(
        context: context,
        initialTime: start.replacing(hour: start.hour + 1),
      );
      if (end != null && mounted) {
        setState(() {
          _startTime = start;
          _endTime = end;
        });
      }
    }
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final format = DateFormat.jm();
    return format.format(dt);
  }

  @override
  void dispose() {
    // Clean up any controllers or resources here if needed
    super.dispose();
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Order Confirmation'),
          content: const Text('Your order is being processed.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const ShelterHomeWrapper()),
                );
              },
              child: const Text('OK!'),
            ),
          ],
        );
      },
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      // Process the form data
      print('Restaurant: $_selectedRestaurant');
      print('Start Time: ${_formatTimeOfDay(_startTime!)}');
      print('End Time: ${_formatTimeOfDay(_endTime!)}');
      print('Name: $_name');
      print('Contact Info: $_contactInfo');
      // You can navigate to another screen or show a confirmation message here
      _formKey.currentState!.reset();
      _showConfirmationDialog(context);
      // Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout Form'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  value: _selectedRestaurant,
                  hint: const Text('Select Restaurant'),
                  items: restaurants.map((String restaurant) {
                    return DropdownMenuItem<String>(
                      value: restaurant,
                      child: Text(restaurant),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedRestaurant = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select a restaurant' : null,
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color.fromARGB(255, 3, 71, 50),
                        ),
                        onPressed: () => _selectTimeRange(),
                        child: Text(_startTime == null
                            ? 'Select Start Time'
                            : 'Start: ${_formatTimeOfDay(_startTime!)}'),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color.fromARGB(255, 3, 71, 50),
                        ),
                        onPressed: () => _selectTimeRange(),
                        child: Text(_endTime == null
                            ? 'Select End Time'
                            : 'End: ${_formatTimeOfDay(_endTime!)}'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(
                        color: Color.fromARGB(255, 3, 71, 50)), // Label color
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(
                            255, 3, 71, 50), // Focused border color
                      ),
                    ),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter your name'
                      : null,
                  onSaved: (value) {
                    _name = value;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Contact Info',
                    labelStyle: TextStyle(
                        color: Color.fromARGB(255, 3, 71, 50)), // Label color
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(
                            255, 3, 71, 50), // Focused border color
                      ),
                    ),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter your contact info'
                      : null,
                  onSaved: (value) {
                    _contactInfo = value;
                  },
                ),
                const SizedBox(height: 40.0),
                ButtonComponent(
                  text: 'Done',
                  onTap: _submitForm,
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
