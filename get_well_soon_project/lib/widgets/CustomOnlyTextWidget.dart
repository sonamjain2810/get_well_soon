import 'package:flutter/material.dart';
import 'package:get_well_soon/utils/SizeConfig.dart';

class CustomOnlyTextWidget extends StatelessWidget {
  const CustomOnlyTextWidget({
    Key key,
    @required this.size,
    @required this.color,
    @required this.text, 
    this.ontap,
  }) : super(key: key);

  final Size size;
  final Color color;
  final String text;
final Function ontap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: size.height * 0.10,
        width: size.width * 0.27,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(SizeConfig.height(10)),
        ),
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.width(4)),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      onTap: ontap,
    );
  }
}
