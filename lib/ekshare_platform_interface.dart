import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ekshare_method_channel.dart';

abstract class EksharePlatform extends PlatformInterface {
  /// Constructs a EksharePlatform.
  EksharePlatform() : super(token: _token);

  static final Object _token = Object();

  static EksharePlatform _instance = MethodChannelEkshare();

  /// The default instance of [EksharePlatform] to use.
  ///
  /// Defaults to [MethodChannelEkshare].
  static EksharePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [EksharePlatform] when
  /// they register themselves.
  static set instance(EksharePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool?> copyToClipboard(content) {
    throw UnimplementedError('copyToClipboard() has not been implemented.');
  }

  Future<String?> shareTwitter(String captionText,
      {List<String>? hashtags,
      String? url,
      String? trailingText,
      String? image,
      String? imageName}) async {
    throw UnimplementedError('shareTwitter() has not been implemented.');
  }

  Future<String?> shareWhatsapp(String content,
      {String? image, String? imageName}) async {
    throw UnimplementedError('shareWhatsapp() has not been implemented.');
  }

  Future<String?> shareFacebookFeed(String content,
      {String? image, String? imageName}) async {
    throw UnimplementedError('shareFacebookFeed() has not been implemented.');
  }

  Future<String?> shareInstagramFeed(String content,
      {String? image, String? imageName}) async {
    throw UnimplementedError('shareInstagramFeed() has not been implemented.');
  }

  Future<String?> shareTelegram(String content,
      {String? image, String? imageName}) async {
    throw UnimplementedError('shareTelegram() has not been implemented.');
  }

  Future<String?> shareSnapchat(String content,
      {String? image, String? imageName}) async {
    throw UnimplementedError('shareTelegram() has not been implemented.');
  }

  Future<String?> shareSlack(String content,
      {String? image, String? imageName}) async {
    throw UnimplementedError('shareSlack() has not been implemented.');
  }

  Future<String?> shareLinkedin(String content,
      {String? image, String? imageName}) async {
    throw UnimplementedError('shareLinkedin() has not been implemented.');
  }

  Future<String?> shareFacebookStory(
    String imagePath,
    String backgroundTopColor,
    String backgroundBottomColor,
    String attributionURL, {
    String? appId,
    String? imageName,
  }) async {
    throw UnimplementedError('shareFacebookStory() has not been implemented.');
  }

  Future<String?> shareInstagramStory(String imagePath,
      {String? backgroundTopColor,
      String? backgroundBottomColor,
      String? attributionURL,
      String? backgroundImagePath,
      String? imageName}) async {
    throw UnimplementedError('shareInstagramStory() has not been implemented.');
  }

  Future<bool?> shareOptions(String content,
      {String? title, String? image, String? imageName}) async {
    throw UnimplementedError('shareOptions() has not been implemented.');
  }

  Future<bool> checkAppIsInstalled(
    String packageName,
  ) async {
    throw UnimplementedError('checkAppIsInstalled() has not been implemented.');
  }
}
