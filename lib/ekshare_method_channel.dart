import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'ekshare_platform_interface.dart';

/// An implementation of [EksharePlatform] that uses method channels.
class MethodChannelEkshare extends EksharePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ekshare');

  // @override
  // Future<String?> getPlatformVersion() async {
  //   final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
  //   return version;
  // }
  @override
  Future<bool?> copyToClipboard(content) async {
    final Map<String, dynamic> args = <String, String>{
      "content": content.toString()
    };
    final bool? response =
        await methodChannel.invokeMethod("copyToClipboard", args);
    return response;
  }

  @override
  Future<String?> shareTwitter(
    String captionText, {
    List<String>? hashtags,
    String? url,
    String? trailingText,
    String? image,
    String? imageName,
  }) async {
    Map<String, dynamic> args;
    String modifiedurl;
    if (Platform.isAndroid) {
      modifiedurl = Uri.parse(url ?? '').toString().replaceAll("#", "%23");
    } else {
      modifiedurl = Uri.parse(url ?? '').toString();
    }
    if (hashtags != null && hashtags.isNotEmpty) {
      String tags = "";
      hashtags.forEach((tag) {
        tags += ("%23$tag ").toString();
      });
      args = {
        "captionText": "$captionText\n$tags",
        "url": modifiedurl,
        "trailingText": trailingText ?? ''
      };
    } else {
      args = {
        "captionText": "$captionText ",
        "url": modifiedurl,
        "trailingText": trailingText ?? ''
      };
    }

    if (image != null) {
      String stickerAssetName = imageName ?? 'stickerAsset.png';
      File file = File(image);
      Uint8List bytes = file.readAsBytesSync();
      var stickerData = bytes.buffer.asUint8List();

      final Uint8List stickerAssetAsList = stickerData;
      final tempDir = await getTemporaryDirectory();

      final stickerAssetPath = '${tempDir.path}/$stickerAssetName';
      file = await File(stickerAssetPath).create(recursive: true);
      file.writeAsBytesSync(stickerAssetAsList);

      args.addAll({"image": stickerAssetName});
    }

    final String? version =
        await methodChannel.invokeMethod('shareTwitter', args);
    return version;
  }

  @override
  Future<String?> shareWhatsapp(
    String content, {
    String? image,
    String? imageName,
  }) async {
    Map<String, dynamic> args = <String, dynamic>{};
    String stickerAssetName = imageName ?? 'stickerAsset.png';
    if (image != null) {
      File file = File(image);
      Uint8List bytes = file.readAsBytesSync();
      var stickerData = bytes.buffer.asUint8List();
      final Uint8List stickerAssetAsList = stickerData;
      final tempDir = await getTemporaryDirectory();

      final stickerAssetPath = '${tempDir.path}/$stickerAssetName';
      file = await File(stickerAssetPath).create(recursive: true);
      file.writeAsBytesSync(stickerAssetAsList);
      args = <String, dynamic>{"content": content, "image": stickerAssetName};
    } else {
      args = <String, dynamic>{"content": content};
    }
    final String? version =
        await methodChannel.invokeMethod("shareWhatsapp", args);
    return version;
  }

  @override
  Future<String?> shareTelegram(String content,
      {String? image, String? imageName}) async {
    Map<String, dynamic> args = <String, dynamic>{};
    String stickerAssetName = 'stickerAsset.png';
    if (image != null) {
      File file = File(image);
      Uint8List bytes = file.readAsBytesSync();
      var stickerData = bytes.buffer.asUint8List();
      String stickerAssetName = imageName ?? 'stickerAsset.png';
      final Uint8List stickerAssetAsList = stickerData;
      final tempDir = await getTemporaryDirectory();

      final stickerAssetPath = '${tempDir.path}/$stickerAssetName';
      file = await File(stickerAssetPath).create(recursive: true);
      file.writeAsBytesSync(stickerAssetAsList);
      args = <String, dynamic>{"content": content, "image": stickerAssetName};
    } else {
      args = <String, dynamic>{"content": content};
    }
    final String? version =
        await methodChannel.invokeMethod("shareTelegram", args);
    return version;
  }

  @override
  Future<String?> shareSnapchat(String content,
      {String? image, String? imageName}) async {
    Map<String, dynamic> args = <String, dynamic>{};
    String stickerAssetName = 'stickerAsset.png';
    if (image != null) {
      File file = File(image);
      Uint8List bytes = file.readAsBytesSync();
      var stickerData = bytes.buffer.asUint8List();
      String stickerAssetName = imageName ?? 'stickerAsset.png';
      final Uint8List stickerAssetAsList = stickerData;
      final tempDir = await getTemporaryDirectory();

      final stickerAssetPath = '${tempDir.path}/$stickerAssetName';
      file = await File(stickerAssetPath).create();
      file.writeAsBytesSync(stickerAssetAsList);

      args.addAll({"image": stickerAssetName});
    }
    args.addAll({"content": content});

    final String? version =
        await methodChannel.invokeMethod("shareSnapchat", args);
    return version;
  }

  @override
  Future<bool?> shareOptions(String content,
      {String? title, String? image, String? imageName}) async {
    Map<String, dynamic> args;
    if (Platform.isIOS) {
      args = <String, dynamic>{"image": image, "content": content};
    } else {
      if (image != null) {
        File file = File(image);
        Uint8List bytes = file.readAsBytesSync();
        var imagedata = bytes.buffer.asUint8List();
        final tempDir = await getTemporaryDirectory();
        String imageAssetName = imageName ?? 'stickerAsset.png';
        final Uint8List imageAsList = imagedata;
        final imageDataPath = '${tempDir.path}/$imageAssetName';
        file = await File(imageDataPath).create();
        file.writeAsBytesSync(imageAsList);
        args = <String, dynamic>{"image": imageName, "content": content};
      } else {
        args = <String, dynamic>{"content": content};
      }
    }
    final bool? version =
        await methodChannel.invokeMethod('shareOptions', args);
    return version;
  }

  @override
  Future<String?> shareLinkedin(
    String content, {
    String? image,
    String? imageName,
  }) async {
    // Map<String, dynamic> args;
    // if (Platform.isIOS) {
    //   args = <String, dynamic>{"image": image, "content": content};
    // } else {
    //   if (image != null) {
    //     args = <String, dynamic>{"image": image, "content": content};
    //   } else {
    //     args = <String, dynamic>{"content": content};
    //   }
    // }
    Map<String, dynamic> args = <String, dynamic>{};
    String stickerAssetName = imageName ?? 'stickerAsset.png';
    if (image != null) {
      File file = File(image);
      Uint8List bytes = file.readAsBytesSync();
      var stickerData = bytes.buffer.asUint8List();
      final Uint8List stickerAssetAsList = stickerData;
      final tempDir = await getTemporaryDirectory();

      final stickerAssetPath = '${tempDir.path}/$stickerAssetName';
      file = await File(stickerAssetPath).create();
      file.writeAsBytesSync(stickerAssetAsList);
      args = <String, dynamic>{"image": stickerAssetName, "content": content};
    } else {
      args = <String, dynamic>{"content": content};
    }
    final String? version =
        await methodChannel.invokeMethod('shareLinkedin', args);
    return version;
  }

  @override
  Future<String?> shareFacebookStory(
    String imagePath,
    String backgroundTopColor,
    String backgroundBottomColor,
    String attributionURL, {
    String? appId,
    String? imageName,
  }) async {
    Map<String, dynamic> args;
    if (Platform.isIOS) {
      args = <String, dynamic>{
        "stickerImage": imagePath,
        "backgroundTopColor": backgroundTopColor,
        "backgroundBottomColor": backgroundBottomColor,
        "attributionURL": attributionURL,
      };
    } else {
      File file = File(imagePath);
      Uint8List bytes = file.readAsBytesSync();
      var stickerdata = bytes.buffer.asUint8List();
      final tempDir = await getTemporaryDirectory();
      String stickerAssetName = imageName ?? 'stickerAsset.png';
      final Uint8List stickerAssetAsList = stickerdata;
      final stickerAssetPath = '${tempDir.path}/$stickerAssetName';
      file = await File(stickerAssetPath).create();
      file.writeAsBytesSync(stickerAssetAsList);
      args = <String, dynamic>{
        "stickerImage": stickerAssetName,
        "backgroundTopColor": backgroundTopColor,
        "backgroundBottomColor": backgroundBottomColor,
        "attributionURL": attributionURL,
        "appId": appId
      };
    }
    final String? response =
        await methodChannel.invokeMethod('shareFacebookStory', args);
    return response;
  }

  @override
  Future<String?> shareInstagramStory(
    String imagePath, {
    String? backgroundTopColor,
    String? backgroundBottomColor,
    String? attributionURL,
    String? backgroundImagePath,
    String? imageName,
  }) async {
    Map<String, dynamic> args;
    if (Platform.isIOS) {
      if (backgroundImagePath == null) {
        args = <String, dynamic>{
          "stickerImage": imagePath,
          "backgroundTopColor": backgroundTopColor,
          "backgroundBottomColor": backgroundBottomColor,
          "attributionURL": attributionURL
        };
      } else {
        args = <String, dynamic>{
          "stickerImage": imagePath,
          "backgroundImage": backgroundImagePath,
          "backgroundTopColor": backgroundTopColor,
          "backgroundBottomColor": backgroundBottomColor,
          "attributionURL": attributionURL
        };
      }
    } else {
      final tempDir = await getTemporaryDirectory();

      File file = File(imagePath);
      Uint8List bytes = file.readAsBytesSync();
      var stickerData = bytes.buffer.asUint8List();
      String stickerAssetName = imageName ?? 'stickerAsset.png';
      final Uint8List stickerAssetAsList = stickerData;
      final stickerAssetPath = '${tempDir.path}/$stickerAssetName';
      file = await File(stickerAssetPath).create();
      file.writeAsBytesSync(stickerAssetAsList);

      String? backgroundAssetName;
      if (backgroundImagePath != null) {
        File backgroundImage = File(backgroundImagePath);
        Uint8List backgroundImageData = backgroundImage.readAsBytesSync();
        backgroundAssetName = 'backgroundAsset.jpg';
        final Uint8List backgroundAssetAsList = backgroundImageData;
        final backgroundAssetPath = '${tempDir.path}/$backgroundAssetName';
        File backFile = await File(backgroundAssetPath).create();
        backFile.writeAsBytesSync(backgroundAssetAsList);
      }

      args = <String, dynamic>{
        "stickerImage": stickerAssetName,
        "backgroundImage": backgroundAssetName,
        "backgroundTopColor": backgroundTopColor,
        "backgroundBottomColor": backgroundBottomColor,
        "attributionURL": attributionURL,
      };
    }
    final String? response = await methodChannel.invokeMethod(
      'shareInstagramStory',
      args,
    );
    return response;
  }

  @override
  Future<String?> shareFacebookFeed(String content,
      {String? image, String? imageName}) async {
    Map<String, dynamic> args = <String, dynamic>{};
    String stickerAssetName = imageName ?? 'stickerAsset.png';
    if (image != null) {
      File file = File(image);
      Uint8List bytes = file.readAsBytesSync();
      var stickerData = bytes.buffer.asUint8List();
      final Uint8List stickerAssetAsList = stickerData;
      final tempDir = await getTemporaryDirectory();

      final stickerAssetPath = '${tempDir.path}/$stickerAssetName';
      file = await File(stickerAssetPath).create();
      file.writeAsBytesSync(stickerAssetAsList);
      args.addAll({"image": stickerAssetName, "content": content});
    } else {
      args = <String, dynamic>{"content": content};
    }
    final String? version =
        await methodChannel.invokeMethod('shareToFacebookFeed', args);
    return version;
  }

  @override
  Future<String?> shareInstagramFeed(String content,
      {String? image, String? imageName}) async {
    Map<String, dynamic> args = <String, dynamic>{};
    String stickerAssetName = imageName ?? 'stickerAsset.png';
    if (image != null) {
      File file = File(image);
      Uint8List bytes = file.readAsBytesSync();
      var stickerData = bytes.buffer.asUint8List();
      final Uint8List stickerAssetAsList = stickerData;
      final tempDir = await getTemporaryDirectory();

      final stickerAssetPath = '${tempDir.path}/$stickerAssetName';
      file = await File(stickerAssetPath).create();
      file.writeAsBytesSync(stickerAssetAsList);
      args = <String, dynamic>{"image": stickerAssetName, "content": content};
    } else {
      args = <String, dynamic>{"content": content};
    }
    final String? version =
        await methodChannel.invokeMethod('shareToInstagramFeed', args);
    return version;
  }

  @override
  Future<bool> checkAppIsInstalled(
    String packageName,
  ) async {
    if (packageName.isEmpty) return false;
    final bool version = await methodChannel
        .invokeMethod('checkAppInstalled', {"packageName": packageName});
    return version;
  }
}
