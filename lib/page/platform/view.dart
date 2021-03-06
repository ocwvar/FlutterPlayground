import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_playground/base/cross_platform.dart';
import 'package:flutter_playground/widget/platform/styles.dart';

import '../../widget/platform/app_bar.dart';
import '../../widget/platform/scaffold.dart';

class PlatformCodeView extends StatefulWidget {
  const PlatformCodeView({Key? key}) : super(key: key);

  @override
  State createState() => _PlatformCodeView();
}

class _PlatformCodeView extends State<PlatformCodeView> {

  final MethodChannel platform = const MethodChannel(CrossPlatform.channel);
  String _systemVersionString = "";

  /// get current system version from current platform
  void getSystemVersion() {

    Future<String> _get() async {
      final String value = await platform.invokeMethod(CrossPlatform.methodSystemVersion);
      return value;
    }

    _get().then((value) {
      setState(() {
        _systemVersionString = value;
      });
    }).onError((error, stackTrace) {
      setState(() {
        _systemVersionString = "ERROR: $stackTrace";
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    if (_systemVersionString.isEmpty) {
      getSystemVersion();
    }
    return PlatformScaffold(
      isiOSLargeStyle: true,
      platformAppBar: PlatformAppBar(
          context: context,
          title: "Platform specific code"
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("System version", style: PlatformTextStyles.forTitle(context), textAlign: TextAlign.left,),
            const SizedBox(height: 20,),
            Text(_systemVersionString)
          ],
        ),
      ),
    );
  }
}