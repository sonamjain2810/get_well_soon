// Package Name : top.latest.birthday.wishes.shayari.quotes.messages.images.gif.videos.creator
import 'dart:async';
import 'dart:io';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/widgets/CustomFBTextWidget.dart';
import '/widgets/CustomFullCard.dart';
import '/widgets/CustomOnlyTextWidget.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';
import 'data/AdService.dart';
import 'data/Strings.dart';
import 'utils/SizeConfig.dart';
import 'AboutUs.dart';
import 'GifsImages.dart';
import 'ImagesList.dart';
import 'MemeGenerator.dart';
import 'MessagesList.dart';
import 'MyDrawer.dart';

import 'widgets/CustomBannerWidget.dart';
import 'widgets/CustomBannerWidget4.dart';
import 'widgets/CustomTextOnlyWidget.dart';

// Height = 8.96
// Width = 4.14

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

const String testDevice = 'c835aea0489176f272e2d174b8d921ca';
// const String testDevice = 'testDeviceId';

class _HomePageState extends State<HomePage> {
  static final facebookAppEvents = FacebookAppEvents();
  String interstitialTag = "";
  String _authStatus = 'Unknown';

  late BannerAd bannerAd1, bannerAd2, bannerAd3;
  bool isBannerAdLoaded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => initPlugin());
    AdService.createInterstialAd();

    bannerAd1 = GetBannerAd();
    bannerAd2 = GetBannerAd();
    bannerAd3 = GetBannerAd();
  }

  BannerAd GetBannerAd() {
    return BannerAd(
        size: AdSize.mediumRectangle,
        adUnitId: Strings.iosAdmobBannerId,
        listener: BannerAdListener(onAdLoaded: (_) {
          setState(() {
            isBannerAdLoaded = true;
          });
        }, onAdFailedToLoad: (ad, error) {
          isBannerAdLoaded = true;
          ad.dispose();
        }),
        request: AdRequest())
      ..load();
  }

  @override
  void dispose() {
    super.dispose();
    bannerAd1.dispose();
    bannerAd2.dispose();
    bannerAd3.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlugin() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final TrackingStatus status =
          await AppTrackingTransparency.requestTrackingAuthorization();

      switch (status) {
        case TrackingStatus.authorized:
          print("Tracking Status Authorized");
          break;
        case TrackingStatus.denied:
          print("Tracking Status Denied");
          break;
        case TrackingStatus.notDetermined:
          print("Tracking Status not Determined");
          break;
        case TrackingStatus.notSupported:
          print("Tracking Status not Supported");
          break;
        case TrackingStatus.restricted:
          print("Tracking Status Restricted");
          break;
        default:
      }
    } on PlatformException {
      setState(() => _authStatus = 'PlatformException was thrown');
    }

    final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
    print("UUID: $uuid");
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: Theme.of(context).appBarTheme.textTheme!.headline1,
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration:
              MediaQuery.of(context).platformBrightness == Brightness.dark
                  ? BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        colors: [
                          Colors.black,
                          Colors.grey[900]!,
                          Colors.grey[600]!,
                        ],
                      ),
                    )
                  : BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        colors: [
                          Colors.pink[600]!,
                          Colors.pinkAccent,
                          Colors.pink[300]!,
                        ],
                      ),
                    ),
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                height: size.height * 0.265,
                child: Container(
                  color: Colors.transparent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(SizeConfig.width(0.0)),
                    child: Image.asset(
                      "lib/assets/get_well_soon.jpg",
                      height: size.height * 0.265,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: size.height * 0.60,
                child: Container(
                  padding: EdgeInsets.only(top: SizeConfig.width(30)),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(SizeConfig.width(30)),
                        topRight: Radius.circular(SizeConfig.width(30))),
                  ),
                  child: ListView(
                    children: <Widget>[
                      SizedBox(
                        //8
                        height: 0.90 * SizeConfig.heightMultiplier,
                      ),

                      Padding(
                        padding: EdgeInsets.all(SizeConfig.width(8)),
                        child: Center(
                          child: Text("Pick Anything from Beneath",
                              style: Theme.of(context).textTheme.headline1),
                        ),
                      ),

                      Divider(),

                      // Wishes Start

                      Padding(
                        padding: EdgeInsets.all(SizeConfig.width(8)),
                        child: Text("Messages In Your Language",
                            style: Theme.of(context).textTheme.headline1),
                      ),

                      Padding(
                        padding: EdgeInsets.all(SizeConfig.width(8)),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              InkWell(
                                child: CustomOnlyTextWidget(
                                  size: size,
                                  color: Colors.lightBlue,
                                  text: "English",
                                ),
                                onTap: () {
                                  print("English Message Clicked");
                                  interstitialTag = "lang_english";
                                  facebookAppEvents.logEvent(
                                    name: "Message List",
                                    parameters: {
                                      'button_id': 'lang_english_button',
                                    },
                                  );
                                  AdService.context = context;
                                  AdService.interstitialTag = "lang_english";
                                  AdService.showInterstitialAd();
                                },
                              ),
                              SizedBox(width: SizeConfig.width(8)),
                              InkWell(
                                child: CustomOnlyTextWidget(
                                  size: size,
                                  color: Colors.cyan,
                                  text: "français",
                                ),
                                onTap: () {
                                  print("français Clicked");
                                  interstitialTag = "lang_french";
                                  facebookAppEvents.logEvent(
                                    name: "Message List",
                                    parameters: {
                                      'button_id': 'lang_french_button',
                                    },
                                  );
                                  AdService.context = context;
                                  AdService.interstitialTag = "lang_french";
                                  AdService.showInterstitialAd();
                                },
                              ),
                              SizedBox(width: SizeConfig.width(8)),
                              InkWell(
                                child: CustomOnlyTextWidget(
                                  size: size,
                                  color: Colors.pinkAccent,
                                  text: "Deutsche",
                                ),
                                onTap: () {
                                  print("German Clicked");
                                  interstitialTag = "lang_german";
                                  facebookAppEvents.logEvent(
                                    name: "Message List",
                                    parameters: {
                                      'button_id': 'lang_german_button',
                                    },
                                  );
                                  AdService.context = context;
                                  AdService.interstitialTag = "lang_german";
                                  AdService.showInterstitialAd();
                                },
                              ),
                              SizedBox(width: SizeConfig.width(8)),
                              InkWell(
                                child: CustomOnlyTextWidget(
                                  size: size,
                                  color: Colors.lime,
                                  text: "हिन्दी",
                                ),
                                onTap: () {
                                  print("Hindi Clicked");
                                  interstitialTag = "lang_hindi";
                                  facebookAppEvents.logEvent(
                                    name: "Message List",
                                    parameters: {
                                      'button_id': 'lang_hindi_button',
                                    },
                                  );
                                  AdService.context = context;
                                  AdService.interstitialTag = "lang_hindi";
                                  AdService.showInterstitialAd();
                                },
                              ),
                              SizedBox(width: SizeConfig.width(8)),
                              InkWell(
                                child: CustomOnlyTextWidget(
                                  size: size,
                                  color: Colors.pink,
                                  text: "Italiano",
                                ),
                                onTap: () {
                                  print("Italian Clicked");
                                  interstitialTag = "lang_italian";
                                  facebookAppEvents.logEvent(
                                    name: "Message List",
                                    parameters: {
                                      'button_id': 'lang_italian_button',
                                    },
                                  );
                                  AdService.context = context;
                                  AdService.interstitialTag = "lang_italian";
                                  AdService.showInterstitialAd();
                                },
                              ),
                              SizedBox(width: SizeConfig.width(8)),
                              InkWell(
                                child: CustomOnlyTextWidget(
                                  size: size,
                                  color: Colors.orange,
                                  text: "Português",
                                ),
                                onTap: () {
                                  print("Portuguese Clicked");
                                  interstitialTag = "lang_portuguese";
                                  facebookAppEvents.logEvent(
                                    name: "Message List",
                                    parameters: {
                                      'button_id': 'lang_portuguese_button',
                                    },
                                  );
                                  AdService.context = context;
                                  AdService.interstitialTag = "lang_portuguese";
                                  AdService.showInterstitialAd();
                                },
                              ),
                              SizedBox(width: SizeConfig.width(8)),
                              InkWell(
                                child: CustomOnlyTextWidget(
                                  size: size,
                                  color: Colors.lightGreen,
                                  text: "Español",
                                ),
                                onTap: () {
                                  print("For All Clicked");
                                  interstitialTag = "lang_spanish";
                                  facebookAppEvents.logEvent(
                                    name: "Message List",
                                    parameters: {
                                      'button_id': 'lang_spanish_button',
                                    },
                                  );
                                  AdService.context = context;
                                  AdService.interstitialTag = "lang_spanish";
                                  AdService.showInterstitialAd();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Wishes end

                      Divider(),

                      // Status Start

                      Padding(
                        padding: EdgeInsets.all(SizeConfig.width(8)),
                        child: Text("Status at Glimpse",
                            style: Theme.of(context).textTheme.headline1),
                      ),

                      Padding(
                        padding: EdgeInsets.all(SizeConfig.width(8)),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: InkWell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                InkWell(
                                  child: CustomFBTextWidget(
                                    size: size,
                                    text:
                                        "It’s hard to believe you are taking this much time to recover. Get well soon buddy. I am badly missing you here!",
                                    color: Colors.indigoAccent,
                                    url:
                                        "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k49.png",
                                    isLeft: false,
                                  ),
                                  onTap: (() {
                                    print("English Message Clicked");
                                    interstitialTag = "lang_english";
                                    facebookAppEvents.logEvent(
                                      name: "Message List",
                                      parameters: {
                                        'button_id': 'lang_english_button',
                                      },
                                    );
                                    AdService.context = context;
                                    AdService.interstitialTag = "lang_english";
                                    AdService.showInterstitialAd();
                                  }),
                                ),
                                SizedBox(width: SizeConfig.width(8)),
                                InkWell(
                                    child: CustomFBTextWidget(
                                      size: size,
                                      text:
                                          "J'espère que tu guéris petit à petit et que tu te portes de mieux en mieux.\nTu sais que je suis là, et que tu peux compter sur moi. Courage, je pense fort à toi.\nBon rétablissement cher ami.",
                                      color: Colors.orangeAccent,
                                      url:
                                          "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k39.png",
                                      isLeft: false,
                                    ),
                                    onTap: () {
                                      print("français Clicked");
                                      interstitialTag = "lang_french";
                                      facebookAppEvents.logEvent(
                                        name: "Message List",
                                        parameters: {
                                          'button_id': 'lang_french_button',
                                        },
                                      );
                                      AdService.context = context;
                                      AdService.interstitialTag = "lang_french";
                                      AdService.showInterstitialAd();
                                    }),
                                SizedBox(width: SizeConfig.width(8)),
                                InkWell(
                                  child: CustomFBTextWidget(
                                    size: size,
                                    text:
                                        "Die Kollegen wünschen Ihnen von ganzem Herzen gute Besserung. Wir alle vermissen Sie und senden viele liebe Genesungsgrüße!",
                                    color: Colors.redAccent,
                                    url:
                                        "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k29.png",
                                    isLeft: false,
                                  ),
                                  onTap: () {
                                    print("German Clicked");
                                    interstitialTag = "lang_german";
                                    facebookAppEvents.logEvent(
                                      name: "Message List",
                                      parameters: {
                                        'button_id': 'lang_german_button',
                                      },
                                    );
                                    AdService.context = context;
                                    AdService.interstitialTag = "lang_german";
                                    AdService.showInterstitialAd();
                                  },
                                ),
                                SizedBox(width: SizeConfig.width(8)),
                                InkWell(
                                  child: CustomFBTextWidget(
                                    size: size,
                                    text:
                                        "Siamo certi che a breve riuscirai ad essere lo stesso di prima. Buona guarigione!",
                                    color: Colors.amber,
                                    url:
                                        "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k19.png",
                                    isLeft: false,
                                  ),
                                  onTap: () {
                                    print("Italian Clicked");
                                    interstitialTag = "lang_italian";
                                    facebookAppEvents.logEvent(
                                      name: "Message List",
                                      parameters: {
                                        'button_id': 'lang_italian_button',
                                      },
                                    );
                                    AdService.context = context;
                                    AdService.interstitialTag = "lang_italian";
                                    AdService.showInterstitialAd();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
// Status end
                      Divider(),

                      Container(
                        height: bannerAd1.size.height.toDouble(),
                        width: bannerAd1.size.width.toDouble(),
                        child: AdWidget(ad: bannerAd1),
                      ),

                      Divider(),

// Shayari Start
                      Padding(
                        padding: EdgeInsets.all(SizeConfig.width(8)),
                        child: Text("Hindi Messages",
                            style: Theme.of(context).textTheme.headline1),
                      ),

                      Padding(
                        padding: EdgeInsets.all(SizeConfig.width(8)),
                        child: InkWell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                CustomTextOnlyWidget(
                                  language: "हिंदी",
                                  size: size,
                                  color: Colors.indigo,
                                  text:
                                      "दवा मिले डॉक्टर से,साथ मिले अपनो से,\nखुशियां मिले जग से,रहमत मिले रब से,\nप्यार मिले सब से,यही दुआ है रब से,\nकि तुम ठीक हो जाओ फटाफट से...",
                                ),
                                CustomTextOnlyWidget(
                                  language: "हिंदी",
                                  size: size,
                                  color: Colors.blueGrey,
                                  text:
                                      "आज ऐसी क्या दुआ दू तुझको,\nजो तेरे लबों पे हंसी फूल खिला दे,\nबस यही दुआ है मेरी की,\n“अफताब से रोशन” खुदा तेरी तकदीर बना दे…\nजल्द ठीक हो जाओ !",
                                ),
                              ],
                            ),
                            onTap: () {
                              print("Hindi Clicked");
                              interstitialTag = "lang_hindi";
                              facebookAppEvents.logEvent(
                                name: "Message List",
                                parameters: {
                                  'button_id': 'lang_hindi_button',
                                },
                              );
                              AdService.context = context;
                              AdService.interstitialTag = "lang_hindi";
                              AdService.showInterstitialAd();
                            }),
                      ),

// Shayari End

                      Divider(),

// Wish Creator Start
                      Padding(
                        padding: EdgeInsets.all(SizeConfig.width(8)),
                        child: Text("Make Get Well Soon Greetings Card!!",
                            style: Theme.of(context).textTheme.headline1),
                      ),
                      // Wish Creator
                      Padding(
                        //16.0
                        padding: EdgeInsets.all(SizeConfig.width(8)),
                        child: InkWell(
                            child: CustomBannerWidget(
                              size: MediaQuery.of(context).size,
                              imagePath:
                                  "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k1.png",
                              buttonText: "Make it",
                              topText: "Make Greetings for",
                              middleText: "Get Well Soon",
                              bottomText:
                                  "Share it With Your Friends & Relatives",
                            ),
                            onTap: () {
                              print("Meme Clicked");
                              interstitialTag = "meme";
                              facebookAppEvents.logEvent(
                                name: "Meme Generator",
                                parameters: {
                                  'button_id': 'meme_button',
                                },
                              );

                              AdService.context = context;
                              AdService.interstitialTag = "meme";
                              AdService.showInterstitialAd();
                            }),
                      ),

// Wish Creator end
                      Divider(),
                      // JPG Section
                      Container(
                        height: bannerAd2.size.height.toDouble(),
                        width: bannerAd2.size.width.toDouble(),
                        child: AdWidget(ad: bannerAd2),
                      ),
                      Divider(),

                      Padding(
                        padding: EdgeInsets.all(SizeConfig.width(8)),
                        child: Text("Images Cards",
                            style: Theme.of(context).textTheme.headline1),
                      ),
                      Padding(
                        padding: EdgeInsets.all(SizeConfig.width(8)),
                        child: InkWell(
                          child: Container(
                            //color: Colors.blueGrey,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                // Column 1:
                                Column(
                                  children: <Widget>[
                                    // Column 1 item 1:
                                    CustomBannerWidget4(
                                        imagePath:
                                            "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k29.png",
                                        headingText: "",
                                        bodyText: ""),
                                    SizedBox(height: SizeConfig.height(8)),
                                    // Column 1 item 2:
                                    CustomBannerWidget4(
                                        imagePath:
                                            "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k13.png",
                                        headingText: "",
                                        bodyText: ""),
                                  ],
                                ),
                                // Column2:
                                Column(
                                  children: <Widget>[
                                    // Column 2 item 1:
                                    CustomBannerWidget4(
                                        imagePath:
                                            "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k18.png",
                                        headingText: "",
                                        bodyText: ""),
                                    SizedBox(height: SizeConfig.height(8)),
                                    // Column 1 item 2:
                                    CustomBannerWidget4(
                                        imagePath:
                                            "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k16.png",
                                        headingText: "",
                                        bodyText: ""),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            print("Images Clicked");
                            interstitialTag = "image";
                            facebookAppEvents.logEvent(
                              name: "Image List",
                              parameters: {
                                'button_id': 'Image_button',
                              },
                            );
                            AdService.context = context;
                            AdService.interstitialTag = "image";
                            AdService.showInterstitialAd();
                          },
                        ),
                      ),

                      // JPG Section
                      Divider(),

                      Padding(
                        padding: EdgeInsets.all(SizeConfig.width(8)),
                        child: Text("Gifs Cards",
                            style: Theme.of(context).textTheme.headline1),
                      ),
                      Padding(
                        padding: EdgeInsets.all(SizeConfig.width(8)),
                        child: InkWell(
                          child: Container(
                            //color: Colors.blueGrey,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                // Column 1:
                                Column(
                                  children: <Widget>[
                                    // Column 1 item 1:
                                    CustomBannerWidget4(
                                        imagePath:
                                            "http://andiwiniosapps.in/get_well_soon_message/get_well_soon_gifs/2.gif",
                                        headingText: "",
                                        bodyText: ""),
                                    SizedBox(height: SizeConfig.height(8)),
                                    // Column 1 item 2:
                                    CustomBannerWidget4(
                                        imagePath:
                                            "http://andiwiniosapps.in/get_well_soon_message/get_well_soon_gifs/38.gif",
                                        headingText: "",
                                        bodyText: ""),
                                  ],
                                ),
                                // Column2:
                                Column(
                                  children: <Widget>[
                                    // Column 2 item 1:
                                    CustomBannerWidget4(
                                        imagePath:
                                            "http://andiwiniosapps.in/get_well_soon_message/get_well_soon_gifs/39.gif",
                                        headingText: "",
                                        bodyText: ""),
                                    SizedBox(height: SizeConfig.height(8)),
                                    // Column 1 item 2:
                                    CustomBannerWidget4(
                                        imagePath:
                                            "http://andiwiniosapps.in/get_well_soon_message/get_well_soon_gifs/24.gif",
                                        headingText: "",
                                        bodyText: ""),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            print("Gifs Clicked");
                            interstitialTag = "gif";
                            facebookAppEvents.logEvent(
                              name: "GIF List",
                              parameters: {
                                'button_id': 'gif_button',
                              },
                            );
                            AdService.context = context;
                            AdService.interstitialTag = "gif";
                            AdService.showInterstitialAd();
                          },
                        ),
                      ),
                      Divider(),

                      Container(
                        height: bannerAd3.size.height.toDouble(),
                        width: bannerAd3.size.width.toDouble(),
                        child: AdWidget(ad: bannerAd3),
                      ),

                      Divider(),

                      Padding(
                        padding: EdgeInsets.all(SizeConfig.width(8)),
                        child: Text("Play Game \"Sell Rakhi\"",
                            style: Theme.of(context).textTheme.headline1),
                      ),

                      InkWell(
                        child: CustomFullCard(
                          size: MediaQuery.of(context).size,
                          imageUrl: "lib/assets/rakhi_game.jpeg",
                        ),
                        onTap: () {
                          if (Platform.isAndroid) {
                            // Android-specific code
                            print("More Button Clicked");
                            launch(
                                "https://play.google.com/store/apps/developer?id=Festival+Messages+SMS");
                          } else if (Platform.isIOS) {
                            // iOS-specific code
                            print("More Button Clicked");
                            launch(
                                "https://apps.apple.com/us/app/-/id1434054710");

                            facebookAppEvents.logEvent(
                              name: "Play Rakshabandhan Game",
                              parameters: {
                                'clicked_on_play_rakshabandhan_game': 'Yes',
                              },
                            );
                          }
                        },
                      ),

                      Divider(),

                      Padding(
                        padding: EdgeInsets.all(SizeConfig.width(8)),
                        child: Text("Apps From Developer",
                            style: Theme.of(context).textTheme.headline1),
                      ),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: EdgeInsets.all(SizeConfig.width(8)),
                          child: Row(
                            children: <Widget>[
                              //Column1
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  AppStoreAppsItemWidget1(
                                      imageUrl:
                                          "https://is1-ssl.mzstatic.com/image/thumb/Purple117/v4/8f/e7/b5/8fe7b5bc-03eb-808c-2b9e-fc2c12112a45/mzl.jivuavtz.png/292x0w.jpg",
                                      appTitle:
                                          "Good Morning Images & Messages",
                                      appUrl:
                                          "https://apps.apple.com/us/app/good-morning-images-messages-to-wish-greet-gm/id1232993917"),
                                  Divider(),
                                  AppStoreAppsItemWidget1(
                                      imageUrl:
                                          "https://is4-ssl.mzstatic.com/image/thumb/Purple114/v4/44/e0/fd/44e0fdb5-667b-5468-7b2f-53638cba539e/AppIcon-1x_U007emarketing-0-7-0-0-85-220.png/292x0w.jpg",
                                      appTitle: "Birthday Status Wishes Quotes",
                                      appUrl:
                                          "https://apps.apple.com/us/app/birthday-status-wishes-quotes/id1522542709"),
                                  Divider(),
                                  AppStoreAppsItemWidget1(
                                      imageUrl:
                                          "https://is3-ssl.mzstatic.com/image/thumb/Purple124/v4/9c/17/e3/9c17e319-fadf-d92a-b586-bacda2d699bd/AppIcon-1x_U007emarketing-0-7-0-0-85-220.png/230x0w.webp",
                                      appTitle:
                                          "Good Night Gif Image Quote Sm‪s",
                                      appUrl:
                                          "https://apps.apple.com/us/app/good-night-gif-image-quote-sms/id1527002426"),
                                ],
                              ),
                              SizedBox(width: SizeConfig.width(3)),
                              //Column2
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  AppStoreAppsItemWidget1(
                                      imageUrl:
                                          "https://is2-ssl.mzstatic.com/image/thumb/Purple124/v4/e9/96/64/e99664d3-1083-5fac-6a0c-61718ee209fd/AppIcon-0-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-7.png/292x0w.jpg",
                                      appTitle:
                                          "Weight Loss My Diet Coach Tips",
                                      appUrl:
                                          "https://apps.apple.com/us/app/weight-loss-my-diet-coach-tips/id1448343218"),
                                  Divider(),
                                  AppStoreAppsItemWidget1(
                                      imageUrl:
                                          "https://is2-ssl.mzstatic.com/image/thumb/Purple127/v4/5f/7c/45/5f7c45c7-fb75-ea39-feaa-a698b0e4b09e/pr_source.jpg/292x0w.jpg",
                                      appTitle:
                                          "English Speaking Course Grammar",
                                      appUrl:
                                          "https://apps.apple.com/us/app/english-speaking-course-learn-grammar-vocabulary/id1233093288"),
                                  Divider(),
                                  AppStoreAppsItemWidget1(
                                      imageUrl:
                                          "https://is4-ssl.mzstatic.com/image/thumb/Purple128/v4/50/ad/82/50ad82d9-0d82-5007-fcdd-cc47c439bfd0/AppIcon-0-1x_U007emarketing-0-85-220-10.png/292x0w.jpg",
                                      appTitle:
                                          "English Hindi Language Diction",
                                      appUrl:
                                          "https://apps.apple.com/us/app/english-hindi-language-diction/id1441243874"),
                                ],
                              ),
                              SizedBox(width: SizeConfig.width(3)),
                              //Column3

                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  AppStoreAppsItemWidget1(
                                      imageUrl:
                                          "https://is1-ssl.mzstatic.com/image/thumb/Purple124/v4/89/1b/44/891b44e5-bbb3-a530-0f97-011c226d79e1/AppIcon-1x_U007emarketing-0-7-0-0-85-220.png/230x0w.webp",
                                      appTitle:
                                          "Thank You Greetings Card Make‪r",
                                      appUrl:
                                          "https://apps.apple.com/us/app/thank-you-greetings-card-maker/id1552601152"),
                                  Divider(),
                                  AppStoreAppsItemWidget1(
                                      imageUrl:
                                          "https://is3-ssl.mzstatic.com/image/thumb/Purple114/v4/b6/3d/cd/b63dcde0-b4db-d05b-7025-e879a338049a/AppIcon-1x_U007emarketing-0-7-0-0-85-220.png/230x0w.webp",
                                      appTitle:
                                          "Sorry Forgive Card Status Gif‪s‬",
                                      appUrl:
                                          "https://apps.apple.com/us/app/sorry-forgive-card-status-gifs/id1549696526"),
                                  Divider(),
                                  AppStoreAppsItemWidget1(
                                      imageUrl:
                                          "https://is1-ssl.mzstatic.com/image/thumb/Purple114/v4/9a/52/7a/9a527a0e-ca83-ecba-5f1b-336057d7a48b/AppIcon-1x_U007emarketing-0-7-0-0-85-220.png/230x0w.webp",
                                      appTitle:
                                          "Anniversary Wishes Gif Image‪s‬",
                                      appUrl:
                                          "https://apps.apple.com/us/app/anniversary-wishes-gif-images/id1527002955"),
                                ],
                              ),
                              SizedBox(width: SizeConfig.width(3)),

                              //Column4
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  AppStoreAppsItemWidget1(
                                      imageUrl:
                                          "https://is1-ssl.mzstatic.com/image/thumb/Purple114/v4/cd/fa/5f/cdfa5f06-68b0-c6ff-eb35-e4b5cd5ac890/AppIcon-1x_U007emarketing-0-7-0-0-85-220.png/230x0w.webp",
                                      appTitle:
                                          "Get Well Soon Gif Image eCard‪s",
                                      appUrl:
                                          "https://apps.apple.com/us/app/get-well-soon-gif-image-ecards/id1526953576"),
                                  Divider(),
                                  /*AppStoreAppsItemWidget1(
                                  imageUrl:
                                      "https://is4-ssl.mzstatic.com/image/thumb/Purple91/v4/f0/84/d7/f084d764-79a8-f6d1-3778-1cb27fabb8bd/pr_source.png/292x0w.jpg",
                                  appTitle: "Egg Recipes 100+ Recipes",
                                  appUrl:
                                      "https://apps.apple.com/us/app/egg-recipes-100-recipes-collection-for-eggetarian/id1232736881"),
                              Divider(),*/
                                  AppStoreAppsItemWidget1(
                                      imageUrl:
                                          "https://is1-ssl.mzstatic.com/image/thumb/Purple114/v4/0f/d6/f4/0fd6f410-9664-94a5-123f-38d787bf28c6/AppIcon-1x_U007emarketing-0-7-0-0-85-220.png/292x0w.jpg",
                                      appTitle:
                                          "Rakshabandhan Images Greetings",
                                      appUrl:
                                          "https://apps.apple.com/us/app/rakshabandhan-images-greetings/id1523619788"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}

class AppStoreAppsItemWidget1 extends StatelessWidget {
  const AppStoreAppsItemWidget1({
    Key? key,
    this.imageUrl,
    this.appUrl,
    this.appTitle,
  }) : super(key: key);

  final String? imageUrl, appUrl, appTitle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius:
                BorderRadius.all(Radius.circular(SizeConfig.width(16))),
            child: Padding(
              padding: EdgeInsets.only(right: SizeConfig.width(3)),
              child: CachedNetworkImage(
                height: SizeConfig.height(80),
                width: SizeConfig.width(80),
                imageUrl: imageUrl!,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fadeOutDuration: const Duration(seconds: 1),
                fadeInDuration: const Duration(seconds: 3),
              ),
            ),
          ),
          Text(
            appTitle!,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      onTap: () {
        launch(appUrl!);
      },
    );
  }
}
