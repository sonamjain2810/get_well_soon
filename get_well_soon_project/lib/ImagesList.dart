import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/material.dart';
import 'utils/SizeConfig.dart';
import 'ImageDetailPage.dart';

class ImagesList extends StatefulWidget {
  @override
  _ImagesListState createState() => _ImagesListState();
}

class _ImagesListState extends State<ImagesList> {
  static final facebookAppEvents = FacebookAppEvents();

  var data = [
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k1.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k2.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k3.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k4.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k5.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k6.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k7.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k8.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k9.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k10.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k11.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k12.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k13.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k14.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k15.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k16.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k17.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k18.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k19.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k20.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k21.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k22.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k23.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k24.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k25.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k26.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k27.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k28.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k29.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k30.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k31.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k32.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k33.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k36.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k37.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k38.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k39.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k40.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k41.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k42.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k43.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k44.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k45.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k46.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k47.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k48.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k49.png",
    "http://www.andiwiniosapps.in/get_well_soon_message/get_well_soon_images/k50.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Images",
          style: Theme.of(context).appBarTheme.textTheme.headline1,
        ),
      ),
      body: SafeArea(
        child: data != null
            ? GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return GestureDetector(
                      child: Padding(
                        padding:
                            EdgeInsets.all(1.93 * SizeConfig.widthMultiplier),
                        child: ListTile(
                          title: CachedNetworkImage(
                            imageUrl: data[index],
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            fadeOutDuration: const Duration(seconds: 1),
                            fadeInDuration: const Duration(seconds: 3),
                          ),
                        ),
                      ),
                      onTap: () {
                        print("Click on Image Grid item $index");
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                    ImageDetailPage(data[index], index)));

                        facebookAppEvents.logEvent(
                          name: "Image List",
                          parameters: {
                            'clicked_on_jpeg_image_index': '$index',
                          },
                        );
                      });
                },
                itemCount: data.length,
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
