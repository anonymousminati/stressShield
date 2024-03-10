import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stress_sheild/feature/signIn_and_signUp/screens/login_screen.dart';
import 'package:stress_sheild/feature/signIn_and_signUp/services/firebase_auth_service.dart';

class UserInfo {
  String uid;
  DateTime dateOfBirth;
  String gender;
  String location;
  double weight;
  String mobileNo;
  String governmentId;

  UserInfo({
    required this.uid,
    required this.dateOfBirth,
    required this.gender,
    required this.location,
    required this.weight,
    required this.mobileNo,
    required this.governmentId,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'location': location,
      'weight': weight,
      'mobileNo': mobileNo,
      'governmentId': governmentId,
    };
  }
}

class UserInfoPage extends StatefulWidget {
  final String uid;

  const UserInfoPage({Key? key, required this.uid}) : super(key: key);

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _governmentIdController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Information'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date of Birth
                // Date of Birth
                ListTile(
                  title: Text(
                    'Date of Birth',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  subtitle: Text(
                    '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  onTap: () {
                    _selectDate(context);
                  },
                ),

        // Gender Dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                  value: _genderController.text.isNotEmpty ? _genderController.text : null,
                  onChanged: (newValue) {
                    setState(() {
                      _genderController.text = newValue!;
                    });
                  },
                  items: ['Male', 'Female', 'Don\'t want to specify']
                      .map((gender) {
                    return DropdownMenuItem<String>(
                      value: gender,
                      child: Text(gender),
                    );
                  })
                      .toList(),
                ),

        // Location
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    labelText: 'Location',
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style: TextStyle(fontSize: 16.0),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your location';
                    }
                    return null;
                  },
                ),

        // Weight
                TextFormField(
                  controller: _weightController,
                  decoration: InputDecoration(
                    labelText: 'Weight',
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style: TextStyle(fontSize: 16.0),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your weight';
                    }
                    return null;
                  },
                ),

        // Mobile Number
                TextFormField(
                  controller: _mobileNoController,
                  decoration: InputDecoration(
                    labelText: 'Mobile No.',
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style: TextStyle(fontSize: 16.0),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your mobile number';
                    } else if (value.length != 10) {
                      return 'Mobile number should be 10 digits';
                    }
                    return null;
                  },
                ),

        // Government ID
                TextFormField(
                  controller: _governmentIdController,
                  decoration: InputDecoration(
                    labelText: 'Government ID',
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  style: TextStyle(fontSize: 16.0),
                ),

                SizedBox(height: 16.0),

                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Form is valid, save data to Firestore
                      UserInfo userInfo = UserInfo(
                        uid: widget.uid,
                        dateOfBirth: selectedDate,
                        gender: _genderController.text.trim(),
                        location: _locationController.text.trim(),
                        weight: double.parse(_weightController.text.trim()),
                        mobileNo: _mobileNoController.text.trim(),
                        governmentId: _governmentIdController.text.trim(),
                      );
                      // Save user information to Firestore
                      FirebaseAuthService().saveUserInfo('users', userInfo.toMap(), widget.uid);

                      // Navigate back to login screen
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                      TextStyle(fontSize: 16.0),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  child: Text('Save'),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != selectedDate)
      setState(() {
        selectedDate = pickedDate;
        _dateOfBirthController.text = pickedDate.toString();
      });
  }


}
