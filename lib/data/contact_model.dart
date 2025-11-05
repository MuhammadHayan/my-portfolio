import 'package:flutter/material.dart';

class ContactModel {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  ContactModel({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
}
