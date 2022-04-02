import 'package:flutter/material.dart';
import 'package:flutter_playground/base/base_remote_view_model.dart';
import 'package:flutter_playground/page/remote_image/model.dart';
import 'package:flutter_playground/page/remote_image/view_model.dart';
import 'package:flutter_playground/widget/app_bar.dart';
import 'package:provider/provider.dart';

class RemoteImageView extends StatefulWidget {
  const RemoteImageView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RemoteImageView();
}

class _RemoteImageView extends State<RemoteImageView> {

  Text statusOfViewModel(RemoteImageViewModel viewModel) {
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

    return Text(text, style: Theme.of(context).textTheme.bodyMedium);
  }

  Widget imageFromViewModel(RemoteImageViewModel viewModel) {
    final RemoteImageModelData? data = viewModel.data;
    if (data == null) {
      return const SizedBox(width: 0, height: 0);
    }

    return Card(
      child: Image.memory(data.bytes),
      clipBehavior: Clip.hardEdge,
      elevation: 5.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(context, "Remote image", true),
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
                      child: ElevatedButton(
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