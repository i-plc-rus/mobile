import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mixkage_sber_code/api/service/user_settings_cloud_interface.dart';
import 'package:mixkage_sber_code/common/config/config.dart';
import 'package:mixkage_sber_code/common/shared/l10n/l10n_bloc.dart';
import 'package:mixkage_sber_code/common/shared/theme/theme_bloc.dart';
import 'package:mixkage_sber_code/common/snackbar/bloc/snackbar_cubit.dart';
import 'package:mixkage_sber_code/common/snackbar/custom_snackbar.dart';
import 'package:mixkage_sber_code/common/theme/app_theme_data.dart';
import 'package:mixkage_sber_code/feature/settings_screen/bloc/email/checkbox/email_notify_cubit.dart';
import 'package:mixkage_sber_code/feature/settings_screen/bloc/email/textfield/email_value_cubit.dart';
import 'package:mixkage_sber_code/feature/settings_screen/bloc/push/push_notify_cubit.dart';
import 'package:mixkage_sber_code/feature/settings_screen/bloc/sms/checkbox/sms_notify_cubit.dart';
import 'package:mixkage_sber_code/feature/settings_screen/bloc/sms/textfield/sms_value_cubit.dart';
import 'package:mixkage_sber_code/injection_container.dart';
import 'package:mixkage_sber_code/l10n/l10n.dart';
import 'package:mixkage_sber_code/routes/app_router.dart';

/// Класс, отвечающий за работу всего приложения. Точка входа
class MixKageApp extends StatefulWidget {
  const MixKageApp({
    super.key,
  });

  @override
  State<MixKageApp> createState() => _MixKageAppState();
}

/// Глобальное состояние всего приложения
class _MixKageAppState extends State<MixKageApp> {
  @override
  Widget build(final BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<ThemeBloc>(
            create: (final context) => ThemeBloc()
              ..add(
                const ThemeLoadSaved(),
              ),
          ),
          BlocProvider<L10nBloc>(
            create: (final context) => L10nBloc()
              ..add(
                const L10nLoadSaved(),
              ),
          ),
          BlocProvider<SnackBarNotifyCubit>(
            create: (final context) => SnackBarNotifyCubit(),
          ),
          BlocProvider(
            create: (final context) =>
                SmsNotifyCheckBoxCubit(getIt<InternetService>()),
          ),
          BlocProvider(
            create: (final context) => SmsValueCubit(getIt<InternetService>()),
          ),
          BlocProvider(
            create: (final context) =>
                EmailNotifyCheckBoxCubit(getIt<InternetService>()),
          ),
          BlocProvider(
            create: (final context) =>
                EmailValueCubit(getIt<InternetService>()),
          ),
          BlocProvider(
            create: (final context) =>
                PushNotifyCheckBoxCubit(getIt<InternetService>()),
          ),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (final context, final themeState) =>
              BlocBuilder<L10nBloc, L10nState>(
            builder: (final context, final l10nState) =>
                BlocListener<SnackBarNotifyCubit, SnackBarNotifyState>(
              listener: (final context, final state) {
                if (state is ShowSnackBarState) {
                  CustomSnackbar.showSnackBar(context, state.message);
                }
              },
              child: MaterialApp.router(
                supportedLocales: S.delegate.supportedLocales,
                locale: l10nState.locale,
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                routeInformationParser: AppRouter.router.routeInformationParser,
                routerDelegate: AppRouter.router.routerDelegate,
                routeInformationProvider:
                    AppRouter.router.routeInformationProvider,
                theme: AppThemeData.lightTheme,
                darkTheme: AppThemeData.darkTheme,
                themeMode: themeState.activeTheme,
                debugShowCheckedModeBanner: Config.environmentFlavor.isDebug,
              ),
            ),
          ),
        ),
        // ),
      );
}
