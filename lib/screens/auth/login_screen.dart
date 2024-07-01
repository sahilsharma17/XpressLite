import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:xpresslite/Widget/dailog/OtpDailog.dart';
import 'package:xpresslite/helper/app_utilities/method_utils.dart';
import 'package:xpresslite/helper/constant/appMessages.dart';
import 'package:xpresslite/helper/custom_widgets/accessDenied/accessDenied.dart';
import 'package:xpresslite/helper/custom_widgets/app_circular_loader.dart';
import 'package:xpresslite/helper/routeAndBlocManager/navigator.dart';
import 'package:xpresslite/screens/auth/cubit/login_cubit.dart';
import 'package:xpresslite/screens/auth/cubit/login_state.dart';
import 'package:xpresslite/screens/home/home_screen.dart';
import 'package:xpresslite/screens/splash_screen.dart';

import '../appNavBar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _mobileController = TextEditingController();
  bool rememeberMe = true;
  late LoginCubit _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of<LoginCubit>(context);

    _mobileController.text = '9876543210';
    rememeberMe = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      builder: (BuildContext context, state) {
        if (state is LoginLoaded || state is LoginInitial || state is LoginError) {
          return body();
        } else if (state is LoginLoading) {
          return Stack(
            children: [body(), AppLoaderProgress()],
          );
        }
        return AccessDeniedScreen(
          onPressed: () {
            _cubit.refresh();
          },
        );
      },
      listener: (BuildContext context, state) {
        if (state is LoginError) {
          if (state.error.isNotEmpty) {
            MethodUtils.toast(state.error);
          }
        } else if (state is LoginLoaded) {
          if (state.msg == "OTPDialog") {
            showOtpDailog();
          } else {
            MethodUtils.toast(state.msg);
            Future.delayed(const Duration(milliseconds: 500));
            Get.to(() => AppNavBar());
          }
        }
      },
    );
  }

  body() {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg_login.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 130, 10, 130),
                  child: Column(
                    children: [
                      Container(
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/app_logo.png',
                                height: 40,
                                width: 40,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Xpress',
                                style: TextStyle(
                                    fontSize: 35,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.italic),
                              ),
                              Text(
                                'Lite',
                                style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Proceed with your',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Card(
                        elevation: 5,
                        child: Container(
                          height: 300,
                          width: 340,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                            child: Column(
                              children: [
                                Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 30, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text('Mobile')),
                                    TextFormField(
                                      cursorColor: Colors.orange,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(10),
                                      ],
                                      keyboardType: TextInputType.number,
                                      controller: _mobileController,
                                      decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding: EdgeInsets.all(10),
                                          hintText: "Enter your Mobile Number",
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.deepOrangeAccent.shade100,
                                                width: 2.0),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        enabledBorder : OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.deepOrangeAccent.shade100,
                                              width: 2.0),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.deepOrangeAccent.shade100,
                                                width: 2.0),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter a Mobile Number';
                                        }
                                        if (value.length != 10) {
                                          return 'Mobile Number must be at least 10 characters';
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Remember Me',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Transform.scale(
                                          scale: 0.8,
                                          child: Switch(
                                              value: rememeberMe,
                                              inactiveThumbColor: Colors.grey,
                                              activeColor: Colors.deepOrangeAccent,
                                              onChanged: (bool value) {
                                                setState(() {
                                                  rememeberMe = value;
                                                });
                                              }),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: 150,
                                      height: 35,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          print('Continue Pressed');
                                          _cubit.mobileValidation(_mobileController.text);
                                        },
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all<Color>(
                                              Colors.black45),
                                        ),
                                        child: Text(
                                          'Continue',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  showOtpDailog() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => OtpDailog(
        onPressed: (otp) {
          if (otp.length != 6) {
            MethodUtils.toast(AppMessages.otpCheck);
          } else {
            _cubit.verifyOtp(_mobileController.text, otp);
          }
        },
      ),
    );
  }
}
