import 'package:chatjob/cubits/NetworkCubits/profile/profile_cubit.dart';
import 'package:chatjob/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DeleteUserWidget extends StatelessWidget {
  const DeleteUserWidget({
    super.key,
    required this.id,
  });
  final int id;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 32),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color.fromRGBO(10, 36, 50, 1)),
      child: InkWell(
        onTap: () async {
          await Profilecubit.get(context).deleteUser(id: id);
        },
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(
                Icons.cancel,
                color: Color(0xFFF80909),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: Text(
                LocaleKeys.deleteUser.tr(),
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFFF80909)),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class Editinfowidget extends StatelessWidget {
  const Editinfowidget({
    super.key,
    required this.infolabel,
    required this.initialval,
    this.max = 1,
    required this.onchange,
    this.valid,
  });
  final String infolabel, initialval;
  final int max;
  final Function(String) onchange;
  final String? Function(String?)? valid;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(
          top: 0,
          left: 22,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color.fromRGBO(10, 36, 50, 1)),
        child: TextFormField(
          validator: valid,
          onChanged: onchange,
          maxLines: max,
          initialValue: initialval,
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: const Color(0xFFCFCECA)),
          decoration: InputDecoration(
            label: Text(
              infolabel,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: const Color(0xFF2F4A6F),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            border: InputBorder.none,
          ),
        ));
  }
}
