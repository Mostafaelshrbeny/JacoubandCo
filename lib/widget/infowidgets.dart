import 'package:flutter/material.dart';

class InfoRaw extends StatelessWidget {
  const InfoRaw({
    super.key,
    required this.dataname,
    required this.data,
  });
  final String dataname, data;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          dataname,
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: const Color(0xFFAECDF8)),
        ),
        const Spacer(),
        Container(
          constraints: const BoxConstraints(maxWidth: 180),
          child: Text(
            data,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xFFCFCECA)),
          ),
        )
      ],
    );
  }
}
