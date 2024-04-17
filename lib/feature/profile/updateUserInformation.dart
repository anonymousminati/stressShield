import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stress_sheild/feature/home_and_mental_health_score/screens/customnavbar.dart';
import 'package:stress_sheild/feature/home_and_mental_health_score/screens/landing_home_page.dart';
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

class UpdateUserInfoPage extends StatefulWidget {
  final String uid;

  const UpdateUserInfoPage({Key? key, required this.uid}) : super(key: key);

  @override
  _UpdateUserInfoPageState createState() => _UpdateUserInfoPageState();
}

class _UpdateUserInfoPageState extends State<UpdateUserInfoPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _governmentIdController = TextEditingController();

  late UserInfo userInfo = UserInfo(
    uid: '',
    dateOfBirth: DateTime.now(),
    gender: '',
    location: '',
    weight: 0,
    mobileNo: '',
    governmentId: '',
  );

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  Future<void> fetchUserInfo() async {
    setState(() {
      isLoading = true;
    });

    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(widget.uid)
        .get();

    setState(() {
      userInfo = UserInfo(
        uid: widget.uid,
        dateOfBirth: (snapshot['dateOfBirth'] as Timestamp).toDate(),
        gender: snapshot['gender'],
        location: snapshot['location'],
        weight: snapshot['weight'].toDouble(),
        mobileNo: snapshot['mobileNo'],
        governmentId: snapshot['governmentId'],
      );

      _locationController.text = userInfo.location;
      _weightController.text = userInfo.weight.toString();
      _mobileNoController.text = userInfo.mobileNo;
      _governmentIdController.text = userInfo.governmentId;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update User Information'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        'Date of Birth',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                      subtitle: Text(
                        '${userInfo.dateOfBirth.year}-${userInfo.dateOfBirth.month}-${userInfo.dateOfBirth.day}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      onTap: () {
                        _selectDate(context);
                      },
                    ),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Gender',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                      value: userInfo.gender,
                      onChanged: (newValue) {
                        setState(() {
                          userInfo.gender = newValue!;
                        });
                      },
                      items: ['Male', 'Female', 'Don\'t want to specify']
                          .map((gender) {
                        return DropdownMenuItem<String>(
                          value: gender,
                          child: Text(gender),
                        );
                      }).toList(),
                    ),
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
                          updateUserInformation();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                        textStyle: TextStyle(fontSize: 16.0),
                        padding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 32.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text('Save'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: userInfo.dateOfBirth,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        userInfo.dateOfBirth = pickedDate;
      });
    }
  }

  Future<void> updateUserInformation() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
        .update(userInfo.toMap());
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => BottomNavWithAnimations()));
  }
}
