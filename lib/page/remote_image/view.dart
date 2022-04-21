import 'package:flutter/material.dart';
import 'package:flutter_playground/base/base_remote_view_model.dart';
import 'package:flutter_playground/page/remote_image/model.dart';
import 'package:flutter_playground/page/remote_image/view_model.dart';
import 'package:flutter_playground/widget/platform/scaffold.dart';
import 'package:flutter_playground/widget/platform/styles.dart';
import 'package:provider/provider.dart';

import '../../widget/platform/app_bar.dart';
import '../../widget/platform/button.dart';
import '../../widget/platform/card.dart';

class RemoteImageView extends StatefulWidget {
  const RemoteImageView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RemoteImageView();
}

class _RemoteImageView extends State<RemoteImageView> {

  Widget statusOfViewModel(RemoteImageViewModel viewModel) {
    final String text;
    switch (viewModel.currentStatus()) {
      case Status.initialized:
        text = "Initialized";
        break;
      case Status.loading:
        text = "Loading image...";
        break;
      case Status.finished:
        text = "Downloaded";
        break;
      case Status.error:
        text = "Error occurred";
        break;
    }

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(text, style: PlatformTextStyles.forContent(context)),
    );
  }

  Widget imageFromViewModel(RemoteImageViewModel viewModel) {
    final RemoteImageModelData? data = viewModel.data;
    if (data == null) {
      return const SizedBox(width: 0, height: 0);
    }

    return PlatformCardView(
      child: Image.memory(data.bytes),
      padding: EdgeInsets.zero,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      isiOSLargeStyle: false,
      platformAppBar: PlatformAppBar(
          context: context,
          title: "Remote image fetching"
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ChangeNotifierProvider(
          create: (context) => RemoteImageViewModel(),
          child: Consumer<RemoteImageViewModel>(
            builder: (context, viewModel, child) {
              return Column(
                children: [
                  imageFromViewModel(viewModel),
                  statusOfViewModel(viewModel),
                  SizedBox(
                      width: double.infinity,
                      child: PlatformButton(
                          onPressed: () => viewModel.fetch(),
                          child: const Text("Download image now !!")
                      )
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }


}