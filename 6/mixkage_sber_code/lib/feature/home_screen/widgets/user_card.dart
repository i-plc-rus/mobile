import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mixkage_sber_code/common/theme/app_color_scheme.dart';
import 'package:mixkage_sber_code/common/theme/app_text_scheme.dart';
import 'package:mixkage_sber_code/common/utils/column_extenshion.dart';
import 'package:mixkage_sber_code/common/utils/row_extenshion.dart';
import 'package:mixkage_sber_code/feature/settings_screen/bloc/email/checkbox/email_notify_cubit.dart';
import 'package:mixkage_sber_code/feature/settings_screen/bloc/email/textfield/email_value_cubit.dart';
import 'package:mixkage_sber_code/feature/settings_screen/bloc/push/push_notify_cubit.dart';
import 'package:mixkage_sber_code/feature/settings_screen/bloc/sms/checkbox/sms_notify_cubit.dart';
import 'package:mixkage_sber_code/feature/settings_screen/bloc/sms/textfield/sms_value_cubit.dart';
import 'package:shimmer/shimmer.dart';

class UserCard extends StatefulWidget {
  const UserCard({super.key});

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  void initState() {
    initAllData();
    super.initState();
  }

  void initAllData() {
    context.read<SmsValueCubit>().getValue();
    context.read<EmailValueCubit>().getValue();
  }

  @override
  Widget build(final BuildContext context) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColorScheme.of(context).surfaceSecondary,
            Colors.green[700]!,
          ],
        ),
      ),
      constraints: const BoxConstraints(
          minWidth: 350, maxWidth: 400, minHeight: 160, maxHeight: 180,),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<EmailValueCubit, EmailValueState>(
              builder: (final context, final state) {
                if (state is LoadedValueEmailState) {
                  return Text(state.email,
                      style: AppTextScheme.of(context).headline,);
                } else {
                  return Shimmer.fromColors(
                    //TODO: LOCALE
                    baseColor: AppColorScheme.of(context).shimmer,
                    highlightColor: Colors.black,
                    //TODO: LOCALE
                    child: Text('Loading...',
                        style: AppTextScheme.of(context).headline,),
                  );
                }
              },
            ),
            BlocBuilder<SmsValueCubit, SmsValueState>(
              builder: (final context, final state) {
                if (state is LoadedValueSmsState) {
                  return Text(state.number,
                      style: AppTextScheme.of(context).headline,);
                } else {
                  return Shimmer.fromColors(
                    //TODO: LOCALE
                    baseColor: AppColorScheme.of(context).shimmer,
                    highlightColor: Colors.black,
                    //TODO: LOCALE
                    child: Text('Loading...',
                        style: AppTextScheme.of(context).headline,),
                  );
                }
              },
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocBuilder<PushNotifyCheckBoxCubit, PushNotifyState>(
                  builder: (final context, final state) {
                    if (state is LoadedPushState) {
                      return Icon(
                        state.isEnable
                            ? Icons.notifications_active
                            : Icons.notifications_none,
                        size: 30,
                      );
                    }
                    return Shimmer.fromColors(
                        //TODO: LOCALE
                        baseColor: AppColorScheme.of(context).shimmer,
                        highlightColor: Colors.black,
                        //TODO: LOCALE
                        child: const Icon(
                          Icons.notifications_active,
                          size: 30,
                        ),);
                  },
                ),
                BlocBuilder<SmsNotifyCheckBoxCubit, SmsNotifyState>(
                  builder: (final context, final state) {
                    if (state is LoadedSmsState) {
                      return Icon(
                        state.isEnable ? Icons.message : Icons.message_outlined,
                        size: 30,
                      );
                    }
                    return Shimmer.fromColors(
                        //TODO: LOCALE
                        baseColor: AppColorScheme.of(context).shimmer,
                        highlightColor: Colors.black,
                        //TODO: LOCALE
                        child: const Icon(
                          Icons.message,
                          size: 30,
                        ),);
                  },
                ),
                BlocBuilder<EmailNotifyCheckBoxCubit, EmailNotifyState>(
                  builder: (final context, final state) {
                    if (state is LoadedEmailState) {
                      return Icon(
                        state.isEnable ? Icons.email : Icons.email_outlined,
                        size: 30,
                      );
                    }
                    return Shimmer.fromColors(
                        //TODO: LOCALE
                        baseColor: AppColorScheme.of(context).shimmer,
                        highlightColor: Colors.black,
                        //TODO: LOCALE
                        child: const Icon(
                          Icons.message,
                          size: 30,
                        ),);
                  },
                ),
              ],
            ).withSpacing(8),
          ],
        ).withSpacing(8),
      ),
    );
}
