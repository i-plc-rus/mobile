import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mixkage_sber_code/common/persistence/shared_preferences/active_theme/active_theme_storage.dart';
import 'package:mixkage_sber_code/common/shared/theme/theme_bloc.dart';
import 'package:mixkage_sber_code/common/snackbar/custom_snackbar.dart';
import 'package:mixkage_sber_code/common/theme/app_color_scheme.dart';
import 'package:mixkage_sber_code/common/utils/column_extenshion.dart';
import 'package:mixkage_sber_code/common/utils/list_of_widgets_extenshion.dart';
import 'package:mixkage_sber_code/feature/settings_screen/bloc/email/checkbox/email_notify_cubit.dart';
import 'package:mixkage_sber_code/feature/settings_screen/bloc/email/textfield/email_value_cubit.dart';
import 'package:mixkage_sber_code/feature/settings_screen/bloc/push/push_notify_cubit.dart';
import 'package:mixkage_sber_code/feature/settings_screen/bloc/sms/checkbox/sms_notify_cubit.dart';
import 'package:mixkage_sber_code/feature/settings_screen/bloc/sms/textfield/sms_value_cubit.dart';
import 'package:mixkage_sber_code/feature/settings_screen/widgets/custom_section.dart';
import 'package:mixkage_sber_code/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class SettingsScreenContent extends StatefulWidget {
  const SettingsScreenContent({super.key});

  @override
  State<SettingsScreenContent> createState() => _SettingsScreenContentState();
}

class _SettingsScreenContentState extends State<SettingsScreenContent> {
  late final TextEditingController emailController;
  late final TextEditingController phoneController;

  @override
  void initState() {
    emailController = TextEditingController();
    phoneController = TextEditingController();
    initAllData();
    super.initState();
  }

  void initAllData() {
    context.read<SmsNotifyCheckBoxCubit>().getValue();
    context.read<SmsValueCubit>().getValue();
    context.read<EmailNotifyCheckBoxCubit>().getValue();
    context.read<EmailValueCubit>().getValue();
    context.read<PushNotifyCheckBoxCubit>().getValue();
  }

  Future<void> syncButton() async {
    initAllData();
  }

  Future<void> changeTheme() async {
    final themeStorage = ActiveThemeStorage(getIt<SharedPreferences>());
    final bool isLight =
        ((await themeStorage.getActiveTheme()) ?? 'system') == 'light';

    if (mounted) {
      context.read<ThemeBloc>().add(
            ThemeSave(activeTheme: isLight ? ThemeMode.dark : ThemeMode.light),
          );
    }
  }

  Future<void> saveButton() async {
    await context.read<EmailValueCubit>().setValue(emailController.text);
    if (mounted) {
      await context.read<SmsValueCubit>().setValue(phoneController.text);
    }
  }

