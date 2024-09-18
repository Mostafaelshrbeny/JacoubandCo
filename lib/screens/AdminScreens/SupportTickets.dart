import 'package:chatjob/generated/locale_keys.g.dart';
import 'package:chatjob/method/network.dart';

import 'package:chatjob/widget/ticketswid.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SupportTicketsScreen extends StatefulWidget {
  const SupportTicketsScreen({super.key});

  @override
  State<SupportTicketsScreen> createState() => _SupportTicketsScreenState();
}

class _SupportTicketsScreenState extends State<SupportTicketsScreen> {
  @override
  void initState() {
    getmess();
    super.initState();
  }

  List<dynamic>? x;
  List<dynamic>? tickets;
  getmess() async {
    x = await getmessages();
    setState(() {
      tickets = x;
      print(tickets![0]['id'].toString());
    });
    print(x);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        ),
        title: Text(LocaleKeys.supportTickets.tr()),
        centerTitle: true,
      ),
      body: Builder(builder: (context) {
        return tickets == null
            ? Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 7),
                child: Center(
                    child: Lottie.asset('assets/images/JP LOADING.json',
                        height: MediaQuery.of(context).size.width / 1.5,
                        width: MediaQuery.of(context).size.width / 1.5)),
              )
            : tickets!.isEmpty
                ? Center(
                    child: Text('No Tickets Yet...',
                        style: Theme.of(context).textTheme.displayLarge!))
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    itemBuilder: (context, index) {
                      return TicketWidget(
                        tiketInfo: tickets![index],
                      );
                    },
                    itemCount: tickets!.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      height: 12,
                    ),
                  );
      }),
    );
  }
}
