import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/page/language/model.dart';
import 'package:flutter_playground/widget/platform/base.dart';
import 'package:flutter_playground/widget/platform/button.dart';
import 'package:flutter_playground/widget/platform/card.dart';
import 'package:flutter_playground/widget/platform/input_field.dart';
import 'package:flutter_playground/widget/platform/styles.dart';

import '../../generated/l10n.dart';
import '../../widget/platform/app_bar.dart';
import '../../widget/platform/scaffold.dart';

class LanguageView extends StatefulWidget {

  final LanguagePlaceHolderModel model = LanguagePlaceHolderModel();

  LanguageView({Key? key}) : super(key: key);

  @override
  State createState() => _LanguageView();
}

class _LanguageView extends State<LanguageView> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      isiOSLargeStyle: true,
      platformAppBar: PlatformAppBar(
          context: context,
          title: "Multi language"
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Current system locale", style: PlatformTextStyles.forTitle(context), textAlign: TextAlign.left,),
            Text(Platform.localeName),
            const SizedBox(height: 20,),
            Text("Local control", style: PlatformTextStyles.forTitle(context), textAlign: TextAlign.left,),
            SizedBox(
                width: double.infinity,
                child: PlatformButton(
                    onPressed: () => changeLocal(1),
                    child: const Text("Simplified Chinese")
                )
            ),
            SizedBox(
                width: double.infinity,
                child: PlatformButton(
                    onPressed: () => changeLocal(2),
                    child: const Text("Traditional Chinese")
                )
            ),
            SizedBox(
                width: double.infinity,
                child: PlatformButton(
                    onPressed: () => changeLocal(0),
                    child: const Text("English")
                )
            ),
            const SizedBox(height: 20,),
            Text("Regular text", style: PlatformTextStyles.forTitle(context), textAlign: TextAlign.left,),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                child: PlatformCardView(
                  cardColor: getNotNullablePlatformObject(
                      forAndroid: Theme.of(context).primaryColor.withOpacity(0.2),
                      forIOS: CupertinoTheme.of(context).primaryColor.withOpacity(0.2)
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Text(S.of(context).whatsTheWeather, style: PlatformTextStyles.forContent(context)),
                      Text(S.of(context).missingOtherTranslate, style: PlatformTextStyles.forContent(context)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Text("Text with placeholder", style: PlatformTextStyles.forTitle(context), textAlign: TextAlign.left,),
            Row(
              children: [
                Flexible(
                    child: PlatformInputField(
                      iosHint: "placeholder 1",
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
                    child: PlatformInputField(
                      iosHint: "placeholder 2",
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
                child: PlatformCardView(
                    cardColor: getNotNullablePlatformObject(
                        forAndroid: Theme.of(context).primaryColor.withOpacity(0.2),
                        forIOS: CupertinoTheme.of(context).primaryColor.withOpacity(0.2)
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Text(
                            S.of(context).placeHolderTesting(widget.model.get(1), widget.model.get(2)),
                            style: PlatformTextStyles.forContent(context)
                        ),
                      ],
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