  @override
  Widget build(final BuildContext context) => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              const SizedBox(
                height: 22,
              ),
              //TODO: LOCATE IT
              CustomSection(
                'Уведомления',
                [
                  BlocConsumer<PushNotifyCheckBoxCubit, PushNotifyState>(
                    listener: (final context, final state) {
                      if (state is PushErrorState) {
                        final err = state.isCrit
                            ? 'Произошла критическая ошибка'
                            : 'Ошибка соединения с сервером. Данные обрабатываются локальным хранилищем';
                        CustomSnackbar.showSnackBar(context, err);
                      }
                    },
                    builder: (final context, final state) {
                      if (state is LoadedPushState) {
                        return SwitchListTile(
                          title: const Text(
                            'Enable Push Notifications',
                          ),
                          value: state.isEnable,
                          onChanged:
                              context.read<PushNotifyCheckBoxCubit>().setValue,
                        );
                      } else {
                        return Shimmer.fromColors(
                          baseColor: AppColorScheme.of(context).shimmer,
                          highlightColor: Colors.black,
                          child: SwitchListTile(
                            title: const Text(
                              'Enable Push Notifications',
                            ),
                            value: false,
                            onChanged: (final value) {},
                          ),
                        );
                      }
                    },
                  ),
                  BlocConsumer<SmsNotifyCheckBoxCubit, SmsNotifyState>(
                    listener: (final context, final state) {
                      if (state is SmsErrorState) {
                        final err = state.isCrit
                            ? 'Произошла критическая ошибка'
                            : 'Ошибка соединения с сервером. Данные обрабатываются локальным хранилищем';
                        CustomSnackbar.showSnackBar(context, err);
                      }
                    },
                    builder: (final context, final state) {
                      if (state is LoadedSmsState) {
                        return SwitchListTile(
                          title: const Text(
                            'Enable SMS Notifications',
                          ),
                          value: state.isEnable,
                          onChanged:
                              context.read<SmsNotifyCheckBoxCubit>().setValue,
                        );
                      } else {
                        return Shimmer.fromColors(
                          baseColor: AppColorScheme.of(context).shimmer,
                          highlightColor: Colors.black,
                          child: SwitchListTile(
                            title: const Text(
                              'Enable SMS Notifications',
                            ),
                            value: false,
                            onChanged: (final value) {},
                          ),
                        );
                      }
                    },
                  ),
                  BlocConsumer<EmailNotifyCheckBoxCubit, EmailNotifyState>(
                    listener: (final context, final state) {
                      if (state is EmailErrorState) {
                        final err = state.isCrit
                            ? 'Произошла критическая ошибка'
                            : 'Ошибка соединения с сервером. Данные обрабатываются локальным хранилищем';
                        CustomSnackbar.showSnackBar(context, err);
                      }
                    },
                    builder: (final context, final state) {
                      if (state is LoadedEmailState) {
                        return SwitchListTile(
                          title: const Text(
                            'Enable Email Notifications',
                          ),
                          value: state.isEnable,
                          onChanged:
                              context.read<EmailNotifyCheckBoxCubit>().setValue,
                        );
                      } else {
                        return Shimmer.fromColors(
                          baseColor: AppColorScheme.of(context).shimmer,
                          highlightColor: Colors.black,
                          child: SwitchListTile(
                            title: const Text(
                              'Enable Email Notifications',
                            ),
                            value: false,
                            onChanged: (final value) {},
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
              CustomSection(
                'Дополнительная информация',
                [
                  BlocConsumer<EmailValueCubit, EmailValueState>(
                    listener: (final context, final state) {
                      if (state is LoadedValueEmailState) {
                        emailController.text = state.email;
                      } else if (state is EmailValueErrorState) {
                        final err = state.isCrit
                            ? 'Произошла критическая ошибка'
                            : 'Ошибка соединения с сервером. Данные обрабатываются локальным хранилищем';
                        CustomSnackbar.showSnackBar(context, err);
                      }
                    },
                    builder: (final context, final state) {
                      if (state is LoadedValueEmailState) {
                        return TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your email',
                          ),
                        );
                      } else {
                        return Shimmer.fromColors(
                          baseColor: AppColorScheme.of(context).shimmer,
                          highlightColor: Colors.black,
                          child: Container(
                            height: 60,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.black12,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  BlocConsumer<SmsValueCubit, SmsValueState>(
                    listener: (final context, final state) {
                      if (state is LoadedValueSmsState) {
                        phoneController.text = state.number;
                      } else if (state is SmsValueErrorState) {
                        final err = state.isCrit
                            ? 'Произошла критическая ошибка'
                            : 'Ошибка соединения с сервером. Данные обрабатываются локальным хранилищем';
                        CustomSnackbar.showSnackBar(context, err);
                      }
                    },
                    builder: (final context, final state) {
                      if (state is LoadedValueSmsState) {
                        return TextField(
                          controller: phoneController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your number',
                          ),
                        );
                      } else {
                        return Shimmer.fromColors(
                          baseColor: AppColorScheme.of(context).shimmer,
                          highlightColor: Colors.black,
                          child: Container(
                            height: 60,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.black12,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: saveButton,
                      //TODO: LOCALE
                      child: const Text('Сохранить'),
                    ),
                  ),
                ].withSpacing(12),
              ),
              CustomSection(
                'Загрузить с облака',
                [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: syncButton,
                      //TODO: LOCALE
                      child: const Text('Загрузить данные'),
                    ),
                  ),
                ],
              ),
              CustomSection(
                'Тема приложения',
                [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: changeTheme,
                      //TODO: LOCALE
                      child: const Text('Сменить тему приложения'),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 30,
              ),
            ],
          ).withSpacing(12),
        ),
      );
}
