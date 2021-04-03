import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:image_picker_saver/image_picker_saver.dart';
import 'package:http/http.dart' as http;
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'utils/SizeConfig.dart';
import 'NativeAdContainer.dart';

/*
how to pass data into another screen watch this video
https://www.youtube.com/watch?v=d5PpeNb-dOY
 */

class ImageDetailPage extends StatefulWidget {
  String url;
  int index;
  ImageDetailPage(this.url, this.index);
  @override
  _ImageDetailPageState createState() => _ImageDetailPageState(url, index);
}

class _ImageDetailPageState extends State<ImageDetailPage> {
  String url;
  int index;

  _ImageDetailPageState(this.url, this.index);

  static final facebookAppEvents = FacebookAppEvents();

// Native Ad Open
  static String _adUnitID = NativeAd.testAdUnitId;

  final _nativeAdController = NativeAdmobController();
  double _height = 0;

  StreamSubscription _subscription;

  var filePath;
  var BASE64_IMAGE;

//Native Ad Close

  @override
  void initState() {
    super.initState();

    //Native Ad
    _subscription = _nativeAdController.stateChanged.listen(_onStateChanged);
    //
  }

  @override
  void dispose() {
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

  bool visible = false;

  loadProgress() {
    if (visible == true) {
      setState(() {
        visible = false;
      });
    } else {
      setState(() {
        visible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Image No. ${index + 1}",
        style: Theme.of(context).appBarTheme.textTheme.headline1,
      )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: new EdgeInsets.symmetric(
                vertical: 1.93 * SizeConfig.widthMultiplier,
                horizontal: 1.93 * SizeConfig.widthMultiplier),
            child: new Card(
              child: new Container(
                  padding:
                      new EdgeInsets.all(1.93 * SizeConfig.widthMultiplier),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CachedNetworkImage(
                        imageUrl: url,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fadeOutDuration: const Duration(seconds: 1),
                        fadeInDuration: const Duration(seconds: 3),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.all(1.93 * SizeConfig.widthMultiplier),
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Visibility(
                                maintainSize: true,
                                maintainAnimation: true,
                                maintainState: true,
                                visible: visible,
                                child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                  children: [
                                    
                                      Text("We are downloading your image to share.. \nBe Paitence Thanks!!", style: Theme.of(context).textTheme.bodyText1,),
                                        CircularProgressIndicator(),
                                  ],
                                )),
                            RaisedButton(
                              
                              onPressed:() async {
                                loadProgress();
                                await shareJPGImageFromUrl();
                                loadProgress();
                              }, 
                              
                              child: Text('Share'),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      NativeAdContainer(
                          height: _height,
                          adUnitID: _adUnitID,
                          nativeAdController: _nativeAdController),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> shareJPGImageFromUrl() async {
    try {
      facebookAppEvents.logEvent(
        name: "JPG Share",
        parameters: {
          'jpg_image_url': '$url',
        },
      );
      
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      await Share.file('Share JPG Image', 'share_jpg.jpg', bytes, 'image/jpg');
     
      
    } catch (e) {
      print('error: $e');
      
    }
    
  }

  void onImageDowloadButtonPressed() async {
    var response = await http.get(url);
    filePath = await ImagePickerSaver.saveFile(fileData: response.bodyBytes);
  }

  void onImageShareButtonPressed() async {
    var response = await http.get(url);
    filePath = await ImagePickerSaver.saveFile(fileData: response.bodyBytes);
    print(filePath);

    BASE64_IMAGE = filePath;

    final ByteData bytes = await rootBundle.load(BASE64_IMAGE);
    //await Share.file('test.png', bytes, 'my image title');
  }
}
