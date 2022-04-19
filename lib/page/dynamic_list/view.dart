import 'package:flutter/material.dart';
import 'package:flutter_playground/page/dynamic_list/repository.dart';
import 'package:flutter_playground/page/dynamic_list/view_model.dart';
import 'package:flutter_playground/widget/list_item.dart';
import 'package:provider/provider.dart';

import '../../widget/platform/app_bar.dart';
import '../../widget/platform/scaffold.dart';

class DynamicListView extends StatefulWidget {
  const DynamicListView({Key? key}) : super(key: key);

  @override
  State createState() => _DynamicListView();
}

class _DynamicListView extends State<DynamicListView> {

  /// Scroll controller for content list
  /// use this to achieve scroll down to bottom
  /// when added a new item into content list
  final ScrollController _scrollController = ScrollController();

  /// scroll content list down to bottom
  void _scrollDown2Bottom() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        isiOSLargeStyle: true,
        platformAppBar: PlatformAppBar(
            context: context,
            title: "Dynamic list content"
        ),
        body: ChangeNotifierProvider(
          create: (context) => DynamicListViewModel(),
          child: Consumer<DynamicListViewModel>(
            builder: (context, viewModel, child) {
              return Column(children: [
                // child 1 -> button panel
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 12),
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            _scrollDown2Bottom();
                            _addItem(viewModel);
                          },
                          child: const Text("Add item"),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            _removeItem(viewModel);
                          },
                          child: const Text("Remove last item"),
                        ),
                        const Spacer()
                      ],
                    ),
                  ),
                ),

                // child 2 -> content list
                Flexible(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      final SimpleItemModel model = viewModel.index(index);
                      return createListItem(context, model.text1, true, () => _onItemClick(model));
                    },
                    itemCount: viewModel.count(),
                  ),
                )

              ]);
            },
          ),
        ));
  }

  /// create a new item and add into list
  void _addItem(DynamicListViewModel viewModel) {
    viewModel.add();
  }

  /// remove last item in list
  void _removeItem(DynamicListViewModel viewModel) {
    viewModel.remove();
  }

  /// on list item clicked
  /// @param model which has been click
  void _onItemClick(SimpleItemModel model) {

  }
}