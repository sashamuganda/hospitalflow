import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'core/theme.dart';
import 'core/router.dart';
import 'core/app_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MedFlowStaffApp());
}

class MedFlowStaffApp extends StatefulWidget {
  const MedFlowStaffApp({super.key});

  @override
  State<MedFlowStaffApp> createState() => _MedFlowStaffAppState();
}

class _MedFlowStaffAppState extends State<MedFlowStaffApp> {
  late final AppState _appState;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _appState = AppState();
    _router = createRouter(_appState);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppState>.value(
      value: _appState,
      child: MaterialApp.router(
        title: 'MedFlow Staff',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        routerConfig: _router,
      ),
    );
  }
}
