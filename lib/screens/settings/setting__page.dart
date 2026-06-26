import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:google_fonts/google_fonts.dart';


class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  // ── State ──────────────────────────────────────────────────────────────────
  bool _notificationsEnabled = true;
  bool _tripReminders = true;
  bool _offlineMaps = false;
  bool _locationAccess = true;
  String _selectedLanguage = 'English';
  String _selectedCurrency = 'USD – US Dollar';
  String _selectedTheme = 'Light';

  // ── Palette (matches app)──────────────────────────────────────────────────
  static const Color _bg = Color(0xFFF2F4EF);
  static const Color _card = Colors.white;
  static const Color _accent = Color(0xFFF8774F);
  static const Color _textPrimary = Color(0xFF1A1A2E);
  static const Color _textSecondary = Color(0xFF8A8A9A);

  // ── Build ─────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfileCard(),
                    SizedBox(height: 24.h),
                    _sectionLabel('Preferences'),
                    SizedBox(height: 10.h),
                    _buildPreferencesCard(),
                    SizedBox(height: 24.h),
                    _sectionLabel('Notifications'),
                    SizedBox(height: 10.h),
                    _buildNotificationsCard(),
                    SizedBox(height: 24.h),
                    _sectionLabel('Trip Tools'),
                    SizedBox(height: 10.h),
                    _buildTripToolsCard(),
                    SizedBox(height: 24.h),
                    _sectionLabel('Support & Legal'),
                    SizedBox(height: 10.h),
                    _buildSupportCard(),
                    SizedBox(height: 24.h),
                    _buildLogoutButton(),
                    SizedBox(height: 8.h),
                    Center(
                      child: Text(
                        'WanderAI v1.0.0',
                        style: GoogleFonts.poppins(
                          fontSize: 11.sp,
                          color: _textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Header ─────────────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 8.h),
      child: Row(
        children: [
          Text(
            'Settings',
            style: GoogleFonts.poppins(
              fontSize: 26.sp,
              fontWeight: FontWeight.bold,
              color: _textPrimary,
            ),
          ),
          const Spacer(),
          _iconButton(CupertinoIcons.bell, onTap: () {}),
        ],
      ),
    );
  }

  // ── Profile Card ───────────────────────────────────────────────────────────
  Widget _buildProfileCard() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundImage: const NetworkImage(
                  'https://randomuser.me/api/portraits/men/32.jpg',
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: const BoxDecoration(
                    color: _accent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    CupertinoIcons.pencil,
                    size: 10.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'James Kir',
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: _textPrimary,
                  ),
                ),
                Text(
                  'james.kir@email.com',
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: _textSecondary,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.map_pin_ellipse,
                      size: 12.sp,
                      color: _accent,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Berlin, Germany',
                      style: GoogleFonts.poppins(
                        fontSize: 11.sp,
                        color: _accent,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Icon(
            CupertinoIcons.chevron_right,
            size: 16.sp,
            color: _textSecondary,
          ),
        ],
      ),
    );
  }

  // ── Preferences Card ───────────────────────────────────────────────────────
  Widget _buildPreferencesCard() {
    return Container(
      decoration: _cardDecoration(),
      child: Column(
        children: [
          _buildPickerTile(
            icon: CupertinoIcons.globe,
            iconBg: const Color(0xFFE8F4FF),
            iconColor: const Color(0xFF4A90D9),
            title: 'Language',
            value: _selectedLanguage,
            options: ['English', 'German', 'Arabic', 'French', 'Spanish'],
            onChanged: (val) => setState(() => _selectedLanguage = val),
          ),
          _divider(),
          _buildPickerTile(
            icon: CupertinoIcons.money_dollar_circle,
            iconBg: const Color(0xFFE8FFE8),
            iconColor: const Color(0xFF4CAF50),
            title: 'Currency',
            value: _selectedCurrency,
            options: [
              'USD – US Dollar',
              'EUR – Euro',
              'GBP – British Pound',
              'EGP – Egyptian Pound',
              'DKK – Danish Krone',
            ],
            onChanged: (val) => setState(() => _selectedCurrency = val),
          ),
          _divider(),
          _buildPickerTile(
            icon: CupertinoIcons.circle_lefthalf_fill,
            iconBg: const Color(0xFFF3E8FF),
            iconColor: const Color(0xFF9C27B0),
            title: 'Theme',
            value: _selectedTheme,
            options: ['Light', 'Dark', 'System Default'],
            onChanged: (val) => setState(() => _selectedTheme = val),
          ),
        ],
      ),
    );
  }

  // ── Notifications Card ─────────────────────────────────────────────────────
  Widget _buildNotificationsCard() {
    return Container(
      decoration: _cardDecoration(),
      child: Column(
        children: [
          _buildToggleTile(
            icon: CupertinoIcons.bell_fill,
            iconBg: const Color(0xFFFFF3E8),
            iconColor: _accent,
            title: 'Push Notifications',
            subtitle: 'Deals, updates & alerts',
            value: _notificationsEnabled,
            onChanged: (val) => setState(() => _notificationsEnabled = val),
          ),
          _divider(),
          _buildToggleTile(
            icon: CupertinoIcons.calendar_badge_plus,
            iconBg: const Color(0xFFE8F4FF),
            iconColor: const Color(0xFF4A90D9),
            title: 'Trip Reminders',
            subtitle: '24h before departure',
            value: _tripReminders,
            onChanged: (val) => setState(() => _tripReminders = val),
          ),
        ],
      ),
    );
  }

  // ── Trip Tools Card ────────────────────────────────────────────────────────
  Widget _buildTripToolsCard() {
    return Container(
      decoration: _cardDecoration(),
      child: Column(
        children: [
          _buildToggleTile(
            icon: CupertinoIcons.map_fill,
            iconBg: const Color(0xFFE8FFE8),
            iconColor: const Color(0xFF4CAF50),
            title: 'Offline Maps',
            subtitle: 'Download for no-internet areas',
            value: _offlineMaps,
            onChanged: (val) => setState(() => _offlineMaps = val),
          ),
          _divider(),
          _buildToggleTile(
            icon: CupertinoIcons.location_fill,
            iconBg: const Color(0xFFFFE8F0),
            iconColor: const Color(0xFFE91E63),
            title: 'Location Access',
            subtitle: 'Needed for nearby places',
            value: _locationAccess,
            onChanged: (val) => setState(() => _locationAccess = val),
          ),
          _divider(),
          _buildNavTile(
            icon: CupertinoIcons.bag_fill,
            iconBg: const Color(0xFFFFF8E8),
            iconColor: const Color(0xFFFFC107),
            title: 'Packing Checklist',
            subtitle: 'Manage your travel essentials',
            onTap: () {},
          ),
          _divider(),
          _buildNavTile(
            icon: CupertinoIcons.airplane,
            iconBg: const Color(0xFFF3E8FF),
            iconColor: const Color(0xFF9C27B0),
            title: 'Flight Preferences',
            subtitle: 'Seat, meal & class defaults',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  // ── Support Card ───────────────────────────────────────────────────────────
  Widget _buildSupportCard() {
    return Container(
      decoration: _cardDecoration(),
      child: Column(
        children: [
          _buildNavTile(
            icon: CupertinoIcons.question_circle_fill,
            iconBg: const Color(0xFFE8F4FF),
            iconColor: const Color(0xFF4A90D9),
            title: 'Help & Support',
            subtitle: 'FAQs, contact us',
            onTap: () {},
          ),
          _divider(),
          _buildNavTile(
            icon: CupertinoIcons.lock_shield_fill,
            iconBg: const Color(0xFFE8FFE8),
            iconColor: const Color(0xFF4CAF50),
            title: 'Privacy & Security',
            subtitle: 'Data & permissions',
            onTap: () {},
          ),
          _divider(),
          _buildNavTile(
            icon: CupertinoIcons.doc_text_fill,
            iconBg: const Color(0xFFFFF3E8),
            iconColor: _accent,
            title: 'Terms & Conditions',
            onTap: () {},
          ),
          _divider(),
          _buildNavTile(
            icon: CupertinoIcons.star_fill,
            iconBg: const Color(0xFFFFF8E8),
            iconColor: const Color(0xFFFFC107),
            title: 'Rate the App',
            subtitle: 'Tell us what you think',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  // ── Logout Button ──────────────────────────────────────────────────────────
  Widget _buildLogoutButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.redAccent.withOpacity(0.4)),
          color: Colors.redAccent.withOpacity(0.06),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.square_arrow_right,
              color: Colors.redAccent,
              size: 18.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              'Log Out',
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Reusable Tiles ─────────────────────────────────────────────────────────
  Widget _buildToggleTile({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          _iconBox(icon, iconBg, iconColor),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: _textPrimary,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 11.sp,
                      color: _textSecondary,
                    ),
                  ),
              ],
            ),
          ),
          Transform.scale(
            scale: 0.85,
            child: CupertinoSwitch(
              value: value,
              activeColor: _accent,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavTile({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            _iconBox(icon, iconBg, iconColor),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: _textPrimary,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: GoogleFonts.poppins(
                        fontSize: 11.sp,
                        color: _textSecondary,
                      ),
                    ),
                ],
              ),
            ),
            Icon(
              CupertinoIcons.chevron_right,
              size: 16.sp,
              color: _textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPickerTile({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String value,
    required List<String> options,
    required ValueChanged<String> onChanged,
  }) {
    return InkWell(
      onTap: () => _showPicker(title, options, value, onChanged),
      borderRadius: BorderRadius.circular(16.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            _iconBox(icon, iconBg, iconColor),
            SizedBox(width: 14.w),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: _textPrimary,
                ),
              ),
            ),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 13.sp,
                color: _accent,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 4.w),
            Icon(
              CupertinoIcons.chevron_right,
              size: 16.sp,
              color: _textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  // ── Picker Bottom Sheet ────────────────────────────────────────────────────
  void _showPicker(
    String title,
    List<String> options,
    String current,
    ValueChanged<String> onChanged,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 32.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: _textPrimary,
              ),
            ),
            SizedBox(height: 12.h),
            ...options.map(
              (opt) => ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
                title: Text(
                  opt,
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    color: opt == current ? _accent : _textPrimary,
                    fontWeight: opt == current
                        ? FontWeight.w600
                        : FontWeight.w400,
                  ),
                ),
                trailing: opt == current
                    ? Icon(
                        CupertinoIcons.checkmark_alt,
                        color: _accent,
                        size: 18.sp,
                      )
                    : null,
                onTap: () {
                  onChanged(opt);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Helpers ────────────────────────────────────────────────────────────────
  Widget _sectionLabel(String text) => Text(
    text,
    style: GoogleFonts.poppins(
      fontSize: 13.sp,
      fontWeight: FontWeight.w600,
      color: _textSecondary,
      letterSpacing: 0.4,
    ),
  );

  Widget _iconBox(IconData icon, Color bg, Color color) => Container(
    padding: EdgeInsets.all(8.r),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(10.r),
    ),
    child: Icon(icon, size: 18.sp, color: color),
  );

  Widget _iconButton(IconData icon, {required VoidCallback onTap}) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, size: 20.sp, color: _textPrimary),
        ),
      );

  Widget _divider() => Divider(
    height: 1,
    thickness: 1,
    color: Colors.grey.shade100,
    indent: 54.w,
  );

  BoxDecoration _cardDecoration() => BoxDecoration(
    color: _card,
    borderRadius: BorderRadius.circular(20.r),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 12,
        offset: const Offset(0, 4),
      ),
    ],
  );
}
