import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medium_uz/cubits/tabs/tabs_cubit.dart';
import 'package:medium_uz/presentation/tab/articles/articles_screen.dart';
import 'package:medium_uz/presentation/tab/profile/profile_screen.dart';
import 'package:medium_uz/presentation/tab/web/web_screen.dart';
import 'package:medium_uz/utils/colors/app_colors.dart';

class TabBox extends StatefulWidget {
  const TabBox({super.key});

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  List<Widget> screens = [];

  int currentIndex = 0;

  @override
  void initState() {
    screens = [
      const ArticlesScreen(),
      const WebsitesScreen(),
      const ProfileScreen(),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: context.watch<TabsCubit>().state,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: AppColors.white.withOpacity(0.6),
        selectedItemColor:  AppColors.white,
        backgroundColor: AppColors.c01851D,
        selectedLabelStyle: const TextStyle(fontFamily: "Sora"),
        unselectedLabelStyle: const TextStyle(fontFamily: "Sora"),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.article,size: 30,), label: "Article"),
          BottomNavigationBarItem(icon: Icon(Icons.web_outlined,size: 30,), label: "Web"),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle,size: 30,), label: "Profile"),
        ],
        currentIndex: context.watch<TabsCubit>().state,
        onTap: (index) {
          context.read<TabsCubit>().changeIndex(index);
        },
      ),
    );
  }
}
