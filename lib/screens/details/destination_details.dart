import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rahal/model/destination_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DestinationDetailsScreen extends StatefulWidget {
  final DestinationModel destination;
  const DestinationDetailsScreen({super.key, required this.destination});

  @override
  State<DestinationDetailsScreen> createState() =>
      _DestinationDetailsScreenState();
}

class _DestinationDetailsScreenState extends State<DestinationDetailsScreen> {
  bool _isFavorite = false;
  AppleMapController? _mapController;

  static const Color _accent = Color(0xFFF8774F);

  // Sunny Ridge Farm coords (Germany)
  static const LatLng _destination = LatLng(52.5200, 13.4050);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ── Full layout ──────────────────────────────────────────────────
          Column(
            children: [
              // Hero Image
              _buildHeroImage(),

              // Scrollable content card
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: _buildContentCard(),
                ),
              ),
            ],
          ),

          // ── Floating top buttons ─────────────────────────────────────────
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _floatingIconButton(
                    icon: CupertinoIcons.arrow_left,
                    onTap: () => Navigator.pop(context),
                  ),
                  _floatingIconButton(
                    icon: _isFavorite
                        ? CupertinoIcons.heart_fill
                        : CupertinoIcons.heart,

                    onTap: () => setState(() => _isFavorite = !_isFavorite),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Hero Image ────────────────────────────────────────────────────────────
  Widget _buildHeroImage() {
    return Hero(
      tag: 'destination_${widget.destination.id}',
      child: SizedBox(
        height: 280.h,
        width: double.infinity,
        child: Image.network(
          widget.destination.imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: Colors.grey.shade200,
            child: Icon(CupertinoIcons.photo, size: 48.sp, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  // ── Content Card ──────────────────────────────────────────────────────────
  Widget _buildContentCard() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 0),
      padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 32.h),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 36.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),

          // Title
          Center(
            child: Text(
              widget.destination.name,
              style: GoogleFonts.poppins(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.titleLarge?.color,
              ),
            ),
          ),
          SizedBox(height: 4.h),

          // Country
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('🇩🇪', style: TextStyle(fontSize: 16.sp)),
                SizedBox(width: 6.w),
                Text(
                  widget.destination.location,
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 14.h),

          // Description
          Text(
            widget.destination.description,
            style: GoogleFonts.poppins(
              fontSize: 13.sp,
              color: Theme.of(context).textTheme.bodySmall?.color,
              height: 1.6,
            ),
          ),
          SizedBox(height: 20.h),

          // Map + Weather row
          Row(
            children: [
              // Apple Maps
              Expanded(
                flex: 5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: SizedBox(
                    height: 130.h,
                    child: AppleMap(
                      initialCameraPosition: CameraPosition(
                        target: _destination,
                        zoom: 11,
                      ),
                      onMapCreated: (controller) => _mapController = controller,
                      annotations: {
                        Annotation(
                          annotationId: AnnotationId('destination'),
                          position: _destination,
                        ),
                      },
                      mapType: MapType.standard,
                      zoomGesturesEnabled: false,
                      scrollGesturesEnabled: true,
                      onTap: (_) async {
                        // Open Apple Maps app with the destination coordinates
                        final uri = Uri.parse(
                          'https://maps.apple.com/?q=${_destination.latitude},${_destination.longitude}',
                        );
                        await launchUrl(
                          uri,
                          mode: LaunchMode.externalApplication,
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),

              // Weather
              Expanded(flex: 4, child: _buildWeatherCard()),
            ],
          ),
          SizedBox(height: 20.h),

          // Ticket / Hotel / Meal
          _buildServiceButtons(),
          SizedBox(height: 20.h),

          // Divider
          Divider(color: Theme.of(context).dividerColor, thickness: 1),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  // ── Weather Card ──────────────────────────────────────────────────────────
  Widget _buildWeatherCard() {
    return Container(
      height: 130.h,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text('🌤️', style: TextStyle(fontSize: 18.sp)),
              SizedBox(width: 6.w),
              Text(
                'Rainy',
                style: GoogleFonts.poppins(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '8:40 AM',
                style: GoogleFonts.poppins(
                  fontSize: 11.sp,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '32',
                    style: GoogleFonts.poppins(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.titleLarge?.color,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 6.h),
                    child: Text(
                      '°C',
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Service Buttons ───────────────────────────────────────────────────────
  Widget _buildServiceButtons() {
    final theme = Theme.of(context);
    final services = [
      {'icon': '🎫', 'label': 'Ticket', 'color': 0xFFFFF3EE},
      {'icon': '🏨', 'label': 'Hotel', 'color': 0xFFEEF3FF},
      {'icon': '🍽️', 'label': 'Meal', 'color': 0xFFFFEEEE},
    ];

    return Row(
      children: services.map((s) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 14.h),
                decoration: BoxDecoration(
                  color: theme.brightness == Brightness.dark
                      ? Colors.grey.shade800
                      : s['color'] != null
                      ? Color(s['color'] as int)
                      : theme.cardColor,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  children: [
                    Text(
                      s['icon'] as String,
                      style: TextStyle(fontSize: 20.sp),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      s['label'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // ── Floating Icon Button ──────────────────────────────────────────────────
  Widget _floatingIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(icon, size: 20.sp),
      ),
    );
  }
}
