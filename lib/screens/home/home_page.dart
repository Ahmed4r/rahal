import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:rahal/model/destination_model.dart';
import 'package:rahal/service/location_service.dart';
import 'package:rahal/shared/app_colors.dart';
import 'package:rahal/widgets/circle_container.dart';
import 'package:rahal/widgets/text_field.dart';
import 'package:rahal/widgets/time_line.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  final FocusNode focusNode = FocusNode();

  final List<String> feelingList = [
    "Happy",
    "Excited",
    "Relaxed",
    "Adventurous",
    "Romantic",
  ];
  final List<Map<String, String>> timeLine = [
    {
      "time": "9:00 AM",
      "title": "Happy",
      "description": "Start your day with a smile!",
      "image":
          "https://plus.unsplash.com/premium_photo-1670148434900-5f0af77ba500?w=400&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8c3BsYXNofGVufDB8fDB8fHww",
    },
    {
      "time": "12:00 AM",
      "title": "sad",
      "description": "Start your day with a s!",
      "image":
          "https://images.unsplash.com/photo-1459802071246-377c0346da93?q=80&w=818&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
    {
      "time": "12:00 AM",
      "title": "sad",
      "description": "Start your day with a s!",
      "image":
          "https://images.unsplash.com/photo-1459802071246-377c0346da93?q=80&w=818&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
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
    try {
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
    } catch (e) {
      debugPrint(e.toString());
    }
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
                buildTopBar(theme, currentCity),
                SizedBox(height: 10.h),
                buildSearchBar(theme, searchController, focusNode),
                SizedBox(height: 16.h),
                glassCardWeather(theme),
                SizedBox(height: 20.h),
                Text(
                  'How are you feeling today?',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                buildCountryListView(
                  theme,
                  feelingList,
                  _selectedCountryIndex,
                  (index) {
                    setState(() {
                      _selectedCountryIndex = index;
                    });
                  },
                ),
                SizedBox(height: 20.h),

                buildSectionHeader(theme),
                SizedBox(height: 20.h),

                SizedBox(height: 10.h),
                buildTimeLine(timeLine),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget glassCardWeather(ThemeData theme) {
    return GlassCard(
      quality: GlassQuality.standard,
      // borderRadius: BorderRadius.circular(20.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Today in $currentCity',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '18 °C',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Sunny',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            CupertinoIcons.sun_max_fill,
            size: 50.sp,
            color: Colors.orangeAccent,
          ),
        ],
      ),
    );
  }
}

Widget buildTimeLine(List<Map<String, String>> timeLine) {
  return SizedBox(
    width: 300.w,
    height: 250.h,
    child: ListView.builder(
      itemCount: timeLine.length,
      shrinkWrap: true,

      itemBuilder: (context, index) {
        final item = timeLine[index];
        final bool isFirst = index == 0;
        final bool isLast = index == timeLine.length - 1;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Timeline
              SizedBox(
                width: 42.w,
                child: Column(
                  children: [
                    if (!isFirst)
                      Expanded(
                        child: Container(width: 2, color: Colors.grey.shade300),
                      ),

                    Container(
                      width: 18.w,
                      height: 18.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          color: const Color.fromARGB(255, 4, 25, 22),
                          width: 3,
                        ),
                      ),
                    ),

                    if (!isLast)
                      Expanded(
                        child: Container(width: 2, color: Colors.grey.shade300),
                      ),
                  ],
                ),
              ),

              SizedBox(width: 16.w),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 22.h),
                  child: TimelineCard(
                    time: item["time"]!,
                    title: item["title"]!,
                    subtitle: item["description"]!,
                    image: item["image"]!,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}

// ── Top Bar ────────────────────────────────────────────────────────────────
Widget buildTopBar(ThemeData theme, String currentCity) {
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
Widget buildSearchBar(
  ThemeData theme,
  TextEditingController searchController,
  FocusNode focusNode,
) {
  return Row(
    children: [
      Expanded(
        child: SizedBox(
          height: 52.h,
          child: CustomeTextField(
            title: 'Where do you want to go?',
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
Widget buildCountryListView(
  ThemeData theme,
  List<String> feelingList,
  int selectedCountryIndex,
  Function(int) onSelect,
) {
  return SizedBox(
    height: 44.h,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: feelingList.length,
      separatorBuilder: (context, index) => SizedBox(width: 10.w),
      itemBuilder: (context, index) {
        final bool isSelected = selectedCountryIndex == index;
        return GestureDetector(
          onTap: () => onSelect(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: theme.brightness == Brightness.light
                  ? (isSelected ? Colors.black : Colors.white)
                  : (isSelected ? null : const Color.fromARGB(255, 21, 21, 22)),
              borderRadius: BorderRadius.circular(30.r),
              border: theme.brightness == Brightness.dark
                  ? Border.all(
                      color: isSelected
                          ? AppColors.orangeAccentColor
                          : Colors.transparent,
                      width: context.w(1.5),
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
                Text(
                  feelingList[index],
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
        "Rahal Choices",
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
