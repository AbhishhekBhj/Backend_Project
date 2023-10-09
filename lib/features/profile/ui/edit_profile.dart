import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/utils/texts/texts.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
              const CircleAvatar(
                backgroundImage: NetworkImage(temporaryDP),
                radius: 100,
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Change Profile Picture",
                  style: TextStyle(color: Colors.blueAccent),
                ),
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: "Enter  username"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: "Enter  full name"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(), hintText: "Enter age"),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        )
      ],
    )));
  }
}
