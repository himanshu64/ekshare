import 'ekshare_platform_interface.dart';

class Ekshare {
  Future<bool?> copyToClipboard(content) {
    return EksharePlatform.instance.copyToClipboard(content);
  }

  Future<bool?> shareOptions(String content,
      {String? title, String? image, String? linkUrl}) async {
    return EksharePlatform.instance
        .shareOptions(content, image: image, title: title, linkUrl: linkUrl);
  }

  Future<String?> shareTelegram(String content,
      {String? image, String? imageName}) async {
    return EksharePlatform.instance
        .shareTelegram(content, image: image, imageName: imageName);
  }

  Future<String?> shareWhatsapp(String content,
      {String? image, String? imageName}) async {
    return EksharePlatform.instance
        .shareWhatsapp(content, image: image, imageName: imageName);
  }

  Future<String?> shareTwitter(String captionText,
      {List<String>? hashtags,
      String? url,
      String? trailingText,
      String? imageName,
      String? image}) async {
    return EksharePlatform.instance.shareTwitter(captionText,
        hashtags: hashtags,
        trailingText: trailingText,
        url: url,
        image: image,
        imageName: imageName);
  }

  Future<String?> shareLinkedin(String content,
      {String? image, String? imageName}) async {
    return EksharePlatform.instance
        .shareLinkedin(content, image: image, imageName: imageName);
  }

  Future<String?> shareFacebookStory(
    String imagePath,
    String backgroundTopColor,
    String backgroundBottomColor,
    String attributionURL, {
    String? appId,
    String? imageName,
  }) async {
    return EksharePlatform.instance.shareFacebookStory(
      imagePath,
      backgroundTopColor,
      backgroundBottomColor,
      attributionURL,
      imageName: imageName,
      appId: appId,
    );
  }

  Future<String?> shareInstagramStory(String imagePath,
      {String? backgroundTopColor,
      String? backgroundBottomColor,
      String? attributionURL,
      String? backgroundImagePath,
      String? imageName}) async {
    return EksharePlatform.instance.shareInstagramStory(imagePath,
        attributionURL: attributionURL,
        backgroundBottomColor: backgroundBottomColor,
        backgroundImagePath: backgroundImagePath,
        backgroundTopColor: backgroundTopColor,
        imageName: imageName);
  }

  Future<String?> shareInstagramFeed(
    String content, {
    String? image,
    String? imageName,
  }) async {
    return EksharePlatform.instance
        .shareInstagramFeed(content, image: image, imageName: imageName);
  }

  Future<String?> shareFacebookFeed(String content,
      {String? image, String? imageName}) async {
    return EksharePlatform.instance
        .shareFacebookFeed(content, image: image, imageName: imageName);
  }

  Future<bool> checkAppIsInstalled(String packageName) async {
    return EksharePlatform.instance.checkAppIsInstalled(packageName);
  }

  Future<String?> shareSnapchat(String content,
      {String? image, String? imageName}) async {
    return EksharePlatform.instance
        .shareSnapchat(content, image: image, imageName: imageName);
  }
}
