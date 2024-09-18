import 'package:flutter/material.dart';

class Companyinfo extends StatelessWidget {
  const Companyinfo({
    super.key,
    required this.imagelink,
    required this.label,
    required this.onprees,
  });
  final String imagelink, label;
  final Function() onprees;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onprees,
      child: Row(children: [
        Container(
          margin: const EdgeInsets.only(right: 12),
          width: 24,
          height: 24,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          child: Image(
            image: AssetImage(imagelink),
            fit: BoxFit.cover,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: const Color(0xFFAECDF8)),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Color(0xFFAECDF8),
          ),
          onPressed: onprees,
        )
      ]),
    );
  }
}
