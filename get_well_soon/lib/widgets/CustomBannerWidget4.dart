import 'package:flutter/material.dart';
import '/utils/SizeConfig.dart';

class CustomBannerWidget4 extends StatelessWidget {
  const CustomBannerWidget4({
    Key? key,
    this.imagePath,
    this.headingText,
    this.bodyText,
  }) : super(key: key);

  final String? imagePath, headingText, bodyText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.46,
      child: Column(
        children: <Widget>[
          Image.network(imagePath!),
          SizedBox(height: SizeConfig.height(8)),
          Text(
            headingText!,
            textAlign: TextAlign.left,
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: SizeConfig.height(3)),
          Text(bodyText!,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.subtitle2),
        ],
      ),
    );
  }
}
