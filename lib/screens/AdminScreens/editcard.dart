import 'package:chatjob/cubits/EditCard/edit_card_cubit.dart';
import 'package:chatjob/generated/locale_keys.g.dart';
import 'package:chatjob/main.dart';
import 'package:chatjob/method/cashinbank.dart';
import 'package:chatjob/method/refresh.dart';
import 'package:chatjob/models/cashmodel.dart';
import 'package:chatjob/screens/mainscreen.dart';

import 'package:chatjob/screens/settings/settings.dart';
import 'package:chatjob/widget/publicwid.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditCardScreen extends StatefulWidget {
  const EditCardScreen({super.key, required this.cash, required this.show});
  final double cash;
  final bool show;
  @override
  State<EditCardScreen> createState() => _EditCardScreenState();
}

int? shownumC;
bool? shownC;
String? showopC;

class _EditCardScreenState extends State<EditCardScreen> {
  @override
  void initState() {
    getdata();
    super.initState();
  }

  getdata() async {
    y = await getCash();
    setState(() {
      newCash = y![0].value;
      shownC = y![1].value == "true";
      shownumC = shownC! ? 1 : 2;
      showopC = shownC! ? "Shown" : "Hide";
    });
  }

  String? newCash;
  List<CashModel>? y;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (_) => const Mainscreen(
                      inApp: true,
                    )),
            (route) => false);
        return true;
      },
      child: BlocProvider(
        create: (context) => EditCardCubit(),
        child: BlocConsumer<EditCardCubit, EditCardState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cub = EditCardCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                leading: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: IconButton(
                      onPressed: () => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const Mainscreen()),
                          (route) => false),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded)),
                ),
                title: Text(LocaleKeys.cashinBank.tr()),
                centerTitle: true,
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30 * 0.8),
                child: Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(bottom: 22, top: 22),
                        padding: const EdgeInsets.only(
                          top: 8,
                          left: 22,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: const Color.fromRGBO(10, 36, 50, 1)),
                        child: TextFormField(
                          onChanged: (value) => newCash = value,
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          initialValue: '${widget.cash}',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: const Color(0xFFCFCECA)),
                          decoration: InputDecoration(
                            prefix: Text(
                              'Kč |',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                      color: const Color(0xFFCFCECA)),
                            ),
                            label: Text(
                              LocaleKeys.cashinBank.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(
                                      color: const Color(0xFF2F4A6F),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                            ),
                            contentPadding: const EdgeInsets.only(bottom: 8),
                            border: InputBorder.none,
                          ),
                        )),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: const Color(0xFF0A2432),
                          borderRadius: BorderRadius.circular(16)),
                      child: Builder(builder: (cx) {
                        return InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                backgroundColor:
                                    const Color.fromARGB(255, 3, 27, 43),
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20))),
                                context: cx,
                                builder: (context) {
                                  return BottomSheetOptions(
                                    cx: cx,
                                    label: LocaleKeys.showCard.tr(),
                                    option1: LocaleKeys.show.tr(),
                                    option2: LocaleKeys.hide.tr(),
                                    seleted1: shownumC,
                                    onchange1: () async {
                                      cub.showCard(
                                          option: 1,
                                          cash: newCash == null
                                              ? widget.cash
                                              : double.parse(newCash!));
                                      // getdata();
                                      if (context.mounted) {
                                        Navigator.pop(context);
                                      }
                                    },
                                    onchange2: () async {
                                      await cub.showCard(
                                          option: 2,
                                          cash: newCash == null
                                              ? widget.cash
                                              : double.parse(newCash!));
                                      // getdata();
                                      if (context.mounted) {
                                        Navigator.pop(context);
                                      }
                                    },
                                  );
                                });
                          },
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 12),
                                height: 18,
                                width: 18,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/cardedit.png'))),
                              ),
                              Text(
                                LocaleKeys.showCard.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(
                                        fontSize: 18,
                                        color: const Color(0xFFAECEF8),
                                        fontWeight: FontWeight.w400),
                              ),
                              const Spacer(),
                              Text(
                                showopC ?? "",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                        color: const Color(0xFFCFCECA)),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50 * 0.8),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(70),
                        onTap: () async => {
                          await EditCardCubit.get(context).cashCard(
                              cash: double.parse(newCash!),
                              show: showopC == "Shown"),
                          if (context.mounted)
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const Mainscreen(
                                          inApp: true,
                                        )),
                                (route) => false)
                        },
                        child: Container(
                            height: 40,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(142, 112, 79, 1),
                                borderRadius: BorderRadius.circular(70)),
                            width: MediaQuery.sizeOf(context).width - 20,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Center(
                              child: Text(
                                LocaleKeys.saveChanges.tr(),
                                softWrap: false,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(
                                        color: const Color(0xFFCFCECA),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
