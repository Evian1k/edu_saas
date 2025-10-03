import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/service_locator.dart';
import 'core/themes/app_theme.dart';
import 'core/router/app_router.dart';
import 'features/auth/bloc/auth_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(const EduSaasApp());
}

class EduSaasApp extends StatelessWidget {
  const EduSaasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => sl<AuthBloc>()),
      ],
      child: MaterialApp.router(
        title: 'EDU-SaaS',
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
