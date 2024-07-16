import 'package:bookingengine_frontend/manager/configurationmanagement.dart';
import 'package:bookingengine_frontend/util/designmanagement.dart';
import 'package:bookingengine_frontend/util/messageulti.dart';
import 'package:bookingengine_frontend/util/neutrontextcontent.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  ConfigurationManagement configurationManagement = ConfigurationManagement();
  @override
  void initState() {
    configurationManagement.asyncData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManagement.mainBackground,
      body: Center(
        child: FutureBuilder(
          future: loadingManagers(),
          builder: (context, snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(
                  color: ColorManagement.greenColor,
                ),
                const SizedBox(height: 20),
                NeutronTextContent(
                  message: MessageUtil.getMessageByCode(
                      MessageCodeUtil.TEXTALERT_LOADING_CONFIGS),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> loadingManagers() async {
    await Future.delayed(const Duration(seconds: 3));
    if (context.mounted) {
      print(59);
      Navigator.pushReplacementNamed(context, 'main');
    }
  }
}
