import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:vanfly/screens/signup_screen/signup.dart';

Uri dynamicUrl;

class DynamicLinksApi {
  String thisCode;
  final dynamicLink = FirebaseDynamicLinks.instance;

  handleDynamicLink() async {
    await dynamicLink.getInitialLink();
    dynamicLink.onLink(onSuccess: (PendingDynamicLinkData data) async {
      handleSuccessLinking(data);
    }, onError: (OnLinkErrorException error) async {
      print(error.message.toString());
    });
  }

  Future<String> createReferralLink(String referralCode) async {
    final DynamicLinkParameters dynamicLinkParameters = DynamicLinkParameters(
        uriPrefix: 'https://vanfly.page.link',
        link: Uri.parse('https://www.vanfly.com/refer?code=$referralCode'),
        androidParameters: AndroidParameters(
          packageName: 'co.vanfly.vanfly',
        ),
        iosParameters: IosParameters(
          bundleId: 'co.vanfly.vanfly',
        ),
        socialMetaTagParameters: SocialMetaTagParameters(
            title: 'Refer A Friend',
            description: 'Refer and earn',
            imageUrl: Uri.parse(
                'https://clipartart.com/images/cash-referral-clipart-6.png')));
    final ShortDynamicLink shortLink =
        await dynamicLinkParameters.buildShortLink();
    dynamicUrl = shortLink.shortUrl;
    return dynamicUrl.toString();
  }

  void handleSuccessLinking(PendingDynamicLinkData data) {
    final Uri deepLink = data?.link;
    if (deepLink != null) {
      var isRefer = deepLink.pathSegments.contains('refer');
      if (isRefer) {
        var code = deepLink.queryParameters['code'];
        if (code != null) {
          thisCode = code;
          MaterialPageRoute(builder: (_) {
            return SignUp();
          });
        }
      }
    }
  }
}
