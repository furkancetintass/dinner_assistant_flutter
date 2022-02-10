import 'package:dinner_assistant_flutter/core/extension/context_extension.dart';
import 'package:dinner_assistant_flutter/core/interface/auth_interface.dart';
import 'package:dinner_assistant_flutter/core/model/user_model.dart';
import 'package:dinner_assistant_flutter/core/theme/my_colors.dart';
import 'package:dinner_assistant_flutter/view/auth_screen.dart';
import 'package:dinner_assistant_flutter/view/widget/custom_app_bar.dart';
import 'package:dinner_assistant_flutter/view/widget/my_text_field.dart';
import 'package:dinner_assistant_flutter/view/widget/primary_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  late Future future;

  @override
  void initState() {
    future = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(Provider.of<AuthInterface>(context, listen: false).userCredential.data!.user!.uid)
        .once();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var authService = Provider.of<AuthInterface>(context);
    return Scaffold(
      backgroundColor: MyColors.background,
      body: Column(
        children: [
          const CustomAppBar(hasBack: false, title: 'Hesabım'),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: FutureBuilder(
                    future: future,
                    builder: (context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData == true) {
                        UserModel user = UserModel.fromJson(snapshot.data.value);
                        firstNameController.text = user.firstName;
                        lastNameController.text = user.lastName;
                        emailController.text = user.email;

                        return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              'assets/images/logo.png',
                              width: context.dynamicWidth(0.5),
                            ),
                          ),
                          // const Icon(
                          //   CupertinoIcons.person_alt,
                          //   color: MyColors.lightBlue,
                          //   size: 140,
                          // ),
                          const SizedBox(height: 24),
                          buildTextField(
                              label: 'İsim', controller: firstNameController, readOnly: true),
                          const SizedBox(height: 24),
                          buildTextField(
                              label: 'Soy İsim', controller: lastNameController, readOnly: true),
                          const SizedBox(height: 24),
                          buildTextField(
                              label: 'E Posta', controller: emailController, readOnly: true),
                          const SizedBox(height: 24),
                          PrimaryButton(
                            onTap: () {
                              pushNewScreen(
                                context,
                                screen: AuthScreen(),
                                withNavBar: false,
                              );

                              authService.signOut();
                            },
                            child: const Text(
                              'Çıkış Yap',
                              style: TextStyle(color: Colors.white),
                            ),
                            darkColor: Colors.red.shade900,
                            lightColor: Colors.redAccent,
                          )
                        ]);
                      } else if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return Container();
                      }
                    })),
          )
        ],
      ),
    );
  }
}
