import 'package:flutter/material.dart';

class Custombuttom extends StatelessWidget {
  const Custombuttom({
    super.key,
    required this.onpress,
    required this.label,
    this.alig = 60.0,
  });
  final Function() onpress;
  final String label;
  final double alig;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: alig),
        child: InkWell(
          splashColor: Colors.transparent.withOpacity(0),
          highlightColor: Colors.transparent.withOpacity(0),
          focusColor: Colors.transparent.withOpacity(0),
          onTap: onpress,
          child: Container(
              height: 40,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                  color: const Color(0xFF8E704F),
                  borderRadius: BorderRadius.circular(70)),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              width: MediaQuery.sizeOf(context).width,
              alignment: Alignment.center,
              child: Text(
                label,
                // softWrap: false,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(fontSize: 20, fontWeight: FontWeight.w500),
              )),
        ),
      ),
    );
  }
}
