import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:janadem/constants/assets.dart';
import 'package:janadem/screens/user/home/all_districts.dart';
import 'package:janadem/screens/user/home/district_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String firstName = '';
  String lastName = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (doc.exists) {
      setState(() {
        firstName = doc['name'] ?? '';
        lastName = doc['lastname'] ?? '';
        isLoading = false;
      });
    }
  }



  final List<Map<String, dynamic>> districtsList = [
    {
      'image': 'medeu.png',
      'title': 'Medeu District',
      'score': 4.8,
    },
    {
      'image': 'bostandyk.png',
      'title': 'Bostandyk District',
      'score': 4.5,
    },
    {
      'image': 'auezov.png',
      'title': 'Auezov District',
      'score': 4.3,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: const Color(0xff056C5F),
      ),
      body: SafeArea(
        child: ListView(
          children: [


            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              color: const Color(0xff056C5F),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage('assets/images/ava.jpg'),
                      ),
                      const SizedBox(width: 15),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome back!',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            isLoading ? 'Loading...' : '$lastName $firstName',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),

                ],
              ),
            ),

            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Your cases:',
                textAlign: TextAlign.start,
                style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff056C5F)
                ),
              ),
            ),

            SizedBox(
              height: 170,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                children: [
                  Container(
                    width: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color(0xffF6F5FB),
                    ),
                    margin: const EdgeInsets.only(right: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'In progress',
                            maxLines: 2,
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff61598B)
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '3',
                                style: GoogleFonts.inter(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff61598B)
                                ),
                              ),
                              SvgPicture.asset(
                                '${Assets().icn}in_progress.svg',
                                width: 30,
                                height: 30,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color(0xffFFF4F4),
                    ),
                    margin: const EdgeInsets.only(right: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'New problem',
                            maxLines: 2,
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xffFF3726)
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '1',
                                style: GoogleFonts.inter(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xffFF5648)
                                ),
                              ),
                              SvgPicture.asset(
                                '${Assets().icn}new_problem.svg',
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color(0xffF5F9F9),
                    ),
                    margin: const EdgeInsets.only(right: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Success problem',
                            maxLines: 2,
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff479696)
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '2',
                                style: GoogleFonts.inter(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff479696)
                                ),
                              ),
                              SvgPicture.asset(
                                '${Assets().icn}success_problem.svg',
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top 3',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff056C5F)
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.to(
                              () => const AllDistrictsScreen()
                      );
                    },
                    child: Text(
                      'See all',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.inter(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff056C5F),
                          decoration: TextDecoration.underline,
                          decorationColor: const Color(0xff056C5F)
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 270,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  itemCount: districtsList.length,
                  itemBuilder: (context, index){
                    final district = districtsList[index];
                    return GestureDetector(
                      onTap: (){
                        Get.to(
                                () => DistrictInfoScreen(districtData: district)
                        );
                      },
                      child: Container(
                          width: 230,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade200,
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: const Offset(0,3)
                                )
                              ]
                          ),
                          margin: const EdgeInsets.only(right: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: Image.asset('${Assets().img}${district['image']}', width: 230, fit: BoxFit.cover)
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          district['title'],
                                          style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18,
                                              color: Colors.black
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset('${Assets().icn}favourite.svg'),
                                            const SizedBox(width: 10),
                                            Text(
                                              district['score'].toString(),
                                              style: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  color: Colors.black
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          )
                      ),
                    );
                  }
              ),
            ),

            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'News',
                textAlign: TextAlign.start,
                style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff056C5F)
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade200,
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: const Offset(0,3)
                      )
                    ]
                ),
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        '${Assets().img}garbage.png',
                        width: 120,
                        height: 120,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Sabattarian',
                                style: GoogleFonts.inter(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                ),
                              )
                            ],
                          ),
                          const Divider(color: Color(0xffEDEDED)),
                          Expanded(
                            child: Text(
                              'In the gorge of the Kazachka river',
                              maxLines: 2,
                              style: GoogleFonts.inter(
                                  color: const Color(0xff878787),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                          ),

                          Text(
                            '7th of May at 08:30',
                            style: GoogleFonts.inter(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w400
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

