import 'package:flutter/material.dart';

class AdditionalRow extends StatelessWidget {
  const AdditionalRow(
      {super.key,
      required this.label,
      required this.icon,
      this.ontap,
      this.icon2 = const Icon(
        Icons.arrow_forward_ios,
        size: 18,
        color: Color(0xFFAECDF8),
      ),
      required this.x,
      this.y = 0});
  final String label;
  final Widget? icon;
  final Widget icon2;
  final Function()? ontap;
  final double x;
  final double y;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: icon,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: Text(
              label,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFFAECEF8)),
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: x, horizontal: y),
            child: icon2,
          )
        ],
      ),
    );
  }
}

class BottomSheetOptions extends StatelessWidget {
  const BottomSheetOptions({
    super.key,
    required this.cx,
    required this.label,
    required this.option1,
    required this.option2,
    this.option3,
    required this.seleted1,
    this.onchange1,
    this.onchange2,
    this.onchange3,
  });
  final BuildContext cx;
  final String label, option1, option2;
  final String? option3;
  final int? seleted1;
  final Function()? onchange1, onchange2, onchange3;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: Stack(
            children: [
              Positioned(
                  top: 8,
                  left: 8,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(cx);
                      },
                      icon: const Icon(Icons.close))),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFFF9F9F9)),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Container(
          // height: 125,
          // width: MediaQuery.of(context).size.width - 30,
          padding:
              const EdgeInsets.only(top: 22, bottom: 22, left: 22, right: 12),
          margin: const EdgeInsets.only(bottom: 100, left: 22, right: 22),
          decoration: BoxDecoration(
              color: const Color(0xFF0A2432),
              borderRadius: BorderRadius.circular(16)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: onchange1,
                child: Row(
                  children: [
                    Text(
                      option1,
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          color: seleted1 == 1
                              ? const Color(0xFF8E704F)
                              : const Color(0xFFAECEF8),
                          fontSize: 22,
                          fontWeight: FontWeight.w400),
                    ),
                    const Spacer(),
                    seleted1 == 1
                        ? const Icon(
                            Icons.done,
                            color: Color(0xFF8E704F),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              InkWell(
                onTap: onchange2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      option2,
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          color: seleted1 == 2
                              ? const Color(0xFF8E704F)
                              : const Color(0xFFAECEF8),
                          fontSize: 22,
                          fontWeight: FontWeight.w400),
                    ),
                    const Spacer(),
                    seleted1 == 2
                        ? const Icon(
                            Icons.done,
                            color: Color(0xFF8E704F),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              option3 == null
                  ? const SizedBox(height: 0)
                  : const Divider(
                      thickness: 1,
                    ),
              option3 == null
                  ? const SizedBox(height: 0)
                  : InkWell(
                      onTap: onchange3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            option3!,
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                  // color: const Color(0xFF8E704F),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w400,
                                  color: seleted1 == 3
                                      ? const Color(0xFF8E704F)
                                      : const Color(0xFFAECEF8),
                                ),
                          ),
                          const Spacer(),
                          seleted1 == 3
                              ? const Icon(
                                  Icons.done,
                                  color: Color(0xFF8E704F),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
