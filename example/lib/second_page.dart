import 'package:ekshare/ekshare.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  SecondPage({super.key});
  final _eksharePlugin = Ekshare();
  void shareOnShareMore() async {
    try {
      bool? apps = await _eksharePlugin.shareOptions(
        "https://thisday.page.link/1zBR",
      );
      print(apps.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("second page"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                shareOnShareMore();
              },
              child: Text("Share"))
        ],
      ),
    );
  }
}
