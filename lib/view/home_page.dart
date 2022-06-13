import 'package:cached_network_image/cached_network_image.dart';
import 'package:dinner_assistant_flutter/core/extension/context_extension.dart';
import 'package:dinner_assistant_flutter/core/model/recipes_model.dart';
import 'package:dinner_assistant_flutter/core/theme/my_colors.dart';
import 'package:dinner_assistant_flutter/view/add_recipe.dart';
import 'package:dinner_assistant_flutter/view/recipe_detail.dart';
import 'package:dinner_assistant_flutter/view/widget/custom_app_bar.dart';
import 'package:dinner_assistant_flutter/view/widget/primary_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../core/model/user_recipes_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future future;

  @override
  void initState() {
    future = FirebaseDatabase.instance.reference().child('user-recipes').once();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const CustomAppBar(hasBack: false, title: 'Ana Sayfa'),
        Expanded(
          child: FutureBuilder(
              future: future,
              builder: (context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData == true &&
                    snapshot.data.value != null) {
                  List<UserRecipesModel> data = [];

                  var incomings = snapshot.data.value;

                  incomings.forEach((key, value) {
                    value.forEach((key, value) {
                      var incomingData = UserRecipesModel.fromJson(value);
                      data.add(incomingData);
                    });
                  });

                  return ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: data.length,
                      separatorBuilder: (_, __) => const SizedBox(
                            height: 12,
                          ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Card(
                            margin: const EdgeInsets.all(8),
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            elevation: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                titleContainer(
                                  context,
                                  data[index].title,
                                  data[index].type,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Malzemeler',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black45,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(data[index].requirements),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Yapılışı',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black45,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(data[index].making),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return recipeNotFoundWidget(context);
                }
              }),
        ),
        SizedBox(
          width: double.maxFinite,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true)
                    .push(
                  MaterialPageRoute(
                    builder: (_) => AddRecipe(),
                  ),
                )
                    .then((value) {
                  setState(() {
                    future = FirebaseDatabase.instance
                        .reference()
                        .child('user-recipes')
                        .once();
                  });
                });
              },
              child: const Text('Tarif Ekle'),
            ),
          ),
        )
      ],
    ));
  }

  Widget recipeNotFoundWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/lottie/not-found.json'),
          const Text(
            'Toplulukta kayıtlı kullanıcıların yemek tarifi bulunamadı',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 36),
          PrimaryButton(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .push(
                  MaterialPageRoute(
                    builder: (_) => AddRecipe(),
                  ),
                )
                    .then((value) {
                  setState(() {
                    future = FirebaseDatabase.instance
                        .reference()
                        .child('user-recipes')
                        .once();
                  });
                });
              },
              lightColor: MyColors.lightBlue,
              darkColor: MyColors.darkBlue,
              child: const Text('Yeni Tarif Ekle',
                  style: TextStyle(
                    color: Colors.white,
                  )))
        ],
      ),
    );
  }

  CachedNetworkImage cacheImage(String imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        height: context.dynamicHeight(0.2),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: MyColors.secondaryColor,
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(3, 7), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12)),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Container titleContainer(BuildContext context, String text, String text2) {
    return Container(
      width: context.dynamicWidth(1),
      decoration: const BoxDecoration(
        color: MyColors.lightBlue,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Flexible(
              child: Text(
                'Tarif türü: ' + text2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
