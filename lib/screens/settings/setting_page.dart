import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rahal/screens/settings/provider/setting_provider.dart';

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
  late String _selectedTheme;

  @override
  void initState() {
    super.initState();
    final settingsProvider = Provider.of<SettingsProvider>(
      context,
      listen: false,
    );
    _selectedTheme = settingsProvider.currentThemeMode == ThemeMode.light
        ? 'Light'
        : settingsProvider.currentThemeMode == ThemeMode.dark
        ? 'Dark'
        : 'System Default';
  }

  // ── Build ─────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfileCard(theme: theme),
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
                    _buildLogoutButton(),
                    SizedBox(height: 8.h),
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
            ),
          ),
          const Spacer(),
          _iconButton(CupertinoIcons.bell, onTap: () {}),
        ],
      ),
    );
  }

  // ── Profile Card ───────────────────────────────────────────────────────────
  Widget _buildProfileCard({required ThemeData theme}) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: _cardDecoration(theme: theme),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundImage: const NetworkImage(
                  'https://i.pinimg.com/736x/6f/f0/f8/6ff0f878005d7059b0d85283438059f3.jpg',
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: const BoxDecoration(shape: BoxShape.circle),
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
                  'Ahmed Hegazy',
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'ahmedrady03@email.com',
                  style: GoogleFonts.poppins(fontSize: 12.sp),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(CupertinoIcons.map_pin_ellipse, size: 12.sp),
                    SizedBox(width: 4.w),
                    Text(
                      'Berlin, Germany',
                      style: GoogleFonts.poppins(
                        fontSize: 11.sp,

                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Icon(CupertinoIcons.chevron_right, size: 16.sp),
        ],
      ),
    );
  }

  // ── Preferences Card ───────────────────────────────────────────────────────
  Widget _buildPreferencesCard() {
    final theme = Theme.of(context);
    return Container(
      decoration: _cardDecoration(theme: theme),
      child: Column(
        children: [
          _buildPickerTile(
            icon: CupertinoIcons.globe,
            iconBg: const Color(0xFFE8F4FF),
            iconColor: const Color(0xFF4A90D9),
            title: 'Language',
            value: _selectedLanguage,
            options: ['English', 'German', 'Arabic'],
            onChanged: (val) => setState(() => _selectedLanguage = val),
          ),
          _divider(),
          _buildPickerTile(
            icon: CupertinoIcons.money_dollar_circle,
            iconBg: const Color(0xFFE8FFE8),
            iconColor: const Color(0xFF4CAF50),
            title: 'Currency',
            value: _selectedCurrency,
            options: ['USD – US Dollar', 'EUR – Euro', 'EGP – Egyptian Pound'],
            onChanged: (val) => setState(() => _selectedCurrency = val),
          ),
          _divider(),
          Consumer<SettingsProvider>(
            builder: (context, settingsProvider, _) {
              return _buildPickerTile(
                icon: CupertinoIcons.circle_lefthalf_fill,
                iconBg: const Color(0xFFF3E8FF),
                iconColor: const Color(0xFF9C27B0),
                title: 'Theme',
                value: _selectedTheme,
                options: const ['Light', 'Dark', 'System Default'],
                onChanged: (val) async {
                  setState(() => _selectedTheme = val);

                  switch (val) {
                    case 'Light':
                      settingsProvider.setThemeMode(ThemeMode.light);
                      break;
                    case 'Dark':
                      settingsProvider.setThemeMode(ThemeMode.dark);
                      break;
                    default:
                      settingsProvider.setThemeMode(ThemeMode.system);
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }

  // ── Notifications Card ─────────────────────────────────────────────────────
  Widget _buildNotificationsCard() {
    return Container(
      decoration: _cardDecoration(theme: Theme.of(context)),
      child: Column(
        children: [
          _buildToggleTile(
            icon: CupertinoIcons.bell_fill,
            iconBg: const Color(0xFFFFF3E8),
            iconColor: const Color(0xFFFF9800),
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
      decoration: _cardDecoration(theme: Theme.of(context)),
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
    final theme = Theme.of(context);
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
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade600,
                    ),
                  ),
              ],
            ),
          ),
          Transform.scale(
            scale: 0.85,
            child: CupertinoSwitch(
              value: value,
              activeColor: const Color(0xFFFF9800),
              onChanged: onChanged,
            ),
          ),
        ],
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
    required Function(String) onChanged,
  }) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () =>
          _showPicker(title, options, value, onChanged, Theme.of(context)),
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
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(width: 4.w),
            Icon(CupertinoIcons.chevron_right, size: 16.sp),
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
    ThemeData theme,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 32.h),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
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
                    color: opt == current
                        ? const Color(0xFFFF9800)
                        : const Color(0xFF555555),
                    fontWeight: opt == current
                        ? FontWeight.w600
                        : FontWeight.w400,
                  ),
                ),
                trailing: opt == current
                    ? Icon(
                        CupertinoIcons.checkmark_alt,
                        color: const Color(0xFFFF9800),
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
  Widget _sectionLabel(String text) {
    final theme = Theme.of(context);
    return Text(
      text,
      style: theme.textTheme.titleMedium?.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }

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
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(14.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(icon, size: 20.sp),
        ),
      );

  Widget _divider() => Divider(
    height: 1,
    thickness: 1,
    color: Colors.grey.shade100,
    indent: 54.w,
  );

  BoxDecoration _cardDecoration({required ThemeData theme}) => BoxDecoration(
    color: theme.cardColor,
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
