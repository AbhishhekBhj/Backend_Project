import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/utils/texts/texts.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ListView(
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back)),
            const Text(
              "Edit Profile",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            )
          ],
        ),
        Container(
          child: Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage(splashImage),
                  ),
                  Positioned(
                      right: Get.width * 0.06,
                      top: Get.height * 0.2,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(FontAwesomeIcons.cameraRetro),
                        color: Colors.blueAccent,
                      ))
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [EditProfileInformationForm(formKey: _formKey)],
          ),
        )
      ],
    )));
  }
}

class EditProfileInformationForm extends StatelessWidget {
  EditProfileInformationForm({
    Key? key,
    required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController bodyWeightController = TextEditingController();

  String? _validateNonEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: usernameController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: "Enter username",
            ),
            validator: _validateNonEmpty,
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: fullNameController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: "Enter full name",
            ),
            validator: _validateNonEmpty,
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: ageController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: "Enter age",
            ),
            validator: _validateNonEmpty,
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: bodyWeightController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: "Enter Body Weight",
            ),
            validator: _validateNonEmpty,
          ),
          SizedBox(
            height: Get.height * 0.05,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, foregroundColor: Colors.white),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                String username = usernameController.text;
                String fullName = fullNameController.text;
                String age = ageController.text;
                String bodyWeight = bodyWeightController.text;

                //TODO: post this data in backend
              }
            },
            child: Text("EDIT PROFILE"),
          )
        ],
      ),
    );
  }
}
