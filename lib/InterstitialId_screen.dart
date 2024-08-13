import 'package:app_monitaz/rewarded_sd_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'add_model.dart';

class InterstitialidScreen extends StatefulWidget {
  const InterstitialidScreen({super.key});

  @override
  State<InterstitialidScreen> createState() => _InterstitialidScreenState();
}

class _InterstitialidScreenState extends State<InterstitialidScreen> {
  InterstitialAd? interstitialAd;
  late AddModel addModel;

  @override
  void initState() {
    super.initState();
    addModel = context.read<AddModel>();
    addModel.initializaation.then((value) {
      loadInterstitialAd();
    });
  }

  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: addModel.InterstitialId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          setState(() {
            interstitialAd = ad;
          });
        },
        onAdFailedToLoad: (error) {
          setState(() {
            interstitialAd = null;
          });
          print("InterstitialAd failed to load: $error");
        },
      ),
    );
  }

  void showInterstitialAd() {
    if (interstitialAd != null) {
      interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          loadInterstitialAd(); // Load a new ad after the current one is dismissed
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          print("InterstitialAd failed to show: $error");
        },
      );
      interstitialAd!.show();
      interstitialAd = null; // Reset the ad after showing it
    } else {
      print("InterstitialAd is not ready yet.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interstitial Ad Example'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const RewardedAdScreen(),));
            }, child: const Text("reWarded AD")),
            ElevatedButton(
              onPressed: showInterstitialAd,
              child: const Text('Show Interstitial Ad'),
            ),
          ],
        ),
      ),
    );
  }
}
