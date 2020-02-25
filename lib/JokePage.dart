import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

import 'const.dart';
import 'key_id.dart';

const String testDevices = "MobileID";

class JokePage extends StatefulWidget {
  final List allJokes;
  JokePage(this.allJokes);

  @override
  _JokePageState createState() => _JokePageState();
}

class _JokePageState extends State<JokePage> {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevices != null ? <String>['testDevices'] : null,
    keywords: <String>['Game', 'Ecommerce', 'Business'],
    nonPersonalizedAds: true,
  );
  BannerAd _bannerAd;
  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: adUnitID,
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("Banner Ad $event");
        });
  }

  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: appID);
    _bannerAd = createBannerAd()
      ..load()
      ..show();
    super.initState();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: neoDarkShadow,
          title: Text("নতুন বাংলা কৌতুক"),
          centerTitle: true,
          elevation: 5.0,
        ),
        body: SafeArea(
          child: Container(
            color: neoWhite,
            child: CarouselSlider(
              height: MediaQuery.of(context).size.height - 130,
              items: widget.allJokes.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin:
                          EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                      decoration: BoxDecoration(
                          color: neoWhite,
                          borderRadius: BorderRadius.circular(25.0),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 16,
                              spreadRadius: 16,
                              color: neoDarkShadow,
                            )
                          ]),
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Text(
                                i['title'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1,
                            child: Container(
                              color: neoDarkShadow,
                            ),
                          ),
                          Expanded(
                            flex: 10,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Text(
                                  i['body'],
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
