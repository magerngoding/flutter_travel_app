import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_travel/features/destination/presentation/bloc/all_destination/all_destination_bloc.dart';
import 'package:flutter_travel/features/destination/presentation/bloc/search_destinaton/search_destination_bloc.dart';
import 'package:flutter_travel/features/destination/presentation/bloc/top_destination/top_destination_bloc.dart';
import 'package:flutter_travel/features/destination/presentation/cubit/dashboard_cubit.dart';
import 'package:flutter_travel/features/destination/presentation/pages/dashboard.dart';
import 'package:flutter_travel/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // untuk memastikan menginialisasi lagi package
  await initLocator();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => DashboardCubit(),
        ),
        BlocProvider(create: (_) => locator<AllDestinationBloc>()),
        BlocProvider(create: (_) => locator<TopDestinationBloc>()),
        BlocProvider(create: (_) => locator<SearchDestinationBloc>()),
      ],
      child: const MaterialApp(
        home: Dashboard(),
      ),
    );
  }
}
