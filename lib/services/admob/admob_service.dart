import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService extends GetxService {
  static AdMobService get to => Get.find();

  // TEST IDs
  final String bannerAdUnitId = "ca-app-pub-3940256099942544/6300978111";

  final String interstitialAdUnitId = "ca-app-pub-3940256099942544/1033173712";

  BannerAd? bannerAd;
  InterstitialAd? interstitialAd;

  RxBool isBannerLoaded = false.obs;
  RxBool isInterstitialLoaded = false.obs;

  /// INIT ADS
  Future<AdMobService> init() async {
    await MobileAds.instance.initialize();
    loadBannerAd();
    loadInterstitialAd();
    return this;
  }

  /// =========================
  /// BANNER AD
  /// =========================
  void loadBannerAd() {
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: bannerAdUnitId,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          isBannerLoaded.value = true;
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          isBannerLoaded.value = false;
        },
      ),
    );

    bannerAd!.load();
  }

  /// Widget to show in UI
  Widget getBannerAdWidget() {
    if (bannerAd == null || !isBannerLoaded.value) {
      return const SizedBox();
    }

    return SizedBox(
      width: bannerAd!.size.width.toDouble(),
      height: bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: bannerAd!),
    );
  }

  /// =========================
  /// INTERSTITIAL AD
  /// =========================
  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd = ad;
          isInterstitialLoaded.value = true;

          interstitialAd!.setImmersiveMode(true);

          interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              isInterstitialLoaded.value = false;
              loadInterstitialAd(); // reload next ad
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              isInterstitialLoaded.value = false;
              loadInterstitialAd();
            },
          );
        },
        onAdFailedToLoad: (error) {
          isInterstitialLoaded.value = false;
        },
      ),
    );
  }

  /// SHOW INTERSTITIAL AD
  void showInterstitialAd({required VoidCallback onComplete}) {
    if (interstitialAd == null || !isInterstitialLoaded.value) {
      onComplete();
      loadInterstitialAd();
      return;
    }

    interstitialAd!.show();
    interstitialAd = null;

    onComplete();
  }

  @override
  void onClose() {
    bannerAd?.dispose();
    interstitialAd?.dispose();
    super.onClose();
  }
}
