import 'package:flutter/material.dart';

import '../../helper/localStorage/preference_handler.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController designationController = TextEditingController();

  String? profileImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userDetails();
  }

  Future<void> userDetails() async {
    nameController.text = await PreferenceHandler.getName() ?? '';
    phoneController.text = "1234567890";
    emailController.text = await PreferenceHandler.getEmail() ?? '';
    designationController.text = "DESIGNATION";
    profileImage = await PreferenceHandler.getUserImage();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 3,
        shadowColor: Colors.grey,
        backgroundColor: Colors.white,
        title: Text(
          'YOUR PROFILE',
          style: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
          child: Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(profileImage ??
                      "https://images.unsplash.com/photo-1633332755192-727a05c4013d?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D"),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextFormField(
                          controller: nameController,
                          decoration: new InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(10),
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                            ),
                          ),
                          keyboardType: TextInputType.name,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: phoneController,
                          decoration: new InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(10),
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                            ),
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: new InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(10),
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: designationController,
                          decoration: new InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(10),
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                            ),
                          ),
                          keyboardType: TextInputType.name,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 100, vertical: 10),
                            ),
                            onPressed: () {},
                            child: Text('Update Profile',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
