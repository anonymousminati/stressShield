import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stress_sheild/feature/signIn_and_signUp/services/firebase_auth_service.dart';

UserInformation _userInformation = Get.put(UserInformation());

class UpdateUserInfoPage extends StatefulWidget {
  const UpdateUserInfoPage({Key? key}) : super(key: key);

  @override
  _UpdateUserInfoPageState createState() => _UpdateUserInfoPageState();
}

class _UpdateUserInfoPageState extends State<UpdateUserInfoPage> {
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _governmentIdController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  bool _isLoading = true;
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  @override
  void initState() {
    super.initState();
    print("location ${_userInformation.userInformation['location']}");

    _fetchUserInformation();
  }

  Future<void> _fetchUserInformation() async {
    await _userInformation.fetchUserInformation();
    _setControllers();
  }

  void _setControllers() {
    setState(() {
      _locationController.text =
          _userInformation.userInformation['location'] ?? '';
      _weightController.text =
          _userInformation.userInformation['weight'].toString() ?? '';
      _mobileNoController.text =
          _userInformation.userInformation['mobileNo'] ?? '';
      _governmentIdController.text =
          _userInformation.userInformation['governmentId'] ?? '';
      _genderController.text = _userInformation.userInformation['gender'] ?? '';
      _dateOfBirthController.text = DateFormat('MM/dd/yyyy')
              .format(_userInformation.userInformation['dateOfBirth'].toDate())
              .toString() ??
          '';
    });

    if (_locationController.text.isNotEmpty) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update User Information'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(20.0),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        labelText: 'Location',
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.deepPurple.shade300),
                        ),
                        labelStyle: const TextStyle(color: Colors.deepPurple),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _weightController,
                      decoration: InputDecoration(
                        labelText: 'Weight',
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.deepPurple.shade300),
                        ),
                        labelStyle: const TextStyle(color: Colors.deepPurple),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _mobileNoController,
                      decoration: InputDecoration(
                        labelText: 'Mobile No',
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.deepPurple.shade300),
                        ),
                        labelStyle: const TextStyle(color: Colors.deepPurple),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _governmentIdController,
                      decoration: InputDecoration(
                        labelText: 'Government ID',
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.deepPurple.shade300),
                        ),
                        labelStyle: const TextStyle(color: Colors.deepPurple),
                      ),
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Gender',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      value: _genderController.text.isNotEmpty
                          ? _genderController.text
                          : null,
                      onChanged: (newValue) {
                        setState(() {
                          _genderController.text = newValue!;
                        });
                      },
                      items: ['Male', 'Female', 'Other'].map((gender) {
                        return DropdownMenuItem<String>(
                          value: gender,
                          child: Text(gender),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.deepPurple.shade300),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: ListTile(
                        title: Text(
                          'Date of Birth',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                        subtitle: Text(
                          '${_dateOfBirthController.text}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        onTap: () {
                          _selectDate(context);
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        // Update the UserInformation class's variables with the new values
                        DateTime parsedDate = DateFormat('MM/dd/yyyy')
                            .parse(_dateOfBirthController.text);

                        // Update the UserInformation class's variables with the new values
                        _userInformation.location.value =
                            _locationController.text;
                        _userInformation.weight.value =
                            double.parse(_weightController.text);
                        _userInformation.mobileNo.value =
                            _mobileNoController.text;
                        _userInformation.governmentId.value =
                            _governmentIdController.text;
                        _userInformation.gender.value = _genderController.text;
                        _userInformation.dateOfBirth.value =
                            Timestamp.fromDate(parsedDate);

                        // Call the uploadUserInformation function to store these updated values in the database
                        _userInformation.uploadUserInformation();
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.deepPurple.shade300),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text(
                            'Update',
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.deepPurple),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _userInformation.userInformation['dateOfBirth'].toDate(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null)
      setState(() {
        _dateOfBirthController.text =
            DateFormat('MM/dd/yyyy').format(pickedDate).toString();
      });
  }
}
