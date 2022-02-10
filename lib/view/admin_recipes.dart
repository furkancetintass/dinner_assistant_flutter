import 'package:cached_network_image/cached_network_image.dart';
import 'package:dinner_assistant_flutter/core/extension/context_extension.dart';
import 'package:dinner_assistant_flutter/core/model/recipes_model.dart';
import 'package:dinner_assistant_flutter/core/theme/my_colors.dart';
import 'package:dinner_assistant_flutter/view/recipe_detail.dart';
import 'package:dinner_assistant_flutter/view/widget/custom_app_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class AdminRecipes extends StatefulWidget {
  const AdminRecipes({Key? key}) : super(key: key);

  @override
  State<AdminRecipes> createState() => _AdminRecipesState();
}

class _AdminRecipesState extends State<AdminRecipes> {
  late Future future;

  @override
  void initState() {
    future = FirebaseDatabase.instance.reference().child('recipes').once();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const CustomAppBar(hasBack: false, title: 'Tarifler'),
          Expanded(
            child: FutureBuilder(
                future: future,
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData == true) {
                    List<RecipesModel> data = [];

                    var gelen = snapshot.data.value;

                    gelen.forEach((value) {
                      var incomingData = RecipesModel.fromJson(value);
                      data.add(incomingData);
                    });

                    return ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              pushNewScreen(context,
                                  withNavBar: false, screen: RecipeDetail(data: data[index]));
                            },
                            child: Column(
                              children: [
                                titleContainer(context, data[index].title),
                                cacheImage(data[index].imageUrl),
                                const SizedBox(height: 24),
                              ],
                            ),
                          );
                        });
                  } else if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Container();
                  }
                }),
          )
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
              bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Container titleContainer(BuildContext context, String text) {
    return Container(
      width: context.dynamicWidth(1),
      decoration: const BoxDecoration(
        color: MyColors.lightBlue,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
