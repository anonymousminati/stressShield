import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:stress_sheild/feature/signIn_and_signUp/screens/login_screen.dart';
import 'package:stress_sheild/feature/signIn_and_signUp/screens/register_success.dart';
import 'package:stress_sheild/feature/signIn_and_signUp/services/firebase_auth_service.dart';


final UserInformation _userInformation = Get.put(UserInformation());
class UserInfo {
  String fullName;
  String uid;
  DateTime dateOfBirth;
  String gender;
  String location;
  double weight;
  String mobileNo;
  String governmentId;
  String emailId;
  Map scores = {
    'articles_scores':0,
    'audio_score': 0,
    'chatbot_score': 0,
    'course_score': 0,
    'mindful_hours_score': 0,
    'mood_score':0,
    'total_score':0,

  };
  UserInfo({

    required this.uid,
    required this.fullName,
    required this.dateOfBirth,
    required this.gender,
    required this.location,
    required this.weight,
    required this.mobileNo,
    required this.governmentId,
    required this.emailId,
    required this.scores,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fullName': fullName,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'location': location,
      'weight': weight,
      'mobileNo': mobileNo,
      'governmentId': governmentId,
      'emailId': emailId,
      'scores': scores,
    };
  }
}

class UserInfoPage extends StatefulWidget {
  final String uid;
  final String emailId;

  const UserInfoPage({Key? key, required this.uid, required this.emailId}) : super(key: key);

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
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

                TextFormField(
                  controller:_fullNameController,
                  decoration: InputDecoration(
                    labelText: 'FullName',
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
        //fullname

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
                        fullName: _fullNameController.text.trim(),
                        dateOfBirth: selectedDate,
                        gender: _genderController.text.trim(),
                        location: _locationController.text.trim(),
                        weight: double.parse(_weightController.text.trim()),
                        mobileNo: _mobileNoController.text.trim(),
                        governmentId: _governmentIdController.text.trim(),
                        emailId: widget.emailId, scores: {
                          'articles_scores':0,
                          'audio_score': 0,
                          'chatbot_score': 0,
                          'course_score': 0,
                          'mindful_hours_score': 0,
                          'mood_score':0,
                          'total_score':0,

                      },

                      );
                      // Save user information to Firestore
                      FirebaseAuthService().saveUserInfo('users', userInfo.toMap(), widget.uid);

                      // Navigate back to login screen
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterSuccessPage()));
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
