import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:janadem/constants/assets.dart';
import 'package:janadem/screens/user/home/district_screen.dart';

class AllDistrictsScreen extends StatefulWidget {
  const AllDistrictsScreen({super.key});

  @override
  State<AllDistrictsScreen> createState() => _AllDistrictsScreenState();
}

class _AllDistrictsScreenState extends State<AllDistrictsScreen> {

  List<Map> districtsList = [
    {
      'image': 'medeu.png',
      'title': 'Medeu District',
      'score': 4.8,
      'description': 'The vast Medeu District is home to the Central State Museum, which recounts the country’s history, and the distinctive multicolored domes of baroque-style Zenkov’s Cathedral.',
      'population': '209,836+',
      'review': '330+'
    },
    {
      'image': 'bostandyk.png',
      'title': 'Bostandyk District',
      'score': 4.5,
      'description': 'The Bostandyq District (Kazakh: Бостандық ауданы) is an administrative subdivision of the city of Almaty. The district has the youngest demographics with more than 71,000 students residing in it.',
      'population': '209,500+',
      'review': '330+'
    },
    {
      'image': 'auezov.png',
      'title': 'Auezov District',
      'score': 4.3,
      'description': 'Auezov District (Kazakh: Әуезов ауданы) is an administrative subdivision of the city of Almaty.[1][2] It was established on 10 March 1972.',
      'population': '203,569+',
      'review': '330+'
    },
    {
      'image': 'turksib.png',
      'title': 'Turksib District',
      'score': 4.2,
      'description': 'The Turksib District (Kazakh: Түрксіб ауданы) is an administrative subdivision of the city of Almaty. The district is an industrial area, with an air and railway gateway to the city.',
      'population': '200,000+',
      'review': '330+'
    },
    {
      'image': 'alatau.png',
      'title': 'Alatau District',
      'score': 4.0,
      'description': 'Alatau (Kazakh: Алатау, Alatau; from Turkic languages: "motley mountain") is a settlement 25 km. off Almaty, south-eastern Kazakhstan. Administratively, it is included in the Medeu District of Almaty and informally recognized as a microdistrict of Almaty.',
      'population': '180,000+',
      'review': '330+'
    },
    {
      'image': 'zhetisu.png',
      'title': 'Zhetysu District',
      'score': 3.8,
      'description': 'Zhetysu district is a district of Almaty, Kazakhstan.',
      'population': '150,836+',
      'review': '330+'
    },
    {
      'image': 'almaly.png',
      'title': 'Almaly District',
      'score': 3.6,
      'description': 'Leafy Almaly District is home to pedestrianized Arbat street, where local artists show their work. Cafes and pizzerias pack the surrounding area, and there are fast-food restaurants as well as mainstream fashion stores at MEGA Park mall. ',
      'population': '209,000+',
      'review': '330+'
    },
    {
      'image': 'nauryzbay.png',
      'title': 'Nauryzbay District',
      'score': 3.5,
      'description': 'Nauryzbay district is a district of Almaty, Kazakhstan.',
      'population': '220,000+',
      'review': '330+'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Districts efficiency',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 19,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: ListView.builder(
              itemCount: districtsList.length,
              itemBuilder: (context, index){
                final district = districtsList[index];
                return GestureDetector(
                  onTap: (){
                    Get.to(
                            () => DistrictInfoScreen(districtData: district)
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          margin: const EdgeInsets.only(right: 5),
                          child: Text(
                            district['title'],
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.black
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 5,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xffE3E5E5),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: LinearProgressIndicator(
                                value: district['score'] / 5,
                                backgroundColor: const Color(0xffF2F4F5),
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  Color(0xff056C5F),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: SvgPicture.asset('${Assets().icn}storm.svg'),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Text(
                            district['score'].toString(),
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: const Color(0xff101010)
                            ),
                          ),
                        ),



                      ],
                    ),
                  ),
                );
              }
          ),
        ),
      ),
    );
  }
}
