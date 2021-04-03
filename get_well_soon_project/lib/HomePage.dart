// Package Name : top.latest.birthday.wishes.shayari.quotes.messages.images.gif.videos.creator
import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:get_well_soon/widgets/CustomFBTextWidget.dart';
import 'package:get_well_soon/widgets/CustomFullCard.dart';
import 'package:get_well_soon/widgets/CustomOnlyTextWidget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'utils/SizeConfig.dart';
import 'AboutUs.dart';
import 'GifsImages.dart';
import 'ImagesList.dart';
import 'MemeGenerator.dart';
import 'MessagesList.dart';
import 'MyDrawer.dart';
import 'NativeAdContainer.dart';
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

// Native Ad Open
  static String _adUnitID = NativeAd.testAdUnitId;

  final _nativeAdController = NativeAdmobController();
  double _height = 0;

  StreamSubscription _subscription;

//Native Ad Close

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    //keywords: Keywords.adsKeywords,
    //contentUrl: 'http://foo.com/bar.html',
    childDirected: false,
    nonPersonalizedAds: true,
  );

  InterstitialAd _interstitialAd;

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: InterstitialAd.testAdUnitId,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event $event");
        if (event == MobileAdEvent.closed) {
          _interstitialAd = createInterstitialAd()..load();

          if (interstitialTag != null) {
            switch (interstitialTag) {
              case "message":
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => MessagesList()));
                break;
              case "lang_english":
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        MessagesList(type: "1")));
                break;

              case "lang_french":
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        MessagesList(type: "2")));
                break;

              case "lang_german":
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        MessagesList(type: "3")));
                break;

              case "lang_hindi":
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        MessagesList(type: "4")));
                break;

              case "lang_italian":
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        MessagesList(type: "5")));
                break;

              case "lang_portuguese":
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        MessagesList(type: "6")));
                break;

              case "lang_spanish":
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        MessagesList(type: "7")));
                break;

              case "gif":
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => GifsImages()));
                break;

              case "image":
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => ImagesList()));
                break;

              case "meme":
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => MemeGenerator()));
                break;

              case "about":
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => AboutUs()));
                break;

              default:
            }
          }
        } else if (event == MobileAdEvent.failedToLoad) {
          if (interstitialTag != null) {
            switch (interstitialTag) {
              case "message":
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => MessagesList()));
                break;

              case "lang_english":
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        MessagesList(type: "1")));
                break;

              case "lang_french":
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        MessagesList(type: "2")));
                break;

              case "lang_german":
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        MessagesList(type: "3")));
                break;

              case "lang_hindi":
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        MessagesList(type: "4")));
                break;

              case "lang_italian":
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        MessagesList(type: "5")));
                break;

              case "lang_portuguese":
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        MessagesList(type: "6")));
                break;

              case "lang_spanish":
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        MessagesList(type: "7")));
                break;

              case "gif":
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => GifsImages()));
                break;

              case "image":
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => ImagesList()));
                break;

              case "meme":
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => MemeGenerator()));
                break;

              case "about":
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => AboutUs()));
                break;

              default:
            }
          }
        } else {
          print(event.toString());
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);

    _interstitialAd?.dispose();
    _interstitialAd = createInterstitialAd()..load();

    //Native Ad
    _subscription = _nativeAdController.stateChanged.listen(_onStateChanged);
    //
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    //Native Ad
    _subscription.cancel();
    _nativeAdController.dispose();
    super.dispose();
  }

  void _onStateChanged(AdLoadState state) {
    switch (state) {
      case AdLoadState.loading:
        setState(() {
          _height = 0;
        });
        break;

      case AdLoadState.loadCompleted:
        setState(() {
          _height = 36.83 * SizeConfig.heightMultiplier;
        });
        break;

      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: Theme.of(context).appBarTheme.textTheme.headline1,
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
                          Colors.grey[900],
                          Colors.grey[600],
                        ],
                      ),
                    )
                  : BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        colors: [
                          Colors.pink[600],
                          Colors.pinkAccent,
                          Colors.pink[300],
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
                      "assets/get_well_soon.jpg",
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
                              CustomOnlyTextWidget(
                                
                                size: size,
                                color: Colors.lightBlue,
                                text: "English",
                                ontap: () {
                                  print("Language English Clicked");
                                  interstitialTag = "lang_english";
                                  facebookAppEvents.logEvent(
                                    name: "Message List",
                                    parameters: {
                                      'button_id': 'lang_english_button',
                                    },
                                  );
                                  _interstitialAd.isLoaded() != null
                                      ? _interstitialAd?.show()
                                      : Navigator.of(context).push(
                                          new MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  MessagesList(type: "1")));
                                },
                              ),
                              SizedBox(width: SizeConfig.width(8)),
                              CustomOnlyTextWidget(
                                size: size,
                                color: Colors.cyan,
                                text: "français",
                                ontap: () {
                                  print("français Clicked");
                                  interstitialTag = "lang_french";
                                  facebookAppEvents.logEvent(
                                    name: "Message List",
                                    parameters: {
                                      'button_id': 'lang_french_button',
                                    },
                                  );
                                  _interstitialAd.isLoaded() != null
                                      ? _interstitialAd?.show()
                                      : Navigator.of(context).push(
                                          new MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  MessagesList(type: "2")));
                                },
                              ),
                              SizedBox(width: SizeConfig.width(8)),
                              CustomOnlyTextWidget(
                                size: size,
                                color: Colors.pinkAccent,
                                text: "Deutsche",
                                ontap: () {
                                  print("German Clicked");
                                  interstitialTag = "lang_german";
                                  facebookAppEvents.logEvent(
                                    name: "Message List",
                                    parameters: {
                                      'button_id': 'lang_german_button',
                                    },
                                  );
                                  _interstitialAd.isLoaded() != null
                                      ? _interstitialAd?.show()
                                      : Navigator.of(context).push(
                                          new MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  MessagesList(type: "3")));
                                },
                              ),
                              SizedBox(width: SizeConfig.width(8)),
                              CustomOnlyTextWidget(
                                size: size,
                                color: Colors.lime,
                                text: "हिन्दी",
                                ontap: () {
                                  print("Hindi Clicked");
                                  interstitialTag = "lang_hindi";
                                  facebookAppEvents.logEvent(
                                    name: "Message List",
                                    parameters: {
                                      'button_id': 'lang_hindi_button',
                                    },
                                  );
                                  _interstitialAd.isLoaded() != null
                                      ? _interstitialAd?.show()
                                      : Navigator.of(context).push(
                                          new MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  MessagesList(type: "4")));
                                },
                              ),
                              SizedBox(width: SizeConfig.width(8)),
                              CustomOnlyTextWidget(
                                size: size,
                                color: Colors.pink,
                                text: "Italiano",
                                ontap: () {
                                  print("Italian Clicked");
                                  interstitialTag = "lang_italian";
                                  facebookAppEvents.logEvent(
                                    name: "Message List",
                                    parameters: {
                                      'button_id': 'lang_italian_button',
                                    },
                                  );
                                  _interstitialAd.isLoaded() != null
                                      ? _interstitialAd?.show()
                                      : Navigator.of(context).push(
                                          new MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  MessagesList(type: "5")));
                                },
                              ),
                              SizedBox(width: SizeConfig.width(8)),
                              CustomOnlyTextWidget(
                                size: size,
                                color: Colors.orange,
                                text: "Português",
                                ontap: () {
                                  print("Portuguese Clicked");
                                  interstitialTag = "lang_portuguese";
                                  facebookAppEvents.logEvent(
                                    name: "Message List",
                                    parameters: {
                                      'button_id': 'lang_portuguese_button',
                                    },
                                  );
                                  _interstitialAd.isLoaded() != null
                                      ? _interstitialAd?.show()
                                      : Navigator.of(context).push(
                                          new MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  MessagesList(type: "6")));
                                },
                              ),
                              SizedBox(width: SizeConfig.width(8)),
                              CustomOnlyTextWidget(
                                size: size,
                                color: Colors.lightGreen,
                                text: "Español",
                                ontap: () {
                                  print("For All Clicked");
                                  interstitialTag = "lang_spanish";
                                  facebookAppEvents.logEvent(
                                    name: "Message List",
                                    parameters: {
                                      'button_id': 'lang_spanish_button',
                                    },
                                  );
                                  _interstitialAd.isLoaded() != null
                                      ? _interstitialAd?.show()
                                      : Navigator.of(context).push(
                                          new MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  MessagesList(type: "7")));
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
                                CustomFBTextWidget(
                                  size: size,
                                  text:
                                      "It’s hard to believe you are taking this much time to recover. Get well soon buddy. I am badly missing you here!",
                                  color: Colors.indigoAccent,
                                  url:
                                      "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k49.png",
                                  isLeft: false,
                                  ontap: () {
                                    print("Language English Clicked");
                                    interstitialTag = "lang_english";
                                    facebookAppEvents.logEvent(
                                      name: "Message List",
                                      parameters: {
                                        'button_id': 'lang_english_button',
                                      },
                                    );
                                    _interstitialAd.isLoaded() != null
                                        ? _interstitialAd?.show()
                                        : Navigator.of(context).push(
                                            new MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    MessagesList(type: "1")));
                                  },
                                ),
                                SizedBox(width: SizeConfig.width(8)),
                                CustomFBTextWidget(
                                  size: size,
                                  text:
                                      "J'espère que tu guéris petit à petit et que tu te portes de mieux en mieux.\nTu sais que je suis là, et que tu peux compter sur moi. Courage, je pense fort à toi.\nBon rétablissement cher ami.",
                                  color: Colors.orangeAccent,
                                  url:
                                      "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k39.png",
                                  isLeft: false,
                                  ontap: () {
                                    print("français Clicked");
                                    interstitialTag = "lang_french";
                                    facebookAppEvents.logEvent(
                                      name: "Message List",
                                      parameters: {
                                        'button_id': 'lang_french_button',
                                      },
                                    );
                                    _interstitialAd.isLoaded() != null
                                        ? _interstitialAd?.show()
                                        : Navigator.of(context).push(
                                            new MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    MessagesList(type: "2")));
                                  },
                                ),
                                SizedBox(width: SizeConfig.width(8)),
                                CustomFBTextWidget(
                                  size: size,
                                  text:
                                      "Die Kollegen wünschen Ihnen von ganzem Herzen gute Besserung. Wir alle vermissen Sie und senden viele liebe Genesungsgrüße!",
                                  color: Colors.redAccent,
                                  url:
                                      "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k29.png",
                                  isLeft: false,
                                  ontap: () {
                                    print("German Clicked");
                                    interstitialTag = "lang_german";
                                    facebookAppEvents.logEvent(
                                      name: "Message List",
                                      parameters: {
                                        'button_id': 'lang_german_button',
                                      },
                                    );
                                    _interstitialAd.isLoaded() != null
                                        ? _interstitialAd?.show()
                                        : Navigator.of(context).push(
                                            new MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    MessagesList(type: "3")));
                                  },
                                ),
                                SizedBox(width: SizeConfig.width(8)),
                                CustomFBTextWidget(
                                  size: size,
                                  text:
                                      "Siamo certi che a breve riuscirai ad essere lo stesso di prima. Buona guarigione!",
                                  color: Colors.amber,
                                  url:
                                      "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k19.png",
                                  isLeft: false,
                                  ontap: () {
                                  print("Italian Clicked");
                                  interstitialTag = "lang_italian";
                                  facebookAppEvents.logEvent(
                                    name: "Message List",
                                    parameters: {
                                      'button_id': 'lang_italian_button',
                                    },
                                  );
                                  _interstitialAd.isLoaded() != null
                                      ? _interstitialAd?.show()
                                      : Navigator.of(context).push(
                                          new MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  MessagesList(type: "5")));
                                },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
