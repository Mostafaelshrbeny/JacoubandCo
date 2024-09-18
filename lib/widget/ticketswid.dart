import 'package:chatjob/generated/locale_keys.g.dart';
import 'package:chatjob/screens/AdminScreens/Ticket.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TicketWidget extends StatelessWidget {
  const TicketWidget({
    super.key,
    required this.tiketInfo,
  });
  final Map tiketInfo;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => TicketScreen(
                    id: tiketInfo['id'],
                  ))),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color.fromRGBO(10, 36, 50, 1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TicketInfo(
              info: tiketInfo['id'].toString(),
              label: 'ID',
            ),
            TicketInfo(
              label: LocaleKeys.adminSupportName.tr(),
              info: tiketInfo['user']['name'],
            ),
            TicketInfo(
              label: LocaleKeys.adminSupportSubject.tr(),
              info: tiketInfo['subject'],
            ),
            TicketInfo(
              label: LocaleKeys.adminSupportStatus.tr(),
              info: tiketInfo['status'],
              infocolor: tiketInfo['status'] == 'open'
                  ? const Color(0xFF10AC4F)
                  : Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

class TicketInfo extends StatelessWidget {
  const TicketInfo({
    super.key,
    required this.label,
    required this.info,
    this.infocolor = const Color(0xFFF9F9F9),
  });
  final String label, info;
  final Color infocolor;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
              color: const Color(0xFFAECDF8),
              fontSize: 18,
              fontWeight: FontWeight.w400),
        ),
        const Spacer(),
        Text(
          info,
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
              color: infocolor, fontSize: 16, fontWeight: FontWeight.w300),
        )
      ],
    );
  }
}
