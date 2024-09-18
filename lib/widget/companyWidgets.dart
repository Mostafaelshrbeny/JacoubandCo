import 'package:chatjob/cubits/NetworkCubits/company/company_apis_cubit.dart';
import 'package:chatjob/cubits/NetworkCubits/company/company_apis_state.dart';
import 'package:chatjob/generated/locale_keys.g.dart';
import 'package:chatjob/models/company_model.dart';
import 'package:chatjob/screens/AdminScreens/EditCompany.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditCompany extends StatelessWidget {
  const EditCompany({
    super.key,
    required this.company,
    required this.index,
  });

  final CompanyModel company;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Builder(builder: (cx) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: InkWell(
                onTap: () => showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(70)),
                    context: cx,
                    builder: (context) {
                      return Bottomdelete(
                        companyname: company.name!,
                        id: company.id!,
                        cx: cx,
                      );
                    }),
                child: Container(
                    height: 50 * 0.8,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF8E704F)),
                        color: const Color(0xFF02141F),
                        borderRadius: BorderRadius.circular(70)),
                    width: MediaQuery.sizeOf(context).width - 20,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: Text(
                        LocaleKeys.delete.tr(),
                        softWrap: false,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                                color: const Color(0xFF8E704F),
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                      ),
                    )),
              ),
            );
          }),
        ),
        const SizedBox(width: 22),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: InkWell(
              borderRadius: BorderRadius.circular(70),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => EditCompanyScreen(
                            info: company,
                            index: index,
                          ))),
              child: Container(
                  height: 50 * 0.8,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(142, 112, 79, 1),
                      borderRadius: BorderRadius.circular(70)),
                  width: MediaQuery.sizeOf(context).width - 20,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                    child: Text(
                      LocaleKeys.edit.tr(),
                      softWrap: false,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          color: const Color(0xFFF9F9F9),
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  )),
            ),
          ),
        )
      ],
    );
  }
}

class Bottomdelete extends StatelessWidget {
  const Bottomdelete({
    super.key,
    required this.cx,
    required this.companyname,
    required this.id,
  });
  final BuildContext cx;
  final String companyname;
  final int id;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompanyApisCubit(),
      child: BlocConsumer<CompanyApisCubit, CompanyApisState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            height: MediaQuery.of(context).size.height / 1.5,
            //padding: const EdgeInsets.only(bottom: 50),
            decoration: BoxDecoration(
                color: const Color(0xFF02141F),
                borderRadius: BorderRadius.circular(16)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: IconButton(
                          alignment: Alignment.topLeft,
                          onPressed: () {
                            Navigator.pop(cx);
                          },
                          icon: const Icon(Icons.close)),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(50),
                  margin: const EdgeInsets.all(15),
                  height: 120,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/done.png'))),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        LocaleKeys.deleteCoDelAsk.tr(),
                        softWrap: true,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFFF9F9F9)),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "$companyname" "?",
                        softWrap: true,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFF9F9F9)),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Row(
                    children: [
                      Expanded(
                        child: Builder(builder: (cz) {
                          return InkWell(
                            onTap: () {
                              Navigator.pop(cx);
                            },
                            child: Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xFF8E704F)),
                                    color: const Color(0xFF02141F),
                                    borderRadius: BorderRadius.circular(70)),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Center(
                                  child: Text(
                                    'NO',
                                    softWrap: false,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .copyWith(
                                            color: const Color(0xFF8E704F),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                  ),
                                )),
                          );
                        }),
                      ),
                      const SizedBox(width: 22),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            BlocProvider.of<CompanyApisCubit>(context)
                                .deletecompany(id, context);
                          },
                          child: Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(142, 112, 79, 1),
                                  borderRadius: BorderRadius.circular(70)),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                child: Text(
                                  'YES',
                                  softWrap: false,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayLarge!
                                      .copyWith(
                                          color: const Color(0xFFF9F9F9),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
