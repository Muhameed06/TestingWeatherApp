import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class SettingsItem {
  SettingsItem(
      {required this.title, required this.background, required this.icon});

  String title;
  LinearGradient background;
  HugeIcon icon;
}

var settingsItem = [
  SettingsItem(
      title: "Change units",
      background: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF00AEFF),
          Color(0xFF0076FF),
        ],
      ),
      icon: const HugeIcon(
          icon: HugeIcons.strokeRoundedTemperature, color: Colors.white)),
];
