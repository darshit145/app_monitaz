import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'add_model.dart';

class RewardedAdScreen extends StatefulWidget {
  const RewardedAdScreen({super.key});

  @override
  State<RewardedAdScreen> createState() => _RewardedAdScreenState();
}

class _RewardedAdScreenState extends State<RewardedAdScreen> {
  RewardedAd? rewardedAd;
  late AddModel addModel;

  @override
  void initState() {
    super.initState();
    addModel = context.read<AddModel>();
    addModel.initializaation.then((value) {
      loadRewardedAd();
    });
  }

  void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: addModel.RewardedId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          setState(() {
            rewardedAd = ad;
          });
        },
        onAdFailedToLoad: (error) {
          setState(() {
            rewardedAd = null;
          });
          print("RewardedAd failed to load: $error");
        },
      ),
    );
  }

  void showRewardedAd() {
    if (rewardedAd != null) {
      rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          loadRewardedAd(); // Load a new ad after the current one is dismissed
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          print("RewardedAd failed to show: $error");
        },
      );
      rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
          print('User earned reward: ${reward.amount} ${reward.type}');
          // Handle the reward here
        },
      );
      rewardedAd = null; // Reset the ad after showing it
    } else {
      print("RewardedAd is not ready yet.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rewarded Ad Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: showRewardedAd,
          child: Text('Show Rewarded Ad'),
        ),
      ),
    );
  }
}
