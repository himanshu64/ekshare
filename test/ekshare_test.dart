import 'package:flutter_test/flutter_test.dart';
import 'package:ekshare/ekshare_platform_interface.dart';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockEksharePlatform
    with MockPlatformInterfaceMixin
    implements EksharePlatform {
  @override
  Future<bool?> copyToClipboard(content) {
    // TODO: implement copyToClipboard
    throw UnimplementedError();
  }

  @override
  Future<bool> checkAppIsInstalled(String packageName) {
    // TODO: implement checkAppIsInstalled
    throw UnimplementedError();
  }

  @override
  Future<String?> shareFacebookFeed(String content,
      {String? image, String? imageName}) {
    // TODO: implement shareFacebookFeed
    throw UnimplementedError();
  }

  @override
  Future<String?> shareFacebookStory(
      String imagePath,
      String backgroundTopColor,
      String backgroundBottomColor,
      String attributionURL,
      {String? appId,
      String? imageName}) {
    // TODO: implement shareFacebookStory
    throw UnimplementedError();
  }

  @override
  Future<String?> shareInstagramFeed(String content,
      {String? image, String? imageName}) {
    // TODO: implement shareInstagramFeed
    throw UnimplementedError();
  }

  @override
  Future<String?> shareInstagramStory(String imagePath,
      {String? backgroundTopColor,
      String? backgroundBottomColor,
      String? attributionURL,
      String? backgroundImagePath,
      String? imageName}) {
    // TODO: implement shareInstagramStory
    throw UnimplementedError();
  }

  @override
  Future<String?> shareLinkedin(String content,
      {String? image, String? imageName}) {
    // TODO: implement shareLinkedin
    throw UnimplementedError();
  }

  @override
  Future<bool?> shareOptions(String content,
      {String? title, String? image, String? imageName, String? linkUrl}) {
    // TODO: implement shareOptions
    throw UnimplementedError();
  }

  @override
  Future<String?> shareSlack(String content,
      {String? image, String? imageName}) {
    // TODO: implement shareSlack
    throw UnimplementedError();
  }

  @override
  Future<String?> shareTelegram(String content,
      {String? image, String? imageName}) {
    // TODO: implement shareTelegram
    throw UnimplementedError();
  }

  @override
  Future<String?> shareTwitter(String captionText,
      {List<String>? hashtags,
      String? url,
      String? trailingText,
      String? image,
      String? imageName}) {
    // TODO: implement shareTwitter
    throw UnimplementedError();
  }

  @override
  Future<String?> shareWhatsapp(String content,
      {String? image, String? imageName}) {
    // TODO: implement shareWhatsapp
    throw UnimplementedError();
  }

  @override
  Future<String?> shareSnapchat(String content,
      {String? image, String? imageName}) {
    // TODO: implement shareSnapchat
    throw UnimplementedError();
  }
}

// void main() {
//   final EksharePlatform initialPlatform = EksharePlatform.instance;

//   test('$MethodChannelEkshare is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelEkshare>());
//   });

//   test('getPlatformVersion', () async {
//     Ekshare eksharePlugin = Ekshare();
//     MockEksharePlatform fakePlatform = MockEksharePlatform();
//     EksharePlatform.instance = fakePlatform;

//     expect(await eksharePlugin.getPlatformVersion(), '42');
//   });
// }
