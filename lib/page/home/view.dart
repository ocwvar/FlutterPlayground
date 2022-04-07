import 'package:flutter/material.dart';
import 'package:flutter_playground/base/theme_view_model.dart';
import 'package:flutter_playground/page/accessibility/view.dart';
import 'package:flutter_playground/page/dynamic_list/view.dart';
import 'package:flutter_playground/page/language/view.dart';
import 'package:flutter_playground/page/platform/view.dart';
import 'package:flutter_playground/page/remote_image/view.dart';
import 'package:flutter_playground/page/system_info/view.dart';
import 'package:flutter_playground/widget/list_item.dart';

import '../keep_state/view.dart';
import '../text_styles/view.dart';
import 'model.dart';

class HomeView extends StatefulWidget {

  final ThemeViewModel _viewModel;

  const HomeView(this._viewModel, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeView();
}

class _HomeView extends State<HomeView> {

  @override
  Widget build(BuildContext context) {
    final HomeModel model = HomeModel();

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// day-night panel
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 8),
            child: Text("DayNight control", style: Theme.of(context).textTheme.titleLarge)
          ),
          createDayNightButtonPanel(context),

          /// theme color panel
          Padding(
              padding: const EdgeInsets.only(left: 8, top: 8),
              child: Text("Theme color control", style: Theme.of(context).textTheme.titleLarge)
          ),
          createThemeColorPanel(context),

          /// functions list
          Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 8),
              child: Text("Functions list", style: Theme.of(context).textTheme.titleLarge)
          ),
          Expanded(
              child: ListView.builder(
                  itemBuilder: (context, index) => createPageListView(context, model, index),
                  itemCount: model.pages.length
              )
          )
        ]
    );
  }

  /// on user clicked day-night control buttons
  /// @param [DayNightType]
  void onClickDayNightButton(DayNightType type) {
    widget._viewModel.changeType(type);
  }

  /// Theme color control buttons panel
  /// @return [Widget]
  Widget createThemeColorPanel(BuildContext context) {
    Widget wrapCard(Color targetColor) {
      return ElevatedButton(
          onPressed: () => widget._viewModel.changeThemeColor(targetColor, true),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(targetColor),
              fixedSize: MaterialStateProperty.all(const Size(50.0, 50.0))
          ),
          child: const SizedBox(width: 50, height: 50)
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          wrapCard(Colors.pink),
          const Spacer(),
          wrapCard(Colors.deepOrange),
          const Spacer(),
          wrapCard(Colors.green),
          const Spacer(),
          wrapCard(Colors.blueAccent),
          const Spacer(),
          wrapCard(Colors.purple),
          const Spacer(),
        ],
      ),
    );
  }

  /// Day-Night control buttons panel
  /// @return [Widget]
  Widget createDayNightButtonPanel(BuildContext context) {

    /// get function that will be toggle when button click
    /// @param [DayNightType]
    /// @return [Function?] null if given [DayNightType] is currently using
    Function()? getClickFunction(DayNightType targetType) {
      if (widget._viewModel.currentType() == targetType) {
        return null;
      }

      return () { onClickDayNightButton(targetType); };
    }

    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: Row(
        children: [
          const Spacer(),
          ElevatedButton(
              onPressed: getClickFunction(DayNightType.light) ,
              child: const Text("Light")),
          const Spacer(),
          ElevatedButton(
              onPressed: getClickFunction(DayNightType.night) ,
              child: const Text("Night")),
          const Spacer(),
          ElevatedButton(
              onPressed: getClickFunction(DayNightType.followSystem) ,
              child: const Text("Auto")),
          const Spacer(),
        ],
      ),
    );
  }

  /// get list item widget to display
  /// @return [Widget] of list item
  Widget createPageListView(BuildContext context, HomeModel model, int index) {

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

        default:
          return null;
      }
    }

    final PageModel pageModel = model.pages[index];
    final Widget? page = findPageByType(pageModel.pageType);

    // if cant find matching page, will not pass click event to list item
    final Function()? onClick = page == null ? null : () =>
    {
      Navigator.push(context, MaterialPageRoute(builder: (context) => page))
    };

    return createListItem(context, pageModel.title, true, onClick);
  }
}
