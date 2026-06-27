import 'dart:developer';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rahal/model/destination_model.dart';
import 'package:rahal/screens/details/destination_details.dart';
import 'package:rahal/service/location_service.dart';
import 'package:rahal/shared/app_colors.dart';
import 'package:rahal/widgets/circle_container.dart';
import 'package:rahal/widgets/primary_button.dart';
import 'package:rahal/widgets/text_field.dart';
import 'package:toasti_overlay/toast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();
  final LocationService locationService = LocationService();

  int _selectedCountryIndex = 0;
  bool _isFavorite = false;
  final FocusNode focusNode = FocusNode();

  final List<Map<String, String>> countryList = [
    {"name": "Germany", "flag": "https://flagsapi.com/DE/flat/64.png"},
    {"name": "Denmark", "flag": "https://flagsapi.com/DK/flat/64.png"},
    {"name": "Sweden", "flag": "https://flagsapi.com/SE/flat/64.png"},
    {"name": "France", "flag": "https://flagsapi.com/FR/flat/64.png"},
    {"name": "Japan", "flag": "https://flagsapi.com/JP/flat/64.png"},
    {"name": "Canada", "flag": "https://flagsapi.com/CA/flat/64.png"},
    {"name": "Egypt", "flag": "https://flagsapi.com/EG/flat/64.png"},
  ];

  void requestLocationPermission() async {
    bool granted = await locationService.requestLocationPermission();
    if (!granted) {
      showToasti(
        // ignore: use_build_context_synchronously
        context,
        title: "Location Permission Denied",
        description: "Please enable location permission to use this feature.",
        type: ToastType.error,
        duration: const Duration(seconds: 3),
      );
    }
  }

  var currentCity = '--';

  List<DestinationModel> destinations = [
    DestinationModel(
      id: 1,
      name: 'Whispering Fields',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f7/Museumsinsel_Berlin_Juli_2021_1_%28cropped%29_b.jpg/330px-Museumsinsel_Berlin_Juli_2021_1_%28cropped%29_b.jpg',
      rating: 4.9,
      isFavorite: false,
      location: 'Germany',
      description:
          'Fictional countryside gem surrounded by windmills, lakes, and soft green hills.',
      price: '\$1200',
      duration: '27 June – 12 May',
    ),
    DestinationModel(
      id: 2,
      name: 'Sunset Beach',
      imageUrl:
          'https://content.r9cdn.net/rimg/dimg/39/86/ae1975d6-city-26939-15516fe0259.jpg?width=1366&height=768&crop=true&cropStrategy=attention',
      rating: 4.7,
      isFavorite: true,
      location: 'Frankfurt',
      description:
          'A serene beach destination with golden sands, perfect for relaxation and water sports.',
      price: '\$1800',

      duration: '15 July – 30 July',
    ),
  ];

  void getCurrentCity() async {
    String city = await LocationService.getCurrentCity();
    if (!mounted) return;
    showToasti(
      context,
      title: "City Detected",
      description: "Your current city is $city.",
      type: ToastType.success,
      duration: const Duration(seconds: 3),
    );
    setState(() {
      formatCityName(city);
    });
  }

  void formatCityName(String city) {
    if (city.length > 20) {
      currentCity = '${city.substring(0, 15)}...';
    } else {
      currentCity = city;
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    requestLocationPermission();
    getCurrentCity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
      },
      child: CupertinoPageScaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTopBar(theme),
                SizedBox(height: 10.h),
                buildSearchBar(theme),
                SizedBox(height: 16.h),
                buildCountryListView(theme),
                SizedBox(height: 20.h),
                buildSectionHeader(theme),
                SizedBox(
                  width: 290.w,
                  height: 400.h,
                  child: ListView.separated(
                    // shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemCount: destinations.length,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) => SizedBox(width: 30.w),
                    itemBuilder: (context, index) {
                      final destination = destinations[index];
                      return buildPopularDestinations(theme, destination);
                    },
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Top Bar ────────────────────────────────────────────────────────────────
  Widget buildTopBar(ThemeData theme) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Location", style: theme.textTheme.bodyMedium),
            Row(
              children: [
                Text(
                  currentCity,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: theme.textTheme.titleMedium?.color,
                  ),
                ),
                Icon(CupertinoIcons.chevron_down, size: 20.sp),
              ],
            ),
          ],
        ),
        const Spacer(),
        CircleContainer(
          color: Color(0xffF5F5F5),
          child: Icon(CupertinoIcons.bell, size: 20.sp),
        ),
        SizedBox(width: 10.w),
        CircleAvatar(
          radius: 22.r,
          backgroundImage: const NetworkImage(
            'https://i.pinimg.com/736x/6f/f0/f8/6ff0f878005d7059b0d85283438059f3.jpg',
          ),
        ),
      ],
    );
  }

  // ── Search Bar ─────────────────────────────────────────────────────────────
  Widget buildSearchBar(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 52.h,
            child: CustomeTextField(
              title: 'Search',
              controller: searchController,
              focusNode: focusNode,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        CircleContainer(
          color: Color(0xffF5F5F5),
          child: Icon(FluentIcons.filter_32_filled, size: 20.sp),
        ),
      ],
    );
  }

  // ── Country Filter Chips ───────────────────────────────────────────────────
  Widget buildCountryListView(ThemeData theme) {
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
                color: theme.brightness == Brightness.light
                    ? (isSelected ? Colors.black : Colors.white)
                    : (isSelected
                          ? null
                          : const Color.fromARGB(255, 21, 21, 22)),
                borderRadius: BorderRadius.circular(30.r),
                border: theme.brightness == Brightness.dark
                    ? Border.all(
                        color: isSelected
                            ? AppColors.orangeAccentColor
                            : Colors.transparent,
                        width: 1.5,
                      )
                    : null,

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
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(CupertinoIcons.flag, size: 16.sp),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    countryList[index]['name']!,
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
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
  Widget buildSectionHeader(ThemeData theme) {
    return Row(
      children: [
        Text(
          "Popular Destinations",
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Text(
          "View all",
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.orangeAccentColor,
          ),
        ),
        SizedBox(width: 2.w),
        Icon(
          CupertinoIcons.chevron_right,
          color: AppColors.orangeAccentColor,
          size: 13.sp,
        ),
      ],
    );
  }

  // ── Destination Card ───────────────────────────────────────────────────────
  Widget buildPopularDestinations(
    ThemeData theme,
    DestinationModel destination,
  ) {
    final double imageHeight = 180.h;

    final double overlap = imageHeight * 0.5; // قد ما الصورة هتطلع برا

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        // ── Card (يبدأ من نص الصورة) ──────────────────────────────────────
        Container(
          margin: EdgeInsets.only(top: overlap), // ← ينزل تحت الصورة
          width: 290.w,
          decoration: BoxDecoration(
            color: theme.brightness == Brightness.light
                ? AppColors.cardColor
                : theme.cardColor,
            borderRadius: BorderRadius.circular(28.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 30.r,
                offset: const Offset(20, 26),
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
                      destination.name,
                      style: GoogleFonts.poppins(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: theme.textTheme.titleMedium?.color,
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
                      destination.location,
                      style: GoogleFonts.poppins(
                        fontSize: 13.sp,
                        color: theme.textTheme.titleMedium?.color,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Text(
                  destination.description,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontSize: 12.sp, height: 1.6),
                ),
                SizedBox(height: 12.h),
                Text(
                  destination.duration,
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: PrimaryButton(
                    onPressed: () async {
                      await HapticFeedback.lightImpact();
                      if (!mounted) return;
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => DestinationDetailsScreen(
                            destination: destination,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Show details',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 16.sp,
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

        // ── Image floating above card ──────────────────────────────────────
        Positioned(
          top: 10.h,
          child:
              // الصورة
              Hero(
                tag: 'destination_${destination.id}',
                child: CircleAvatar(
                  radius: 90.r,
                  backgroundImage: NetworkImage(destination.imageUrl),
                ),
              ),

          // ⭐ Rating badge
        ),
        // ❤️ Favorite badge
        Positioned(
          top: 100.h,
          right: 10.w,
          child: GestureDetector(
            onTap: () => setState(
              () => destination.isFavorite = !destination.isFavorite,
            ),
            child: Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: theme.cardColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.01),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Icon(
                destination.isFavorite
                    ? CupertinoIcons.heart_fill
                    : Icons.favorite_border_rounded,
                color: Colors.redAccent,
                size: 25.sp,
              ),
            ),
          ),
        ),
        Positioned(
          top: 100.h,
          left: 10.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: theme.cardColor,

              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.01), blurRadius: 6),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star_rounded, color: Colors.deepOrange, size: 20.sp),
                SizedBox(width: 3.w),
                Text(
                  destination.rating.toString(),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: theme.textTheme.titleMedium?.color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