// Status end
                      Divider(),

                      NativeAdContainer(
                          height: _height,
                          adUnitID: _adUnitID,
                          nativeAdController: _nativeAdController),

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
                                size: size,
                                color: Colors.indigo,
                                text:
                                    "दवा मिले डॉक्टर से,साथ मिले अपनो से,\nखुशियां मिले जग से,रहमत मिले रब से,\nप्यार मिले सब से,यही दुआ है रब से,\nकि तुम ठीक हो जाओ फटाफट से...",
                              ),
                              CustomTextOnlyWidget(
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
                            _interstitialAd.isLoaded() != null
                                ? _interstitialAd?.show()
                                : Navigator.of(context).push(
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            MessagesList(type: "4")));
                          },
                        ),
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
                        child: CustomBannerWidget(
                            size: MediaQuery.of(context).size,
                            imagePath:
                                "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k1.png",
                            buttonText: "Make it",
                            topText: "Make Greetings for",
                            middleText: "Get Well Soon",
                            bottomText:
                                "Share it With Your Friends & Relatives",
                            ontap: () {
                              print("Meme Clicked");
                              interstitialTag = "meme";
                              facebookAppEvents.logEvent(
                                name: "Meme Generator",
                                parameters: {
                                  'button_id': 'meme_button',
                                },
                              );
                              _interstitialAd.isLoaded() != null
                                  ? _interstitialAd?.show()
                                  : Navigator.of(context).push(
                                      new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              MemeGenerator()));
                            }),
                      ),

