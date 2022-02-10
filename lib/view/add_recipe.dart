import 'package:dinner_assistant_flutter/core/extension/context_extension.dart';
import 'package:dinner_assistant_flutter/core/theme/my_colors.dart';
import 'package:dinner_assistant_flutter/view/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class AddRecipe extends StatelessWidget {
  HtmlEditorController controller = HtmlEditorController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      const CustomAppBar(hasBack: true, title: 'Tarif Ekle'),
      Expanded(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    HtmlEditor(
                      htmlToolbarOptions: HtmlToolbarOptions(
                        
                        toolbarType: ToolbarType.nativeGrid),
                      controller: controller, //required
                      htmlEditorOptions: const HtmlEditorOptions(
                        hint: "Lütfen tarifinizi girin...",
                        //initalText: "text content initial, if any",
                      ),
                      otherOptions: OtherOptions(
                        height: context.dynamicHeight(0.8),
                      ),
                    )
                  ],
                ),
              )))
    ]));
  }
}
