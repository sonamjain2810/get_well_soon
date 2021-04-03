import 'package:flutter/material.dart';
import 'package:get_well_soon/utils/SizeConfig.dart';

class CustomTextOnlyWidget extends StatelessWidget {
  const CustomTextOnlyWidget({
    Key key,
    @required this.size, @required this.color, @required this.text,
  }) : super(key: key);

  final Size size;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.41,
      width: size.width * 0.46,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(SizeConfig.height(11)),
      ),
      child: Container(
        height: size.height * 0.39,
        width: size.width * 0.43,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius:
              BorderRadius.circular(SizeConfig.height(10)),
        ),
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.width(2)),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
