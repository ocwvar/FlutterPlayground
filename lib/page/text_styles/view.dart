import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/widget/platform/scaffold.dart';

import '../../widget/platform/app_bar.dart';

class TextStylesView extends StatelessWidget {
  const TextStylesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      isiOSLargeStyle: true,
      platformAppBar: PlatformAppBar(
          context: context,
          title: "Text styles",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20, left: 12),
              child: Text("Default Style", style: TextStyle(fontSize: 20.0),),
            ),
            const Divider(height: 1, thickness: 1,),

            wrapText(context, "default text ( TextStyle = null )", null),

            const Padding(
              padding: EdgeInsets.only(top: 20, left: 12),
              child: Text("Android Material Styles", style: TextStyle(fontSize: 20.0),),
            ),
            const Divider(height: 1, thickness: 1,),
            wrapText(context, "titleLarge", Theme.of(context).textTheme.titleLarge),
            wrapText(context, "titleMedium", Theme.of(context).textTheme.titleMedium),
            wrapText(context, "titleSmall", Theme.of(context).textTheme.titleSmall),

            wrapText(context, "bodyLarge", Theme.of(context).textTheme.bodyLarge),
            wrapText(context, "bodyMedium", Theme.of(context).textTheme.bodyMedium),
            wrapText(context, "bodySmall", Theme.of(context).textTheme.bodySmall),
            wrapText(context, "bodyText1", Theme.of(context).textTheme.bodyText1),
            wrapText(context, "bodyText2", Theme.of(context).textTheme.bodyText2),

            wrapText(context, "labelLarge", Theme.of(context).textTheme.labelLarge),
            wrapText(context, "labelMedium", Theme.of(context).textTheme.labelMedium),
            wrapText(context, "labelSmall", Theme.of(context).textTheme.labelSmall),

            wrapText(context, "headlineLarge", Theme.of(context).textTheme.headlineLarge),
            wrapText(context, "headlineMedium", Theme.of(context).textTheme.headlineMedium),
            wrapText(context, "headlineSmall", Theme.of(context).textTheme.headlineSmall),
            wrapText(context, "headline1", Theme.of(context).textTheme.headline1),
            wrapText(context, "headline2", Theme.of(context).textTheme.headline2),
            wrapText(context, "headline3", Theme.of(context).textTheme.headline3),
            wrapText(context, "headline4", Theme.of(context).textTheme.headline4),
            wrapText(context, "headline5", Theme.of(context).textTheme.headline5),
            wrapText(context, "headline6", Theme.of(context).textTheme.headline6),

            wrapText(context, "displayLarge", Theme.of(context).textTheme.displayLarge),
            wrapText(context, "displayMedium", Theme.of(context).textTheme.displayMedium),
            wrapText(context, "displaySmall", Theme.of(context).textTheme.displaySmall),

            wrapText(context, "button", Theme.of(context).textTheme.button),

            wrapText(context, "caption", Theme.of(context).textTheme.caption),

            const Padding(
              padding: EdgeInsets.only(top: 20, left: 12),
              child: Text("iOS Cupertino Styles", style: TextStyle(fontSize: 20.0),),
            ),
            const Divider(height: 1, thickness: 1,),

            wrapText(context, "default iOS textStyle", CupertinoTheme.of(context).textTheme.textStyle),
            wrapText(context, "tabLabelTextStyle", CupertinoTheme.of(context).textTheme.tabLabelTextStyle),
            wrapText(context, "pickerTextStyle", CupertinoTheme.of(context).textTheme.pickerTextStyle),
            wrapText(context, "navActionTextStyle", CupertinoTheme.of(context).textTheme.navActionTextStyle),
            wrapText(context, "actionTextStyle", CupertinoTheme.of(context).textTheme.actionTextStyle),
            wrapText(context, "dateTimePickerTextStyle", CupertinoTheme.of(context).textTheme.dateTimePickerTextStyle),
            wrapText(context, "navLargeTitleTextStyle", CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle),
            wrapText(context, "navTitleTextStyle", CupertinoTheme.of(context).textTheme.navTitleTextStyle),
          ],
        ),
      ),
    );
  }

  Widget wrapText(BuildContext context, String text, TextStyle? style) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ColoredBox(
        color: Theme.of(context).primaryColor.withAlpha(50),
        child: Text(text, style: style),
      )
    );
  }
}