import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'utils/SizeConfig.dart';
import 'AboutUs.dart';
import 'HomePage.dart';
import 'ImagesList.dart';
import 'MessagesList.dart';

class MyDrawer extends StatefulWidget {
  static String AppName = "Get Well Soon";

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String shareAppText = "Hey I have found this amazing app for you. "
      "Have a look on "
      "${MyDrawer.AppName}"
      " Url: ${AppUrl()}";

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).colorScheme.primaryVariant,
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryVariant,
                ),
                currentAccountPicture: CircleAvatar(
                  radius: 19 * SizeConfig.widthMultiplier,
                  backgroundImage: NetworkImage(
                      'https://pbs.twimg.com/profile_images/1158115409993691138/wABb5ZLe_400x400.jpg'),
                  backgroundColor: Theme.of(context).primaryIconTheme.color,
                ),
                accountName: Text("GJOneStudio"),
                accountEmail: Text("gj1studio@gmail.com")),
            Container(
              color: Theme.of(context).colorScheme.primary,
              child: Column(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.home,
                          color: Theme.of(context).primaryIconTheme.color),
                      title: Text("Home Page"),
                      trailing: Icon(Icons.arrow_forward_ios,
                          color: Theme.of(context).primaryIconTheme.color),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => HomePage()));
                      }),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.format_quote,
                        color: Theme.of(context).primaryIconTheme.color),
                    title: Text("Quotes"),
                    trailing: Icon(Icons.arrow_forward_ios,
                        color: Theme.of(context).primaryIconTheme.color),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => MessagesList()));
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.image,
                        color: Theme.of(context).primaryIconTheme.color),
                    title: Text("Images"),
                    trailing: Icon(Icons.arrow_forward_ios,
                        color: Theme.of(context).primaryIconTheme.color),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => ImagesList()));
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.info,
                        color: Theme.of(context).primaryIconTheme.color),
                    title: Text("About Developer"),
                    trailing: Icon(Icons.arrow_forward_ios,
                        color: Theme.of(context).primaryIconTheme.color),
                    onTap: () {
                      //interstitialTag = "about";
                      Navigator.of(context).pop();

                      //_interstitialAd.isLoaded() != null
                      //  ? _interstitialAd?.show()
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => AboutUs()));
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.feedback,
                        color: Theme.of(context).primaryIconTheme.color),
                    title: Text("Submit Feedback"),
                    trailing: Icon(Icons.arrow_forward_ios,
                        color: Theme.of(context).primaryIconTheme.color),
                    onTap: () async {
                      Navigator.of(context).pop();
                      print("Feedback Button Clicked");
                      const url = 'mailto:sonamjain2810@yahoo.com'
                          '?subject=feedback%20from%20Get%20Well%20Soon%20Messages%20App&body=Your%20Apps%20Rocks!!';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.more,
                        color: Theme.of(context).primaryIconTheme.color),
                    title: Text("Other Apps"),
                    trailing: Icon(Icons.arrow_forward_ios,
                        color: Theme.of(context).primaryIconTheme.color),
                    onTap: () {
                      Navigator.of(context).pop();
                      if (Platform.isAndroid) {
                        // Android-specific code
                        print("More Button Clicked");
                        launch(
                            "https://play.google.com/store/apps/developer?id=Festival+Messages+SMS");
                      } else if (Platform.isIOS) {
                        // iOS-specific code
                        print("More Button Clicked");
                        launch(
                            "https://apps.apple.com/us/developer/sonam-jain/id1440118616");

                        
                      }
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.rate_review,
                        color: Theme.of(context).primaryIconTheme.color),
                    title: Text("Rate This App"),
                    trailing: Icon(Icons.arrow_forward_ios,
                        color: Theme.of(context).primaryIconTheme.color),
                    onTap: () {
                      Navigator.of(context).pop();
                      launch(AppUrl());
                    },
                  ),
                  Divider(),
                  ListTile(
                      leading: Icon(Icons.share,
                          color: Theme.of(context).primaryIconTheme.color),
                      title: Text("Share App"),
                      trailing: Icon(Icons.arrow_forward_ios,
                          color: Theme.of(context).primaryIconTheme.color),
                      onTap: () {
                        print("Share Button Clicked");
                        Navigator.of(context).pop();
                        final RenderBox box = context.findRenderObject();
                        Share.share(
                          shareAppText,
                          sharePositionOrigin:
                              box.localToGlobal(Offset.zero) & box.size,
                        );
                      }),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.close,
                        color: Theme.of(context).primaryIconTheme.color),
                    title: Text("Close"),
                    trailing: Icon(Icons.arrow_forward_ios,
                        color: Theme.of(context).primaryIconTheme.color),
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String AppUrl() {
  String url;
  if (Platform.isAndroid) {
    print("Android Platform");
    url =
        "https://play.google.com/store/apps/details?id=com.rrj_psj.good_morning_sms";
  } else if (Platform.isIOS) {
    print("iOS Platform");
    url = "https://apps.apple.com/us/app/-/id1526953576";
  }
  return url;
}


