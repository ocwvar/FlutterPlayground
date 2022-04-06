import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_playground/page/language/model.dart';
import 'package:flutter_playground/widget/app_bar.dart';

import '../../generated/l10n.dart';

class LanguageView extends StatefulWidget {

  final LanguagePlaceHolderModel model = LanguagePlaceHolderModel();

  LanguageView({Key? key}) : super(key: key);

  @override
  State createState() => _LanguageView();
}

class _LanguageView extends State<LanguageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(context, "Multi language", true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Current system locale", style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.left,),
            Text(Platform.localeName),
            const SizedBox(height: 20,),
            Text("Local control", style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.left,),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => changeLocal(1),
                    child: const Text("Simplified Chinese")
                )
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => changeLocal(2),
                    child: const Text("Traditional Chinese")
                )
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => changeLocal(0),
                    child: const Text("English")
                )
            ),
            const SizedBox(height: 20,),
            Text("Regular text", style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.left,),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                child: Card(
                  color: Theme.of(context).cardColor,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Text(S.of(context).whatsTheWeather, style: Theme.of(context).textTheme.bodyText1),
                        Text(S.of(context).missingOtherTranslate, style: Theme.of(context).textTheme.bodyText1),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Text("Text with placeholder", style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.left,),
            Row(
              children: [
                Flexible(
                    child: TextField(
                      decoration: const InputDecoration(
                        label: Text("placeholder 1"),
                      ),
                      onChanged: (text) {
                        setState(() {
                          widget.model.updatePlaceHolder(1, text);
                        });
                      },
                    )
                ),
                const SizedBox(width: 10,),
                Flexible(
                    child: TextField(
                      decoration: const InputDecoration(
                        label: Text("placeholder 2"),
                      ),
                      onChanged: (text) {
                        setState(() {
                          widget.model.updatePlaceHolder(2, text);
                        });
                      },
                    )
                )
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                child: Card(
                  color: Theme.of(context).cardColor,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Text(S.of(context).placeHolderTesting(widget.model.get(1), widget.model.get(2)), style: Theme.of(context).textTheme.bodyText1),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// change current local to english or chinese
  void changeLocal(int languageType) {
    final Locale newLocale;
    switch (languageType) {
      case 0:
        newLocale = const Locale("en", "");
        break;
      case 1:
        newLocale = const Locale("zh", "");
        break;
      case 2:
        newLocale = const Locale("zh", "hk");
        break;

      default:
        newLocale = const Locale("en", "");
        break;
    }

    S.load(newLocale);
    setState(() {});
  }

}