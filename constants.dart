import 'package:flutter/material.dart';

// ─── Brand Colors ─────────────────────────────────────────────────────────────
class AppColors {
  static const Color primary       = Color(0xFF1A3A5C);
  static const Color navBackground = Color(0xFF0F2644);
  static const Color accent        = Color(0xFFC8A96E);
  static const Color background    = Color(0xFFF5F2EE);
  static const Color textDark      = Color(0xFF1A1A2E);
  static const Color textLight     = Color(0xFF6B7280);
}

// ─── Navigation Items ─────────────────────────────────────────────────────────
class NavItem {
  final String label;
  final String url;
  final IconData icon;
  final IconData activeIcon;

  const NavItem({
    required this.label,
    required this.url,
    required this.icon,
    required this.activeIcon,
  });
}

const List<NavItem> kNavItems = [
  NavItem(
    label: 'Gemeinde',
    url: 'https://echb-leipzig.de/',
    icon: Icons.home_outlined,
    activeIcon: Icons.home_rounded,
  ),
  NavItem(
    label: 'Gottesdienst',
    url: 'https://echb-leipzig.de/gottesdienste/',
    icon: Icons.church_outlined,
    activeIcon: Icons.church_rounded,
  ),
  NavItem(
    label: 'Glaube',
    url: 'https://echb-leipzig.de/glaubensbekenntnis/',
    icon: Icons.menu_book_outlined,
    activeIcon: Icons.menu_book_rounded,
  ),
  NavItem(
    label: 'Bibel',
    url: 'https://echb-leipzig.de/bibel-zu-verschenken/',
    icon: Icons.auto_stories_outlined,
    activeIcon: Icons.auto_stories_rounded,
  ),
  NavItem(
    label: 'Kontakt',
    url: 'https://echb-leipzig.de/kontakt/',
    icon: Icons.mail_outline_rounded,
    activeIcon: Icons.mail_rounded,
  ),
];
