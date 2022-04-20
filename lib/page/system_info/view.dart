import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_playground/widget/platform/scaffold.dart';
import 'package:flutter_playground/widget/platform/styles.dart';

import '../../widget/platform/app_bar.dart';

class SystemInfoView extends StatelessWidget {
  const SystemInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      isiOSLargeStyle: true,
      platformAppBar: PlatformAppBar(
          context: context,
          title: "System information"
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Locale name", style: PlatformTextStyles.forTitle(context),),
            Text(Platform.localeName),
            const SizedBox(height: 20,),

            Text("Path separator", style: PlatformTextStyles.forTitle(context),),
            Text(Platform.pathSeparator),
            const SizedBox(height: 20,),

            Text("Local hostname", style: PlatformTextStyles.forTitle(context),),
            Text(Platform.localHostname),
            const SizedBox(height: 20,),

            Text("Operating system", style: PlatformTextStyles.forTitle(context),),
            Text(Platform.operatingSystem),
            const SizedBox(height: 20,),

            Text("Operating system version", style: PlatformTextStyles.forTitle(context),),
            Text(Platform.operatingSystemVersion),
            const SizedBox(height: 20,),

            Text("Resolved executable", style: PlatformTextStyles.forTitle(context),),
            Text(Platform.resolvedExecutable),
            const SizedBox(height: 20,),

            Text("Executable", style: PlatformTextStyles.forTitle(context),),
            Text(getExecutableString()),
            const SizedBox(height: 20,),

            Text("System type", style: PlatformTextStyles.forTitle(context),),
            Text(currentSystemType()),
            const SizedBox(height: 20,),

            Text("Environment arguments", style: PlatformTextStyles.forTitle(context),),
            displayEnvArgus()
          ],
        ),
      ),
    );
  }

  String getExecutableString() {
    String value;
    try {
      value = Platform.executable;
    } catch (e) {
      value = "NULL";
    }

    return value;
  }

  Text displayEnvArgus() {
    final StringBuffer buffer = StringBuffer();
    for (MapEntry<String, String> entity in Platform.environment.entries) {
      buffer.write("Key:  ${entity.key}\nValue:  ${entity.value}\n\n");
    }

    if (buffer.isEmpty) {
      buffer.write("EMPTY");
    }

    return Text(buffer.toString());
  }

  String currentSystemType() {
    if (Platform.isAndroid) {
      return "Android";
    } else if (Platform.isIOS) {
      return "iOS";
    } else if (Platform.isFuchsia) {
      return "Fuchsia";
    } else if (Platform.isLinux) {
      return "Linux";
    } else if (Platform.isMacOS) {
      return "MacOS";
    } else if (Platform.isWindows) {
      return "Windows";
    } else {
      return "Unknown";
    }
  }
}