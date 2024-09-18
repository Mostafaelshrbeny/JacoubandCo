import 'package:flutter/material.dart';

class LinksScreen extends StatelessWidget {
  const LinksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 22),
          itemBuilder: (context, index) {
            return Container(
              height: 84,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xFF0A2432)),
              child: Row(
                children: [
                  const SizedBox(
                    width: 50,
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomLeft: Radius.circular(16)),
                      child: Image(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/Social Icon 1.png')),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 21),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "META ACADEMY NFT #02581",
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFFF9F9F9)),
                        ),
                        Text(
                          "opensea.io",
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: const Color(0xFFCFCECA)),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const SizedBox(
            height: 12,
          ),
          itemCount: 3,
        )),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 40),
          width: double.infinity,
          color: const Color(0xFF02141F),
          child: Text(
            "256 links",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: const Color(0xFFF9F9F9)),
          ),
        )
      ],
    );
  }
}
