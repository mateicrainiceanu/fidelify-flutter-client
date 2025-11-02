import 'package:fidelify_client/models/tab_item.dart';
import 'package:fidelify_client/providers/app_preferences_provider.dart';
import 'package:fidelify_client/screens/dash/user/user_menu.dart';
import 'package:fidelify_client/screens/simple_loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:fidelify_client/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class Dash extends StatefulWidget {
  const Dash({super.key});

  @override
  State<Dash> createState() => _DashState();
}

class _DashState extends State<Dash> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final appPrefProv = context.watch<AppPreferencesProvider>();

    final List<TabItem> tabData = [
      TabItem(
        label: "home",
        title: l10n.home,
        icon: const Icon(Icons.home),
        widget: const Center(child: Text("Hello")),
      ),
      if (true)
        TabItem(
          label: "businesses",
          title: l10n.myShops,
          icon: const Icon(Icons.store_rounded),
          widget: const Center(child: Text("Hello")),
        ),
      TabItem(
        label: "user",
        title: l10n.user,
        icon: const Icon(Icons.person),
        widget: const UserMenu(),
      ),
    ];

    return PopScope(
        canPop: false,
        child: !appPrefProv.initialized
            ? const SimpleLoadingScreen()
            : Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  title: Text(tabData[_selectedIndex].title),
                ),
                body: tabData[_selectedIndex].widget,
                bottomNavigationBar: BottomNavigationBar(
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  currentIndex: _selectedIndex,
                  iconSize: 30,
                  elevation: 0,
                  type: BottomNavigationBarType.fixed,
                  onTap: _onItemTapped,
                  items: tabData
                      .map((item) => BottomNavigationBarItem(
                            label: item.title,
                            icon: item.icon,
                          ))
                      .toList(),
                ),
              ));
  }
}
