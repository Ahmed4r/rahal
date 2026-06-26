import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rahal/screens/details/trip_details.dart';
import 'package:rahal/shared/app_colors.dart';
import 'package:rahal/widgets/circle_container.dart';
import 'package:rahal/widgets/text_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();

  int _selectedCountryIndex = 0;
  bool _isFavorite = false;

  final List<Map<String, String>> countryList = [
    {"name": "Germany", "flag": "https://flagsapi.com/DE/flat/64.png"},
    {"name": "Denmark", "flag": "https://flagsapi.com/DK/flat/64.png"},
    {"name": "Sweden", "flag": "https://flagsapi.com/SE/flat/64.png"},
    {"name": "France", "flag": "https://flagsapi.com/FR/flat/64.png"},
    {"name": "Japan", "flag": "https://flagsapi.com/JP/flat/64.png"},
    {"name": "Canada", "flag": "https://flagsapi.com/CA/flat/64.png"},
    {"name": "Egypt", "flag": "https://flagsapi.com/EG/flat/64.png"},
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTopBar(),
              SizedBox(height: 16.h),
              buildSearchBar(),
              SizedBox(height: 16.h),
              buildCountryListView(),
              SizedBox(height: 24.h),
              buildSectionHeader(),
              SizedBox(height: 12.h),
              buildPopularDestinations(),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  // ── Top Bar ────────────────────────────────────────────────────────────────
  Widget buildTopBar() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Location",
              style: GoogleFonts.poppins(
                fontSize: 13.sp,
                color: Colors.black54,
                fontWeight: FontWeight.w400,
              ),
            ),
            Row(
              children: [
                Text(
                  "Berlin",
                  style: GoogleFonts.poppins(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.black,
                  size: 26.sp,
                ),
              ],
            ),
          ],
        ),
        const Spacer(),
        CircleContainer(
          child: Icon(CupertinoIcons.bell, color: Colors.black, size: 20.sp),
        ),
        SizedBox(width: 10.w),
        CircleAvatar(
          radius: 22.r,
          backgroundImage: const NetworkImage(
            'https://i.pinimg.com/736x/6f/f0/f8/6ff0f878005d7059b0d85283438059f3.jpg',
          ),
          onBackgroundImageError: (_, __) =>
              Icon(CupertinoIcons.person, size: 22.sp),
        ),
      ],
    );
  }

  // ── Search Bar ─────────────────────────────────────────────────────────────
  Widget buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 52.h,
            child: CustomeTextField(
              title: 'Search',
              controller: searchController,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        CircleContainer(
          child: Icon(
            FluentIcons.filter_32_filled,
            color: Colors.black,
            size: 20.sp,
          ),
        ),
      ],
    );
  }

  // ── Country Filter Chips ───────────────────────────────────────────────────
  Widget buildCountryListView() {
    return SizedBox(
      height: 44.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: countryList.length,
        separatorBuilder: (_, __) => SizedBox(width: 10.w),
        itemBuilder: (context, index) {
          final bool isSelected = _selectedCountryIndex == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedCountryIndex = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(30.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(
                    countryList[index]['flag']!,
                    width: 20.w,
                    height: 20.h,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) =>
                        Icon(CupertinoIcons.flag, size: 16.sp),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    countryList[index]['name']!,
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ── Section Header ─────────────────────────────────────────────────────────
  Widget buildSectionHeader() {
    return Row(
      children: [
        Text(
          "Popular Destinations",
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const Spacer(),
        Text(
          "View all",
          style: GoogleFonts.poppins(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.orangeAccentColor,
          ),
        ),
        SizedBox(width: 2.w),
        Icon(
          Icons.arrow_forward_ios_rounded,
          color: AppColors.orangeAccentColor,
          size: 13.sp,
        ),
      ],
    );
  }

  // ── Destination Card ───────────────────────────────────────────────────────
  Widget buildPopularDestinations() {
    final double imageHeight = 180.h;

    final double overlap = imageHeight * 0.5; // قد ما الصورة هتطلع برا

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        // ── Card (يبدأ من نص الصورة) ──────────────────────────────────────
        Container(
          margin: EdgeInsets.only(top: overlap), // ← ينزل تحت الصورة
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, overlap + 12.h, 20.w, 20.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('🌾', style: TextStyle(fontSize: 18.sp)),
                    SizedBox(width: 6.w),
                    Text(
                      'Whispering Fields',
                      style: GoogleFonts.poppins(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('🇩🇪', style: TextStyle(fontSize: 14.sp)),
                    SizedBox(width: 4.w),
                    Text(
                      'Germany',
                      style: GoogleFonts.poppins(
                        fontSize: 13.sp,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Text(
                  'Fictional countryside gem surrounded by windmills, lakes, and soft green hills.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: Colors.black54,
                    height: 1.6,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  '27 June – 12 May',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => DestinationDetailsScreen(),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF8774F),
                      elevation: 0,
                      shape: const StadiumBorder(),
                    ),
                    child: Text(
                      'Show details',
                      style: GoogleFonts.poppins(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 100.h,
          left: 10.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 6),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star_rounded, color: Colors.amber, size: 20.sp),
                SizedBox(width: 3.w),
                Text(
                  '4.9',
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),

        // ❤️ Favorite badge
        Positioned(
          top: 100.h,
          right: 10.w,
          child: GestureDetector(
            onTap: () => setState(() => _isFavorite = !_isFavorite),
            child: Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Icon(
                _isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                color: Colors.redAccent,
                size: 25.sp,
              ),
            ),
          ),
        ),

        // ── Image floating above card ──────────────────────────────────────
        Positioned(
          top: 10.h,
          child:
              // الصورة
              CircleAvatar(
                radius: 90.r,
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1570168007204-dfb528c6958f?w=800',
                ),
              ),

          // ⭐ Rating badge
        ),
      ],
    );
  }
}
