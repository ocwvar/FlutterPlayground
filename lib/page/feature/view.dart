import 'package:flutter/material.dart';
import 'package:flutter_playground/page/accessibility/view.dart';
import 'package:flutter_playground/page/demo_account/account_list/view.dart';
import 'package:flutter_playground/page/dynamic_list/view.dart';
import 'package:flutter_playground/page/language/view.dart';
import 'package:flutter_playground/page/platform/view.dart';
import 'package:flutter_playground/page/remote_image/view.dart';
import 'package:flutter_playground/page/system_info/view.dart';
import 'package:flutter_playground/widget/platform/app_bar.dart';
import 'package:flutter_playground/widget/platform/list_item.dart';
import 'package:flutter_playground/widget/platform/scaffold.dart';

import '../blur/view.dart';
import '../keep_state/view.dart';
import '../text_styles/view.dart';
import 'model.dart';

class FeatureView extends StatefulWidget {
  const FeatureView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FeatureView();
}

class _FeatureView extends State<FeatureView> {

  @override
  Widget build(BuildContext context) {
    final FeatureModel model = FeatureModel();

    return PlatformScaffold(
      isiOSLargeStyle: true,
      platformAppBar: PlatformAppBar(
          context: context,
          title: "Feature",
          iosPreviousTitle: "Setting",
          hasBackAction: true
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemBuilder: (context, index) => createPageListView(context, model, index),
          itemCount: model.pages.length
      )
    );
  }

  /// get list item widget to display
  /// @return [Widget] of list item
  Widget createPageListView(BuildContext context, FeatureModel model, int index) {

    /// find a [Widget] page is match given [PageType]
    /// @return [Widget] maybe NULL if not matching
    Widget? findPageByType(PageType type) {
      switch (type) {
        case PageType.textStyles:
          return const TextStylesView();

        case PageType.systemInfo:
          return const SystemInfoView();

        case PageType.dynamicList:
          return const DynamicListView();

        case PageType.remoteImage:
          return const RemoteImageView();

        case PageType.multiLanguage:
          return LanguageView();

        case PageType.platformSpecific:
          return const PlatformCodeView();

        case PageType.accessibility:
          return const AccessibilityView();

        case PageType.keepState:
          return const KeepStateView();

        case PageType.blur:
          return const BlurDemoView();

        case PageType.accountList:
          return const AccountListView();

        default:
          return null;
      }
    }

    final PageModel pageModel = model.pages[index];
    final Widget? page = findPageByType(pageModel.pageType);

    // if cant find matching page, will not pass click event to list item
    final Function() onClick = page == null ? (){} : () =>
    {
      Navigator.push(context, MaterialPageRoute(builder: (context) => page))
    };

    return PlatformListItem(title: pageModel.title, onPressed: onClick);
  }
}
