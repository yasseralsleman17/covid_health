import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:covid_health/Screens/Doctor/doctor_home_page.dart';
import 'package:covid_health/Screens/login/login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:covid_health/Screens/Patient/add_disease_information.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool show_password = true;
  bool show_conferm_password = true;

  String full_name;
  String phone_number;

  String email;
  String account_type = "1";
  String gender = "male";

  String password = " ";
  String conferm_password;

  int _groupValue = 0;
  int _groupValue2 = 0;

  DateTime selectedDate;

  _selectDate(BuildContext context) {
    selectedDate = DateTime.now();
    final ThemeData theme = Theme.of(context);
    assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
        return buildMaterialDatePicker(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final focus = FocusNode();
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/images/saed.PNG",
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(15),
                  ],
                  validator: (val) => validateName(val),
                  onChanged: (value) {
                    setState(() {
                      full_name = value;
                    });
                    if (value.contains('\t')) {
                      setState(() {
                        full_name = value.replaceAll('\t', '');
                      });
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  decoration: InputDecoration(
                      errorText:
                          full_name != null ? validateName(full_name) : null,
                      icon: Icon(
                        Icons.person_outline,
                        color: Color(0xFF98b593),
                        size: 40,
                      ),
                      labelText: "Name"),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  validator: (val) => validateName(val),
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });

                    if (value.contains('\t')) {
                      setState(() {
                        email = value.replaceAll('\t', '');
                      });

                      FocusScope.of(context).nextFocus();
                    }
                  },
                  decoration: InputDecoration(
                      errorText: email != null ? validateEmail(email) : null,
                      icon: Icon(
                        Icons.mail,
                        color: Color(0xFF98b593),
                        size: 40,
                      ),
                      suffix: Text("@gmail.com"),
                      labelText: "Email"),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: IntlPhoneField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      errorText: phone_number != null
                          ? validatePhone(phone_number)
                          : null,
                      labelText: "Mobile Number"),
                  onChanged: (phone) {
                    setState(() {
                      phone_number = phone.completeNumber;
                      print(phone_number);
                    });

                  },
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  validator: (val) => !isPasswordValid(val)
                      ? 'Enter a Valid password\n'
                          'at least 8 chars and contain [ a-z A-Z 0-9 ]!!'
                      : null,
                  obscureText: show_password,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });

                    if (value.contains('\t')) {
                      password = value.replaceAll('\t', '');
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.lock,
                      color: Color(0xFF98b593),
                      size: 40,
                    ),
                    labelText: "Password",
                    suffixIcon: Container(
                      child: IconButton(
                        icon: Icon(
                          Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            show_password = !show_password;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  validator: (val) => confirmPassword(val),
                  obscureText: show_conferm_password,
                  onChanged: (value) {
                    setState(() {
                      conferm_password = value;
                    });

                    if (value.contains('\t')) {
                      conferm_password = value.replaceAll('\t', '');
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.lock,
                      color: Color(0xFF98b593),
                      size: 40,
                    ),
                    labelText: "Enter Password again ",
                    suffixIcon: Container(
                      child: IconButton(
                        icon: Icon(
                          Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            show_conferm_password = !show_conferm_password;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Container(
                margin: EdgeInsets.only(right: 25, left: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('Account type', style: TextStyle(fontSize: 18)),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: RadioListTile(
                                  value: 0,
                                  groupValue: _groupValue,
                                  title: Text(
                                    "Patient",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onChanged: (newValue) => setState(() {
                                    _groupValue = newValue;
                                    account_type = "1";
                                  }),
                                  activeColor: Color(0xFF98b593),
                                  selected: true,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: RadioListTile(
                                  value: 1,
                                  groupValue: _groupValue,
                                  title: Text("Doctor",
                                      style: TextStyle(color: Colors.black)),
                                  onChanged: (newValue) => setState(() {
                                    _groupValue = newValue;
                                    account_type = "2";
                                  }),
                                  activeColor: Color(0xFF98b593),
                                  selected: false,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Container(
                margin: EdgeInsets.only(right: 25, left: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('Gender', style: TextStyle(fontSize: 18)),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: RadioListTile(
                                  value: 0,
                                  groupValue: _groupValue2,
                                  title: Text(
                                    "Male",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onChanged: (newValue) => setState(() {
                                    _groupValue2 = newValue;
                                    gender = "Male";
                                  }),
                                  activeColor: Color(0xFF98b593),
                                  selected: true,
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: RadioListTile(
                                  value: 1,
                                  groupValue: _groupValue2,
                                  title: Text("Female",
                                      style: TextStyle(color: Colors.black)),
                                  onChanged: (newValue) => setState(() {
                                    _groupValue2 = newValue;
                                    gender = "Female";
                                  }),
                                  activeColor: Color(0xFF98b593),
                                  selected: false,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () => _selectDate(context),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      width: size.width * 0.4,
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Color(0xFF98b593),
                      ),
                      padding: const EdgeInsets.all(0),
                      child: Text(
                        "Select your birthday  ",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    selectedDate != null
                        ? "${selectedDate.toLocal()}".split(' ')[0]
                        : "",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.02),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: RaisedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      register();
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    width: size.width * 0.6,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Color(0xFF98b593),
                    ),
                    padding: const EdgeInsets.all(0),
                    child: Text(
                      "create an account ",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isPasswordValid(String password) {
    if (password.length < 8) return false;
    if (!password.contains(RegExp(r"[a-z]"))) return false;
    if (!password.contains(RegExp(r"[A-Z]"))) return false;
    if (!password.contains(RegExp(r"[0-9]"))) return false;
    return true;
  }

  String validateName(String value) {
    if (value.length == 0) {
      return '*Required Field';
    } else {
      return null;
    }
  }

  String confirmPassword(String value) {
    if (value.length == 0) {
      return '*Required Field';
    } else if (value != password) {
      return '*Passwords do not match';
    } else {
      return null;
    }
  }

  Future<void> register() async {
    if (selectedDate == null) {
      Fluttertoast.showToast(
          msg: "Select your birthday",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    int age = calculateAge(selectedDate);
    print(age);

    var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://covide.freehostksa.net/api/signup.php'));
    request.fields.addAll({
      'password': password,
      'name': full_name,
      'phone': phone_number,
      'email': email,
      'password2': password,
      'user_type': account_type,
      'age': age.toString(),
      'gender': gender
    });

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var allresponse = json.decode(await response.stream.bytesToString());
      var code = allresponse['code'].toString();
      var message = allresponse['message'];
      if (code == "-1") {
        Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
        return;
      }

      if (account_type == "1") {

        Fluttertoast.showToast(
            msg: "Account Created Successfully",
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);


        Navigator.push(context,
            MaterialPageRoute(
                builder: (context) =>
                    AddDiseaseInformation(
                      id: allresponse['data']['id'].toString(),
                      name: allresponse['data']['name'].toString(),
                    )));
      }

      if (account_type == "2") {
        Fluttertoast.showToast(
            msg: "Account Created Successfully",
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(context,
            MaterialPageRoute(
                builder: (context) =>
                    DoctorHomePage(
                      id: allresponse['data']['id'].toString(), name: full_name,)));
      }
    } else {
      print(response.reasonPhrase);
      print(response.request);
    }
  }

  validateEmail(String email) {
    if (email.isEmpty)
      return "*Required Field";
    else if (EmailValidator.validate(email))
      return null;
    else if (!EmailValidator.validate(email)) return "*Enter a valid email";
  }

  validatePhone(String phone_number) {
    if (phone_number.isEmpty)
      return "*Required Field";
    else
      return null;
  }

  buildMaterialDatePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1920),
      lastDate: DateTime(2022),
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDatePickerMode: DatePickerMode.day,
      selectableDayPredicate: _decideWhichDayToEnable,
      helpText: 'Select  date',
      cancelText: 'Cancel',
      confirmText: 'Ok',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
      fieldLabelText: 'Select date',
      fieldHintText: 'Month/Date/Year',
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isAfter(DateTime.utc(1900).subtract(Duration(days: 1))) &&
        day.isBefore(DateTime.now()))) {
      return true;
    }
    return false;
  }

  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }
}
