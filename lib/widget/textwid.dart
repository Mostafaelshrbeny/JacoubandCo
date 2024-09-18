import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Customtextfield extends StatelessWidget {
  const Customtextfield({
    super.key,
    required this.hint,
    required this.controller,
    required this.onchange,
    required this.obscure,
    this.ic,
    this.lines = 1,
    this.nextOrdone,
    required this.validator,
    this.typeinput,
    this.suficon,
  });
  final String hint;
  final TextEditingController controller;
  final Function(String) onchange;
  final String? Function(String?)? validator;
  final bool obscure;
  final Widget? ic;
  final TextInputAction? nextOrdone;
  final TextInputType? typeinput;
  final Widget? suficon;

  final int lines;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscure,
      maxLines: lines,
      onChanged: onchange,
      textInputAction: nextOrdone,
      keyboardType: typeinput,
      decoration: InputDecoration(
          suffixIcon: suficon,
          filled: true,
          contentPadding: const EdgeInsets.all(8),
          prefixIcon: ic,
          fillColor: const Color.fromRGBO(10, 36, 50, 1),
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
              color: const Color.fromARGB(255, 20, 80, 112),
              fontSize: 16,
              fontWeight: FontWeight.w300),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(width: 0, style: BorderStyle.none))),
    );
  }
}

class Textstack extends StatelessWidget {
  const Textstack({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 370,
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Stack(
        children: [
          const Align(
              alignment: Alignment(-1.08, -0.8),
              child:
                  Image(image: AssetImage('assets/images/Text Element.png'))),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFFF9F9F9),
              fontSize: 36,
              fontFamily: 'spinwerad',
              fontWeight: FontWeight.w700,
              letterSpacing: -0.36,
            ),
          ),
        ],
      ),
    );
  }
}

class Containtext extends StatelessWidget {
  const Containtext({
    super.key,
    required this.leadingtext,
    required this.trailingtext,
    required this.leadingicon,
    //required this.height,
    this.onpress,
    this.desc,
    required this.color,
  });
  final String leadingtext, trailingtext;
  final Widget leadingicon;
  final String? desc;
  final Color color;
  // final double height;
  final Function()? onpress;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onpress,
        child: Container(
            // elevation: 5,
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color.fromRGBO(10, 36, 50, 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 18,
                  height: MediaQuery.of(context).size.height / 10.5,
                  decoration: BoxDecoration(
                      color: color,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomLeft: Radius.circular(16))),
                ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: leadingicon,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: Text(
                          leadingtext,
                          maxLines: 1,
                          softWrap: true,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                  fontSize: 16,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      const Color.fromRGBO(249, 249, 249, 1)),
                        ),
                      ),
                      desc == null || desc!.isEmpty
                          ? const SizedBox()
                          : Text(
                              desc!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      color: const Color.fromRGBO(
                                          207, 206, 202, 1)),
                            ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 7, right: 14),
                  child: Text(
                    trailingtext,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromRGBO(249, 249, 249, 1)),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
