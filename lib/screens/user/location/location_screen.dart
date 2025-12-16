import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> with SingleTickerProviderStateMixin {

  late TabController _tabController;

  final List<Map<String, String>> dummyIssues = [
    {
      'title': 'Broken street light',
      'description': 'The street light near my house is broken.',
      'image': 'https://via.placeholder.com/150',
      'longitude': '76.923',
      'latitude': '43.238',
      'status': 'IN_PROGRESS'
    },
    {
      'title': 'Pothole on the road',
      'description': 'Big pothole causing accidents.',
      'image': 'https://via.placeholder.com/150',
      'longitude': '76.935',
      'latitude': '43.245',
      'status': 'FINISHED'
    },
    {
      'title': 'Overflowing trash bin',
      'description': 'Trash bin near park is full.',
      'image': 'https://via.placeholder.com/150',
      'longitude': '76.940',
      'latitude': '43.250',
      'status': 'ALL'
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, String>> filterIssues(String status) {
    if (status == 'All') return dummyIssues;
    return dummyIssues.where((issue) => issue['status'] == status).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Problem location',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 19,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TabBar(
                isScrollable: false,
                splashFactory: NoSplash.splashFactory,
                controller: _tabController,
                labelColor: Colors.black,
                unselectedLabelColor: const Color(0xff64748B),
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: const UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 5,
                      color: Color(0xff056C5F),
                    )
                ),
                tabs: [
                  Tab(child: Text('All', style: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 17))),
                  Tab(child: Text('Progress', style: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 17))),
                  Tab(child: Text('Success', style: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 17))),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: ['All', 'IN_PROGRESS', 'FINISHED'].map((status) {
                  final issues = filterIssues(status);
                  return ListView.builder(
                    itemCount: issues.length,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemBuilder: (context, index) {
                      final issue = issues[index];
                      return GestureDetector(
                        onTap: () {
                          if(issue['status'] == 'FINISHED'){
                            Get.dialog(
                                AlertDialog(
                                  title: const Text('Reward'),
                                  content: const Text('User coin alert here!'),
                                  actions: [
                                    TextButton(onPressed: () => Get.back(), child: const Text('Close'))
                                  ],
                                )
                            );
                          } else {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: Scaffold(
                                appBar: AppBar(title: Text(issue['title']!)),
                                body: Center(child: Text('Issue details screen')),
                              ),
                              withNavBar: true,
                            );
                          }
                        },
                        child: Container(
                          height: 180,
                          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.blueAccent),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  height: 170,
                                  width: 130,
                                  child: Image.network(issue['image']!, fit: BoxFit.cover),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(issue['title']!, maxLines: 2, overflow: TextOverflow.ellipsis, style: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 16)),
                                      Text(issue['description']!, maxLines: 3, overflow: TextOverflow.ellipsis, style: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 14)),
                                      const SizedBox(height: 10),
                                      Text('${issue['longitude']}, ${issue['latitude']}', style: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 13)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
