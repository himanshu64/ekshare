import 'dart:developer';
import 'dart:io';

import 'package:ekshare/ekshare.dart';
import 'package:ekshare_example/second_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _eksharePlugin = Ekshare();

  @override
  void initState() {
    super.initState();
    copyToClipBoard();

    // initPlatformState();
  }

  // // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> initPlatformState() async {
  //   String platformVersion;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   // We also handle the message potentially returning null.
  //   try {
  //     platformVersion =
  //         await _eksharePlugin.getPlatformVersion() ?? 'Unknown platform version';
  //   } on PlatformException {
  //     platformVersion = 'Failed to get platform version.';
  //   }

  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   if (!mounted) return;

  //   setState(() {
  //     _platformVersion = platformVersion;
  //   });
  // }

  void copyToClipBoard() async {
    bool? isCopy = await _eksharePlugin.copyToClipboard("abc");
    if (isCopy!) {
      print("copied");
    } else {
      print("not copied");
    }
  }

  void checkInstalledApps() async {}

  void shareOnLinkedin() async {
    try {
      String? image = await getFilePathForUrl(
          "https://upload.wikimedia.org/wikipedia/commons/4/47/PNG_transparency_demonstration_1.png",
          "sticker_image");
      String? apps =
          await _eksharePlugin.shareLinkedin("sadkjfnsdkfj", image: image);
      print(apps.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  void shareOnFacebook() async {
    try {
      String? image = await getFilePathForUrl(
          "https://upload.wikimedia.org/wikipedia/commons/4/47/PNG_transparency_demonstration_1.png",
          "sticker_image");
      String? apps = await _eksharePlugin
          .shareFacebookFeed("""*Organising our front line warriors*
This day saw the institutional organization of Anganwadi workers and helpers in a trade union when the All India Federation of Anganwadi Workers and Helpers became one voice against privatization....
Read the complete story on ThisDay app.
https://thisday.page.link/cJW8
""");
      print(apps.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  void shareOnInstagram() async {
    try {
      String? image = await getFilePathForUrl(
          "https://upload.wikimedia.org/wikipedia/commons/4/47/PNG_transparency_demonstration_1.png",
          "sticker_image");
      String? apps = await _eksharePlugin.shareInstagramFeed(
        """*Organising our front line warriors*
This day saw the institutional organization of Anganwadi workers and helpers in a trade union when the All India Federation of Anganwadi Workers and Helpers became one voice against privatization....
Read the complete story on ThisDay app.
https://thisday.page.link/cJW8
""",
      );
      print(apps.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  void shareOnInstagramStory() async {
    try {
      String image = await getFilePathForUrl(
          "https://upload.wikimedia.org/wikipedia/commons/4/47/PNG_transparency_demonstration_1.png",
          "sticker_image");
      String? apps = await _eksharePlugin.shareInstagramStory(image,
          backgroundTopColor: "#ffffff",
          backgroundBottomColor: "#000000",
          attributionURL: "https://deep-link-url",
          backgroundImagePath: image);
      print(apps.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  void shareOnfacebookStory() async {
    try {
      String image = await getFilePathForUrl(
          "https://upload.wikimedia.org/wikipedia/commons/4/47/PNG_transparency_demonstration_1.png",
          "sticker_image");
      Platform.isAndroid
          ? _eksharePlugin
              .shareFacebookStory(
                  image, "#ffffff", "#000000", "https://google.com",
                  appId: "706130580402980", imageName: 'sticker_image.png')
              .then((data) {
              print(data);
            })
          : _eksharePlugin
              .shareFacebookStory(
                  image, "#ffffff", "#000000", "https://google.com",
                  imageName: 'sticker_image.png')
              .then((data) {
              print(data);
            });
    } catch (e) {
      print(e.toString());
    }
  }

  void shareOnWhatsapp() async {
    try {
      String image = await getFilePathForUrl(
          "https://img.freepik.com/free-vector/hand-painted-watercolor-pastel-sky-background_23-2148902771.jpg?w=2000",
          "sticker_image");
      String? apps =
          await _eksharePlugin.shareWhatsapp("sadkjfnsdkfj", image: image);
      print(apps.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  void shareOnTwitter() async {
    String image = await getFilePathForUrl(
        "https://img.freepik.com/free-vector/hand-painted-watercolor-pastel-sky-background_23-2148902771.jpg?w=2000",
        "sticker_image");
    try {
      String? apps =
          await _eksharePlugin.shareTwitter("sadkjfnsdkfj", image: image);
      print(apps.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  void shareOnTelegram() async {
    try {
      String image = await getFilePathForUrl(
          "https://img.freepik.com/free-vector/hand-painted-watercolor-pastel-sky-background_23-2148902771.jpg?w=2000",
          "sticker_image");
      String? apps = await _eksharePlugin.shareTelegram("sadkjfnsdkfj");
      print(apps.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  void shareonSnapchat() async {
    try {
      String image = await getFilePathForUrl(
          "https://img.freepik.com/free-vector/hand-painted-watercolor-pastel-sky-background_23-2148902771.jpg?w=2000",
          "sticker_image");
      String? apps = await _eksharePlugin.shareTelegram("sadkjfnsdkfj");
      print(apps.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  void shareOnShareMore() async {
    try {
      String? image = await getFilePathForUrl(
          "https://upload.wikimedia.org/wikipedia/commons/4/47/PNG_transparency_demonstration_1.png",
          "sticker_image");
      bool? apps = await _eksharePlugin.shareOptions(
        "https://thisday.page.link/1zBR",
      );
      print(apps.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> getFilePathForUrl(String imageUrl, String? fileName) async {
    var cache = DefaultCacheManager();
    final file = await cache.getSingleFile(
      imageUrl,
      key: imageUrl,
    );
    final renamedFile =
        fileName != null ? file.renameSync('${file.dirname}/$fileName') : file;
    log('${renamedFile.path} \n ${renamedFile.toString()}');
    return renamedFile.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TextButton(
                  onPressed: () {
                    shareOnLinkedin();
                  },
                  child: const Text("Share on Linkedin")),
              TextButton(
                  onPressed: () {
                    shareOnInstagramStory();
                  },
                  child: const Text("Share on instagram story")),
              TextButton(
                  onPressed: () {
                    shareOnfacebookStory();
                  },
                  child: const Text("Share on facebook story")),
              TextButton(
                  onPressed: () {
                    shareOnInstagram();
                  },
                  child: const Text("Share on instagram ")),
              TextButton(
                  onPressed: () {
                    shareOnFacebook();
                  },
                  child: const Text("Share on facebook ")),
              TextButton(
                  onPressed: () {
                    shareOnTwitter();
                  },
                  child: const Text("Share on Twitter")),
              const TextButton(
                  onPressed: null, child: Text("Share on Instagram")),
              TextButton(
                  onPressed: () {
                    shareOnWhatsapp();
                  },
                  child: const Text("Share on whatsapp")),
              TextButton(
                  onPressed: () {
                    shareOnTelegram();
                  },
                  child: const Text("Share on Telegram")),
              const TextButton(onPressed: null, child: Text("Share on Slack")),
              TextButton(
                onPressed: () {
                  shareOnShareMore();
                },
                child: const Text("Share  More"),
              ),
              TextButton(
                onPressed: () {
                  shareonSnapchat();
                },
                child: const Text("Share  on Snapchat"),
              ),
              TextButton(
                  onPressed: () {
                    Ekshare()
                        .checkAppIsInstalled("com.snapchat.android")
                        .then((value) {
                      print("value $value");
                    });
                  },
                  child: const Text("check app")),
              CupertinoButton(
                  onPressed: () async {
                    log("push");

                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (_) => SecondPage()));

                    await Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SecondPage()));
                  },
                  child: const Text("Next page"))
            ],
          ),
        ));
  }
}
