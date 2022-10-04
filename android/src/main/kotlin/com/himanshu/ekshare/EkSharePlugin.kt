package com.himanshu.ekshare

import android.app.Activity
import android.content.*
import android.content.pm.PackageManager
import android.util.Log
import androidx.annotation.NonNull
import androidx.core.content.FileProvider
import com.facebook.CallbackManager
import com.facebook.FacebookCallback
import com.facebook.FacebookException
import com.facebook.share.Sharer
import com.facebook.share.model.ShareLinkContent
import com.facebook.share.model.SharePhoto
import com.facebook.share.model.SharePhotoContent
import com.facebook.share.widget.ShareDialog
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.File

/** EksharePlugin */
class EkSharePlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private val callbackManager: CallbackManager = CallbackManager.Factory.create()
  private var activity: Activity? = null
  private var activeContext: Context? = null
  private var context: Context? = null

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "ekshare")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    activeContext = if (activity != null) activity!!.applicationContext else context!!
//    if (call.method == "getPlatformVersion") {
//      result.success("Android ${android.os.Build.VERSION.RELEASE}")
//    } else {
//      result.notImplemented()
//    }
    if (call.method == "copyToClipboard") {
   
      val content: String? = call.argument("content")
    
      val clipboard = context!!.getSystemService(Context.CLIPBOARD_SERVICE) as ClipboardManager
      val clip = ClipData.newPlainText("", content)
      clipboard.setPrimaryClip(clip)
      result.success(true)
    } else if (call.method == "shareOptions") {

      val content: String? = call.argument("content")
      val image: String? = call.argument("image")
    

      val intent = Intent()
      intent.action = Intent.ACTION_SEND

      if( image != null ) {
        val imagefile = File(activeContext!!.cacheDir, image)
        val imageFileUri = FileProvider.getUriForFile(activeContext!!, activeContext!!.applicationContext.packageName + ".com.himanshu.ekshare", imagefile)
        intent.type = "image/*"
        intent.putExtra(Intent.EXTRA_STREAM, imageFileUri)
      } else {
        intent.type = "text/plain"
       
      }
      intent.putExtra(Intent.EXTRA_TEXT, content)
      val chooserIntent: Intent = Intent.createChooser(intent,null)
      chooserIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
      activeContext!!.startActivity(chooserIntent)
      result.success(true)
    } else if (call.method == "shareWhatsapp") {

      val content: String? = call.argument("content")
      val image: String? = call.argument("image")
      val whatsappIntent = Intent(Intent.ACTION_SEND)
      whatsappIntent.setPackage("com.whatsapp");
      if (image != null) {
        val imagefile =  File(activeContext!!.cacheDir,image)
        val imageFileUri = FileProvider.getUriForFile(activeContext!!, activeContext!!.applicationContext.packageName + ".com.himanshu.ekshare", imagefile)
        whatsappIntent.type = "image/*"
        whatsappIntent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
        whatsappIntent.putExtra(Intent.EXTRA_STREAM, imageFileUri)
        }else{
          whatsappIntent.type = "text/plain";
        }
       whatsappIntent.putExtra(Intent.EXTRA_TEXT, content)
      try {
        whatsappIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        activity!!.startActivity(whatsappIntent)
        result.success("true")

      } catch (ex: ActivityNotFoundException){
         result.success("false")
      }
    } else if(call.method == "shareTwitter") {
      val text: String? = call.argument("captionText")
      val image: String? = call.argument("image")
       
      val url: String? = call.argument("url")
      val trailingText: String? = call.argument("trailingText")
      val twitterIntent = Intent(Intent.ACTION_SEND)
      twitterIntent.setPackage("com.twitter.android")
      if (image!=null) {
        val imagefile =  File(activeContext!!.cacheDir,image)
        val imageFileUri = FileProvider.getUriForFile(activeContext!!, activeContext!!.applicationContext.packageName + ".com.himanshu.ekshare", imagefile)

        twitterIntent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
        twitterIntent.type = "image/*"
        twitterIntent.putExtra(Intent.EXTRA_STREAM,imageFileUri)
      } else {
        twitterIntent.type = "text/plain";
      }
      twitterIntent.putExtra(Intent.EXTRA_TEXT, text)
      twitterIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)

      try{
        activity!!.startActivity(twitterIntent)
        result.success("true")
      }catch (ex: ActivityNotFoundException) {
        result.success("false")

      }
    } else if(call.method == "shareToFacebookFeed"){
      val content: String? = call.argument("content")
      val image: String? = call.argument("image")
     val facebookIntent = Intent(Intent.ACTION_SEND)
       facebookIntent.setPackage("com.facebook.katana")



     if (image!=null) {
       val imagefile =  File(activeContext!!.cacheDir,image)
       val imageFileUri = FileProvider.getUriForFile(activeContext!!, activeContext!!.applicationContext.packageName + ".com.himanshu.ekshare", imagefile)

       facebookIntent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
       facebookIntent.type = "image/*"
       facebookIntent.putExtra(Intent.EXTRA_STREAM,imageFileUri)
     } else {
       facebookIntent.type = "text/plain";
     }
     facebookIntent.putExtra(Intent.EXTRA_TEXT, content)
     facebookIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)


     try{
       activity!!.startActivity(facebookIntent)
       result.success("true")
     }catch (ex: ActivityNotFoundException) {
       result.success("false")

     }
    } else if (call.method == "shareToInstagramFeed"){
      
      val content: String? = call.argument("content")
      val image: String? = call.argument("image")
      val instagramIntent = Intent(Intent.ACTION_SEND)
      instagramIntent.setPackage("com.instagram.android")

      if (image!=null) {
        val imagefile =  File(activeContext!!.cacheDir,image)
        val imageFileUri = FileProvider.getUriForFile(activeContext!!, activeContext!!.applicationContext.packageName + ".com.himanshu.ekshare", imagefile)
        instagramIntent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
        instagramIntent.type = "image/*"
        instagramIntent.putExtra(Intent.EXTRA_STREAM,imageFileUri)
      } else {
        instagramIntent.type = "text/plain";
      }
      instagramIntent.putExtra(Intent.EXTRA_TEXT, content)
      instagramIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)

     

      try{
        activity!!.startActivity(instagramIntent)
        result.success("true")
      }catch (ex: ActivityNotFoundException) {
        result.success("false")

      }
    }

    else if (call.method == "shareTelegram"){
      val content: String? = call.argument("content")
      val image: String? = call.argument("image")
      val telegramIntent = Intent(Intent.ACTION_SEND)
      telegramIntent.setPackage("org.telegram.messenger")

      if (image!=null) {
      telegramIntent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
        
        val imagefile =  File(activeContext!!.cacheDir,image)
        val imageFileUri = FileProvider.getUriForFile(activeContext!!, activeContext!!.applicationContext.packageName + ".com.himanshu.ekshare", imagefile)
        telegramIntent.type = "image/*"
        telegramIntent.putExtra(Intent.EXTRA_STREAM,imageFileUri)
      } else {
        telegramIntent.type = "text/plain";
      }
    
  
    
      telegramIntent.putExtra(Intent.EXTRA_TEXT, content)
      telegramIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)

      try{
        activity!!.startActivity(telegramIntent)
        result.success("true")
      } catch (ex: ActivityNotFoundException) {
        result.success("false")

      }
    } else if (call.method == "shareLinkedin"){ 
      val content: String? = call.argument("content")
      val image: String? = call.argument("image")
      val linkedinIntent = Intent(Intent.ACTION_SEND)
      linkedinIntent.setPackage("com.linkedin.android")
      if (image!=null) {
   
        val imagefile =  File(activeContext!!.cacheDir,image)
        val imageFileUri = FileProvider.getUriForFile(activeContext!!, activeContext!!.applicationContext.packageName + ".com.himanshu.ekshare", imagefile)
        linkedinIntent.type = "image/*"
        linkedinIntent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
        linkedinIntent.putExtra(Intent.EXTRA_STREAM,imageFileUri)
      } else {
        linkedinIntent.type = "text/plain";
      }
      linkedinIntent.putExtra(Intent.EXTRA_TEXT, content)
      linkedinIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)

      try{
        activity!!.startActivity(linkedinIntent)
        result.success("true")
      } catch (ex: ActivityNotFoundException) {
        result.success("false")
      }
    } else if (call.method == "shareInstagramStory") {
      //share on instagram story
      val stickerImage: String? = call.argument("stickerImage")
      val backgroundImage: String? = call.argument("backgroundImage")

      val backgroundTopColor: String? = call.argument("backgroundTopColor")
      val backgroundBottomColor: String? = call.argument("backgroundBottomColor")
      val attributionURL: String? = call.argument("attributionURL")
      val file =  File(activeContext!!.cacheDir,stickerImage)
      val stickerImageFile = FileProvider.getUriForFile(activeContext!!, activeContext!!.applicationContext.packageName + ".com.himanshu.ekshare", file)

      val shareInstagramStory = Intent("com.instagram.share.ADD_TO_STORY")
      shareInstagramStory.type = "image/*"
      shareInstagramStory.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
      shareInstagramStory.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
      shareInstagramStory.putExtra("interactive_asset_uri", stickerImageFile)
      if (backgroundImage!=null) {
          //check if background image is also provided
          val backfile =  File(activeContext!!.cacheDir,backgroundImage)
          val backgroundImageFile = FileProvider.getUriForFile(activeContext!!, activeContext!!.applicationContext.packageName + ".com.himanshu.ekshare", backfile)
          shareInstagramStory.setDataAndType(backgroundImageFile,"image/*")
      }
      shareInstagramStory.putExtra("content_url", attributionURL)
      shareInstagramStory.putExtra("top_background_color", backgroundTopColor)
      shareInstagramStory.putExtra("bottom_background_color", backgroundBottomColor)
      // Instantiate activity and verify it will resolve implicit intent
      activity!!.grantUriPermission("com.instagram.android", stickerImageFile, Intent.FLAG_GRANT_READ_URI_PERMISSION)
      if (activity!!.packageManager.resolveActivity(shareInstagramStory, 0) != null) {
          activeContext!!.startActivity(shareInstagramStory)
          result.success("success")
      } else {
          result.success("error")
      }
    } else if (call.method == "shareFacebookStory") {
      val stickerImage: String? = call.argument("stickerImage")
      val backgroundTopColor: String? = call.argument("backgroundTopColor")
      val backgroundBottomColor: String? = call.argument("backgroundBottomColor")
      val attributionURL : String? = call.argument("attributionUrl")
      val appId: String? = call.argument("appId")

      val file = File(activeContext!!.cacheDir, stickerImage)
      val stickerImageFile = FileProvider.getUriForFile(activeContext!!, activeContext!!.applicationContext.packageName + ".com.himanshu.ekshare", file)
      val shareFacebookStoryIntent = Intent("com.facebook.stories.ADD_TO_STORY")
      shareFacebookStoryIntent.type = "image/*"

      shareFacebookStoryIntent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
      shareFacebookStoryIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
      shareFacebookStoryIntent.putExtra("com.facebook.platform.extra.APPLICATION_ID", appId)
      shareFacebookStoryIntent.putExtra("interactive_asset_uri",stickerImageFile)
      shareFacebookStoryIntent.putExtra("content_url", attributionURL)
      shareFacebookStoryIntent.putExtra("top_background_color", backgroundTopColor)
      shareFacebookStoryIntent.putExtra("bottom_background_color", backgroundBottomColor)

      if(isPackageInstalled("com.facebook.katana",activity!!.packageManager)){
        activity!!.grantUriPermission("com.facebook.katana", stickerImageFile, Intent.FLAG_GRANT_READ_URI_PERMISSION)

      }else {
        activity!!.grantUriPermission("com.facebook.lite", stickerImageFile, Intent.FLAG_GRANT_READ_URI_PERMISSION)

      }
      if(activity!!.packageManager.resolveActivity(shareFacebookStoryIntent, 0) != null){
        activeContext!!.startActivity(shareFacebookStoryIntent)

        result.success("success")
      }else {
        result.success("error")
      }
    } else if (call.method == "checkAppInstalled"){
      val packageName: String? = call.argument("packageName")
      val status: Boolean =  isPackageInstalled(packageName!!, activity!!.packageManager)
      result.success(status)
    } else if (call.method == "shareSnapchat") {
      val content: String? = call.argument("content")
      val image: String? = call.argument("image")

      val snapchatIntent = Intent(Intent.ACTION_SEND)
      snapchatIntent.component = ComponentName("com.snapchat.android", "com.snapchat.android.LandingPageActivity")

      if (image!=null) {
        snapchatIntent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);

        val imagefile =  File(activeContext!!.cacheDir,image)
        val imageFileUri = FileProvider.getUriForFile(activeContext!!, activeContext!!.applicationContext.packageName + ".com.himanshu.ekshare", imagefile)
        snapchatIntent.type = "image/*"
        snapchatIntent.putExtra(Intent.EXTRA_STREAM,imageFileUri)
      } else {
        snapchatIntent.type = "text/plain";
      }

      snapchatIntent.putExtra(Intent.EXTRA_TEXT, content)
      snapchatIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)

      try{
        activity!!.startActivity(snapchatIntent)
        result.success("true")
      } catch (ex: ActivityNotFoundException) {
        result.success("false")
      }

    }
     else  {
       result.notImplemented()
     }
  }

  private fun isPackageInstalled(packageName: String, packageManager: PackageManager): Boolean {
    return try {
      packageManager.getPackageInfo(packageName, 0)
      true
    } catch (e: PackageManager.NameNotFoundException) {
       false
    }
  }


  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivity() {
    activity = null
  }


}
