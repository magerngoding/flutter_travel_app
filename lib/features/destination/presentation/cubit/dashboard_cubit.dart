// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_travel/features/destination/presentation/pages/home_page.dart';

class DashboardCubit extends Cubit<int> {
  DashboardCubit() : super((0));

  change(int i) => emit(i);

  final List menuDashboard = [
    ['Home', Icons.home, HomePage()],
    ['Near', Icons.near_me, Center(child: Text('Near'))],
    ['Favorite', Icons.favorite, Center(child: Text('Favorite'))],
    ['Profile', Icons.person, Center(child: Text('Profile'))],
  ];

  Widget get page => menuDashboard[state][2];
}
