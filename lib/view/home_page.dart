import 'package:dinner_assistant_flutter/core/theme/my_colors.dart';
import 'package:dinner_assistant_flutter/view/add_recipe.dart';
import 'package:dinner_assistant_flutter/view/widget/custom_app_bar.dart';
import 'package:dinner_assistant_flutter/view/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const CustomAppBar(hasBack: false, title: 'Ana Sayfa'),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Lottie.asset('assets/lottie/not-found.json'),
              const Text('Toplulukta kayıtlı kullanıcıların yemek tarifi bulunamadı'),
              const SizedBox(height: 36),
              PrimaryButton(
                  onTap: () {
                    pushNewScreen(context, withNavBar: false, screen: AddRecipe());
                  },
                  lightColor: MyColors.lightBlue,
                  darkColor: MyColors.darkBlue,
                  child: const Text('Yeni Tarif Ekle',
                      style: TextStyle(
                        color: Colors.white,
                      )))
            ],
          ),
        ))
      ],
    ));
  }
}
