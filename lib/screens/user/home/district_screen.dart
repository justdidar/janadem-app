import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:janadem/constants/assets.dart';

class DistrictInfoScreen extends StatefulWidget {
  final Map districtData;
  const DistrictInfoScreen({super.key, required this.districtData});

  @override
  State<DistrictInfoScreen> createState() => _DistrictInfoScreenState();
}

class _DistrictInfoScreenState extends State<DistrictInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.districtData['title'],
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
          child: ListView(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                    height: 200,
                    color: Colors.grey.shade200,
                    child: Image.asset(
                      '${Assets().img}${widget.districtData['image']}',
                      fit: BoxFit.fitWidth,
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.districtData['title'],
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset('${Assets().icn}favourite.svg'),
                        const SizedBox(width: 10),
                        Text(
                          widget.districtData['score'].toString(),
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

              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: const Color(0xffF5F5FF)
                            ),
                            padding: const EdgeInsets.all(10),
                            child: SvgPicture.asset(
                                '${Assets().icn}population.svg'
                            ),
                          ),
                          Text(
                            widget.districtData['population'],
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff101010)
                            ),
                          ),
                          Text(
                            'Population',
                            style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff878787)
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: const Color(0xffF5F5FF)
                            ),
                            padding: const EdgeInsets.all(10),
                            child: SvgPicture.asset(
                                '${Assets().icn}favourites.svg'
                            ),
                          ),
                          Text(
                            widget.districtData['score'].toString(),
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff101010)
                            ),
                          ),
                          Text(
                            'Rating',
                            style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff878787)
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: const Color(0xffF5F5FF)
                            ),
                            padding: const EdgeInsets.all(10),
                            child: SvgPicture.asset(
                                '${Assets().icn}reviews.svg'
                            ),
                          ),
                          Text(
                            widget.districtData['review'],
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff101010)
                            ),
                          ),
                          Text(
                            'Reviews',
                            style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff878787)
                            ),
                          )
                        ],
                      ),
                    ],
                  )
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About District',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.districtData['description'],
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: const Color(0xff878787)
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
