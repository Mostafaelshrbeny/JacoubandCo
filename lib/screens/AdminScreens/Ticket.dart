import 'package:chatjob/cubits/NetworkCubits/SupportMessage/support_message_cubit.dart';
import 'package:chatjob/cubits/NetworkCubits/SupportMessage/support_message_state.dart';
import 'package:chatjob/generated/locale_keys.g.dart';
import 'package:chatjob/method/Supportmessage.dart';
import 'package:chatjob/screens/AdminScreens/SupportTickets.dart';
import 'package:chatjob/widget/ticketswid.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({super.key, required this.id});
  final int id;

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  @override
  void initState() {
    getmessage(widget.id);
    super.initState();
  }

  Map<String, dynamic>? x, message;
  getmessage(int id) async {
    x = await oneSupMessage(id: id);
    setState(() {
      message = x;
      //print(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => const SupportTicketsScreen()));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(10),
            child: IconButton(
                onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const SupportTicketsScreen())),
                icon: const Icon(Icons.arrow_back_ios_new_rounded)),
          ),
          title: Text(LocaleKeys.adminSupportTicket.tr()),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: message == null
              ? Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 7),
                  child: Center(
                      child: Lottie.asset('assets/images/JP LOADING.json',
                          height: MediaQuery.of(context).size.width / 1.5,
                          width: MediaQuery.of(context).size.width / 1.5)),
                )
              : Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: const Color.fromRGBO(10, 36, 50, 1)),
                      child: Column(
                        children: [
                          TicketInfo(
                              label: 'ID', info: message!['id'].toString()),
                          TicketInfo(
                              label: LocaleKeys.adminSupportName.tr(),
                              info: message!['user']['name']),
                          TicketInfo(
                              label: LocaleKeys.adminSupportSubject.tr(),
                              info: message!['subject']),
                          TicketInfo(
                            label: LocaleKeys.adminSupportStatus.tr(),
                            info: message!['status'],
                            infocolor: message!['status'] == 'open'
                                ? const Color(0xFF10AC4F)
                                : Colors.red,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      constraints: const BoxConstraints(
                          minHeight: 100, minWidth: double.infinity),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: const Color.fromRGBO(10, 36, 50, 1)),
                      child: Text(
                        message!['body'],
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: const Color(0xFFF9F9F9)),
                      ),
                    ),
                    const Spacer(),
                    message!['status'] == 'open'
                        ? BlocProvider(
                            create: (context) => SupportMessageCubit(),
                            child: BlocConsumer<SupportMessageCubit,
                                SupportMessageState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                return InkWell(
                                  borderRadius: BorderRadius.circular(70),
                                  onTap: () async {
                                    await SupportMessageCubit.get(context)
                                        .editSupMessage(
                                            id: widget.id,
                                            open: false,
                                            context: context);
                                  },
                                  child: Container(
                                      height: 50,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              142, 112, 79, 1),
                                          borderRadius:
                                              BorderRadius.circular(70)),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Center(
                                        child: Text(
                                          LocaleKeys.adminSupportCloseTicket
                                              .tr(),
                                          softWrap: false,
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge!
                                              .copyWith(
                                                  color:
                                                      const Color(0xFFCFCECA),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                        ),
                                      )),
                                );
                              },
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 35,
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
