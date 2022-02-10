import 'package:cached_network_image/cached_network_image.dart';
import 'package:dinner_assistant_flutter/core/extension/context_extension.dart';
import 'package:dinner_assistant_flutter/core/model/recipes_model.dart';
import 'package:dinner_assistant_flutter/core/theme/my_colors.dart';
import 'package:dinner_assistant_flutter/view/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class RecipeDetail extends StatelessWidget {
  const RecipeDetail({Key? key, required this.data}) : super(key: key);

  final RecipesModel data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.background,
        body: Column(children: [
          CustomAppBar(hasBack: true, title: data.title),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CachedNetworkImage(imageUrl: data.imageUrl),
                  const SizedBox(
                    height: 8,
                  ),
                  titleContainer(context, 'Gereksinimler'),
                  Html(
                    data: data.requirements,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  titleContainer(context, 'Yapılışı'),
                  const SizedBox(
                    height: 8,
                  ),
                  Html(
                    data: data.making,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                ]),
          ))
        ]));
  }

  Container titleContainer(BuildContext context, String text) {
    return Container(
      width: context.dynamicWidth(0.5),
      decoration: const BoxDecoration(
        color: MyColors.lightBlue,
        borderRadius:
            BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
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