// Wish Creator end
                      Divider(),
                      // JPG Section
                      NativeAdContainer(
                          height: _height,
                          adUnitID: _adUnitID,
                          nativeAdController: _nativeAdController),
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

                            _interstitialAd.isLoaded() != null
                                ? _interstitialAd?.show()
                                : Navigator.of(context).push(
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            ImagesList()));
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
                            _interstitialAd.isLoaded() != null
                                ? _interstitialAd?.show()
                                : Navigator.of(context).push(
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            GifsImages()));
                          },
                        ),
                      ),
                      Divider(),

                      NativeAdContainer(
                          height: _height,
                          adUnitID: _adUnitID,
                          nativeAdController: _nativeAdController),

                      Divider(),

                      Padding(
                        padding: EdgeInsets.all(SizeConfig.width(8)),
                        child: Text("Play Game \"Sell Rakhi\"",
                            style: Theme.of(context).textTheme.headline1),
                      ),

                      CustomFullCard(
                        size: MediaQuery.of(context).size,
                        imageUrl: "assets/rakhi_game.jpeg",
                        ontap: () {
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
                                          "https://is4-ssl.mzstatic.com/image/thumb/Purple114/v4/1a/58/a4/1a58a480-a0ae-1940-2cf3-38524430f66b/AppIcon-0-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-7.png/292x0w.jpg",
                                      appTitle: "Astrology Horoscope Lal Kitab",
                                      appUrl:
                                          "https://apps.apple.com/us/app/astrology-horoscope-lal-kitab/id1448343526"),
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
                                          "https://is3-ssl.mzstatic.com/image/thumb/Purple118/v4/17/f5/0c/17f50c4d-431b-72c6-b9f4-d1706da59394/AppIcon-0-1x_U007emarketing-0-0-85-220-7.png/292x0w.jpg",
                                      appTitle: "Celebrate Happy New Year 2019",
                                      appUrl:
                                          "https://apps.apple.com/us/app/celebrate-happy-new-year-2019/id1447735210"),
                                  Divider(),
                                  AppStoreAppsItemWidget1(
                                      imageUrl:
                                          "https://is1-ssl.mzstatic.com/image/thumb/Purple118/v4/79/1e/61/791e61de-500c-6c97-3947-8abbc6b887e3/AppIcon-0-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-7.png/292x0w.jpg",
                                      appTitle:
                                          "Bangladesh Passport Visa Biman",
                                      appUrl:
                                          "https://apps.apple.com/us/app/bangladesh-passport-visa-biman/id1443074171"),
                                  Divider(),
                                  AppStoreAppsItemWidget1(
                                      imageUrl:
                                          "https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/dd/34/c3/dd34c3e8-5c9f-51aa-a3eb-3a203f5fd49b/AppIcon-0-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-10.png/292x0w.jpg",
                                      appTitle:
                                          "Complete Spoken English Course",
                                      appUrl:
                                          "https://apps.apple.com/us/app/complete-spoken-english-course/id1440118617"),
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
                                          "https://is4-ssl.mzstatic.com/image/thumb/Purple128/v4/bd/00/ee/bd00ee3b-43af-6b07-62a6-28c68373a8b5/AppIcon-1x_U007emarketing-85-220-0-9.png/292x0w.jpg",
                                      appTitle:
                                          "Happy Anniversary Greeting SMS",
                                      appUrl:
                                          "https://apps.apple.com/us/app/happy-anniversary-greeting-sms/id1435157874"),
                                  Divider(),
                                  AppStoreAppsItemWidget1(
                                      imageUrl:
                                          "https://is4-ssl.mzstatic.com/image/thumb/Purple91/v4/f0/84/d7/f084d764-79a8-f6d1-3778-1cb27fabb8bd/pr_source.png/292x0w.jpg",
                                      appTitle: "Egg Recipes 100+ Recipes",
                                      appUrl:
                                          "https://apps.apple.com/us/app/egg-recipes-100-recipes-collection-for-eggetarian/id1232736881"),
                                  Divider(),
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
    Key key,
    this.imageUrl,
    this.appUrl,
    this.appTitle,
  }) : super(key: key);

  final String imageUrl, appUrl, appTitle;

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
                imageUrl: imageUrl,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fadeOutDuration: const Duration(seconds: 1),
                fadeInDuration: const Duration(seconds: 3),
              ),
            ),
          ),
          Text(
            appTitle,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      onTap: () {
        launch(appUrl);
      },
    );
  }
}
