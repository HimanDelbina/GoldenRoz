import 'package:flutter/material.dart';
import 'package:nima/Static/static_file.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: AssetImage("assets/rg.png"),
          ),
        ),
        title: Text(
          "پروفایل",
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Row(
                  children: const [
                    CircleAvatar(
                      radius: 40.0,
                      child: Center(
                        child: Icon(Icons.person),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                indent: 20.0,
                endIndent: 20.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                child: Row(
                  children: [
                    Text(StaticFile.userName),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(StaticFile.userFamily),
                  ],
                ),
              ),
              const Divider(
                indent: 20.0,
                endIndent: 20.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                child: Row(
                  children: [
                    StaticFile.roleId == 1
                        ? const Text("گروه کاربری : " + "مدیر")
                        : StaticFile.roleId == 2
                            ? const Text("گروه کاربری : " + "منشی")
                            : StaticFile.roleId == 3
                                ? const Text("گروه کاربری : " + "اپراتور")
                                : StaticFile.roleId == 4
                                    ? const Text("گروه کاربری : " + "معرف")
                                    : StaticFile.roleId == 4
                                        ? const Text(
                                            "گروه کاربری : " + "نوبت دهی")
                                        : const Text("data")
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
