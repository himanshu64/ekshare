import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ekshare/ekshare_method_channel.dart';

void main() {
  MethodChannelEkshare platform = MethodChannelEkshare();
  const MethodChannel channel = MethodChannel('ekshare');

  TestWidgetsFlutterBinding.ensureInitialized();

  // setUp(() {
  //   channel.setMockMethodCallHandler((MethodCall methodCall) async {
  //     return '42';
  //   });
  // });

  // tearDown(() {
  //   channel.setMockMethodCallHandler(null);
  // });

  // test('getPlatformVersion', () async {
  //   expect(await platform.getPlatformVersion(), '42');
  // });
}
