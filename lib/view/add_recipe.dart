import 'package:dinner_assistant_flutter/core/interface/auth_interface.dart';
import 'package:dinner_assistant_flutter/core/service/auth_service.dart';
import 'package:dinner_assistant_flutter/core/service/database_service.dart';
import 'package:dinner_assistant_flutter/core/utils/utils.dart';
import 'package:dinner_assistant_flutter/locator.dart';
import 'package:dinner_assistant_flutter/view/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRecipe extends StatefulWidget {
  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  TextEditingController titleController = TextEditingController();
  TextEditingController makingController = TextEditingController();
  TextEditingController requirementsController = TextEditingController();
  TextEditingController typeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthInterface authViewModel = context.read<AuthInterface>();
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return Future.value(true);
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            body: Column(children: [
          const CustomAppBar(hasBack: true, title: 'Tarif Ekle'),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 36,
                        ),
                        buildTextField(
                            label: 'Tarif Türü',
                            controller: typeController,
                            readOnly: true,
                            onTap: () => showModalBottomSheet(
                                context: context,
                                builder: (
                                  _,
                                ) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.5,
                                      width: double.maxFinite,
                                      child: Column(
                                        children: [
                                          const Text(
                                            'Tarif türünü listeden seçiniz',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Divider(
                                            height: 20,
                                          ),
                                          SizedBox(
                                            height: (MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.5) -
                                                50,
                                            width: double.maxFinite,
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: List.generate(
                                                  recipeTypes.length,
                                                  (index) => SizedBox(
                                                    width: double.maxFinite,
                                                    child: OutlinedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        typeController.text =
                                                            recipeTypes[index];
                                                      },
                                                      child: Text(
                                                        recipeTypes[index],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                })),
                        const SizedBox(
                          height: 16,
                        ),
                        buildTextField(
                            label: 'Tarif Başlığı',
                            controller: titleController),
                        const SizedBox(
                          height: 16,
                        ),
                        buildTextField(
                          label: 'Gerekli Malzemeler',
                          controller: requirementsController,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        buildTextField(
                          label: 'Tarif Yapılışı',
                          controller: makingController,
                          maxLines: null,
                          minLines: 10,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          width: double.maxFinite,
                          child: OutlinedButton(
                            onPressed: () {
                              if (typeController.text.isNotEmpty &&
                                  titleController.text.isNotEmpty &&
                                  makingController.text.isNotEmpty &&
                                  requirementsController.text.isNotEmpty) {
                                locator<Database>()
                                    .createRecipe(
                                        authViewModel
                                            .userCredential.data!.user!.uid,
                                        titleController.text,
                                        makingController.text,
                                        requirementsController.text,
                                        typeController.text)
                                    .then((value) {
                                  locator<Utils>().showSuccessSnackBar(context);
                                  typeController.text = '';
                                  titleController.text = '';
                                  makingController.text = '';
                                  requirementsController.text = '';
                                });
                              } else {
                                locator<Utils>().showErrorSnackBar(context,
                                    'Bütün bilgileri eksiksiz doldurmanız gerekmektedir');
                              }
                            },
                            child: const Text(
                              'Tarifi Kaydet',
                            ),
                          ),
                        )
                      ],
                    ),
                  )))
        ])),
      ),
    );
  }

  List<String> recipeTypes = [
    'Tatlı Tarifleri',
    'Kurabiye Tarifleri',
    'Diyet Yemekleri',
    'Hamur İşi Tarifleri',
    'Salata & Meze & Kanepe',
    'Sebze Yemekleri',
    'Hızlı Yemekler',
    'Et Yemekleri',
    'Bakliyat Yemekleri',
    'Çorba Tarifleri',
    'Aperatifler',
  ];

  TextFormField buildTextField(
      {required String label,
      required TextEditingController controller,
      Widget? icon,
      context,
      int? maxLines,
      int? minLines,
      bool? readOnly,
      void Function()? onTap}) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      maxLines: maxLines,
      minLines: minLines,
      readOnly: readOnly ?? false,
      decoration: InputDecoration(
        icon: icon,
        labelText: label,
      ),
    );
  }
}