/*
"Good Morning Images & Messages to Wish & Greet GM"
"https://apps.apple.com/us/app/good-morning-images-messages-to-wish-greet-gm/id1232993917"
"https://is1-ssl.mzstatic.com/image/thumb/Purple117/v4/8f/e7/b5/8fe7b5bc-03eb-808c-2b9e-fc2c12112a45/mzl.jivuavtz.png/292x0w.jpg"


"Eid Al Adha Mubarak Gif Wishes"
"https://apps.apple.com/us/app/eid-al-adha-mubarak-gif-wishes/id1525210628"
"https://is3-ssl.mzstatic.com/image/thumb/Purple124/v4/79/2b/44/792b44ed-3845-bf39-78e9-d94e5906b016/AppIcon-1x_U007emarketing-0-7-0-0-85-220.png/292x0w.jpg"

"Happy Anniversary Greeting SMS"
"https://apps.apple.com/us/app/happy-anniversary-greeting-sms/id1435157874" 
"https://is4-ssl.mzstatic.com/image/thumb/Purple128/v4/bd/00/ee/bd00ee3b-43af-6b07-62a6-28c68373a8b5/AppIcon-1x_U007emarketing-85-220-0-9.png/292x0w.jpg"

"Egg Recipes 100+ Recipes Collection for Eggetarian"
"https://apps.apple.com/us/app/egg-recipes-100-recipes-collection-for-eggetarian/id1232736881"
"https://is4-ssl.mzstatic.com/image/thumb/Purple91/v4/f0/84/d7/f084d764-79a8-f6d1-3778-1cb27fabb8bd/pr_source.png/292x0w.jpg"

"Rakshabandhan Images Greetings"
"https://apps.apple.com/us/app/rakshabandhan-images-greetings/id1523619788"
"https://is1-ssl.mzstatic.com/image/thumb/Purple114/v4/0f/d6/f4/0fd6f410-9664-94a5-123f-38d787bf28c6/AppIcon-1x_U007emarketing-0-7-0-0-85-220.png/292x0w.jpg"


"English Hindi Language Diction"
"https://apps.apple.com/us/app/english-hindi-language-diction/id1441243874"
"https://is4-ssl.mzstatic.com/image/thumb/Purple128/v4/50/ad/82/50ad82d9-0d82-5007-fcdd-cc47c439bfd0/AppIcon-0-1x_U007emarketing-0-85-220-10.png/292x0w.jpg"

"English Speaking Course - Learn Grammar Vocabulary"
"https://apps.apple.com/us/app/english-speaking-course-learn-grammar-vocabulary/id1233093288"
"https://is2-ssl.mzstatic.com/image/thumb/Purple127/v4/5f/7c/45/5f7c45c7-fb75-ea39-feaa-a698b0e4b09e/pr_source.jpg/292x0w.jpg"

"Weight Loss My Diet Coach Tips"
"https://apps.apple.com/us/app/weight-loss-my-diet-coach-tips/id1448343218"
"https://is2-ssl.mzstatic.com/image/thumb/Purple124/v4/e9/96/64/e99664d3-1083-5fac-6a0c-61718ee209fd/AppIcon-0-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-7.png/292x0w.jpg"

"Bangladesh Passport Visa Biman"
"https://apps.apple.com/us/app/bangladesh-passport-visa-biman/id1443074171"
"https://is1-ssl.mzstatic.com/image/thumb/Purple118/v4/79/1e/61/791e61de-500c-6c97-3947-8abbc6b887e3/AppIcon-0-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-7.png/292x0w.jpg"

"Complete Spoken English Course"
"https://apps.apple.com/us/app/complete-spoken-english-course/id1440118617"
"https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/dd/34/c3/dd34c3e8-5c9f-51aa-a3eb-3a203f5fd49b/AppIcon-0-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-10.png/292x0w.jpg"

"Celebrate Happy New Year 2019",
"https://apps.apple.com/us/app/celebrate-happy-new-year-2019/id1447735210"
"https://is3-ssl.mzstatic.com/image/thumb/Purple118/v4/17/f5/0c/17f50c4d-431b-72c6-b9f4-d1706da59394/AppIcon-0-1x_U007emarketing-0-0-85-220-7.png/292x0w.jpg"

"Astrology Horoscope Lal Kitab"
"https://apps.apple.com/us/app/astrology-horoscope-lal-kitab/id1448343526"
"https://is4-ssl.mzstatic.com/image/thumb/Purple114/v4/1a/58/a4/1a58a480-a0ae-1940-2cf3-38524430f66b/AppIcon-0-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-7.png/292x0w.jpg" 

"Birthday Status Wishes Quotes"
"https://apps.apple.com/us/app/birthday-status-wishes-quotes/id1522542709"
"https://is4-ssl.mzstatic.com/image/thumb/Purple114/v4/44/e0/fd/44e0fdb5-667b-5468-7b2f-53638cba539e/AppIcon-1x_U007emarketing-0-7-0-0-85-220.png/292x0w.jpg"


*/

