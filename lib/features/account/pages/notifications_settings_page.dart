import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/routes/routes.dart';
import '../../home/widgets/custom_bottom_nav_bar.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() => _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool generalNotifications = true;
  bool sound = true;
  bool vibrate = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      generalNotifications = prefs.getBool('generalNotifications') ?? true;
      sound = prefs.getBool('sound') ?? true;
      vibrate = prefs.getBool('vibrate') ?? false;
    });
  }

  Future<void> _saveSetting(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: Colors.grey[300],
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            _buildSettingItem(
              'General Notifications',
              generalNotifications,
                  (value) {
                setState(() => generalNotifications = value);
                _saveSetting('generalNotifications', value);
              },
            ),
            _buildDivider(),
            _buildSettingItem(
              'Sound',
              sound,
                  (value) {
                setState(() => sound = value);
                _saveSetting('sound', value);
              },
            ),
            _buildDivider(),
            _buildSettingItem(
              'Vibrate',
              vibrate,
                  (value) {
                setState(() => vibrate = value);
                _saveSetting('vibrate', value);
              },
            ),
          ],
        ),
      ),
          );
  }

  Widget _buildSettingItem(String title, bool value, Function(bool) onChanged) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
            _buildToggleSwitch(value, onChanged),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleSwitch(bool value, Function(bool) onChanged) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 50,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: value ? const Color(0xFF34C759) : Colors.grey[400],
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              left: value ? 22 : 2,
              top: 2,
              child: Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
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

  Widget _buildDivider() {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      height: 1,
      color: Colors.grey[300],
    );
  }
}
