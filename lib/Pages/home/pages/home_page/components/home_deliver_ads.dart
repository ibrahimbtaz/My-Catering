import 'package:flutter/material.dart';
import 'package:mycatering/Pages/home/pages/home_page/home_page.dart';
import 'package:mycatering/models/constants.dart';

class HomeDeliverAds extends StatelessWidget {
  const HomeDeliverAds({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 20),
          height: size!.height * .167,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xff425f57),
            borderRadius: BorderRadius.circular(18),
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: ads1,
            ),
          ),
          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Text(
          //       "Gratis Ongkir",
          //       style: Theme.of(context).textTheme.headline1,
          //     ),
          //     Text(
          //       " Hingga Tanggal 27 November",
          //       style: Theme.of(context).textTheme.headline1!.copyWith(
          //         fontSize: 11,
          //       ),
          //     ),
          //   ],
          // ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.only(left: 20),
          height: size!.height * .167,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xff425f57),
            borderRadius: BorderRadius.circular(18),
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: ads2,
            ),
          ),
        ),
      ],
    );
  }
}
