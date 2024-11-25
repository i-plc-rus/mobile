import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mixkage_sber_code/common/notification_service/notification_service.dart';
import 'package:mixkage_sber_code/common/theme/app_color_scheme.dart';
import 'package:mixkage_sber_code/common/utils/column_extenshion.dart';
import 'package:mixkage_sber_code/feature/home_screen/widgets/user_card.dart';
import 'package:mixkage_sber_code/feature/settings_screen/bloc/email/checkbox/email_notify_cubit.dart';
import 'package:mixkage_sber_code/feature/settings_screen/bloc/push/push_notify_cubit.dart';
import 'package:mixkage_sber_code/feature/settings_screen/bloc/sms/checkbox/sms_notify_cubit.dart';
import 'package:mixkage_sber_code/feature/settings_screen/widgets/custom_section.dart';
import 'package:mixkage_sber_code/routes/routes.dart';
import 'package:motion/motion.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({super.key});

  @override
  State<HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  @override
  void initState() {
    initAllData();
    super.initState();
  }

  void initAllData() {
    context.read<SmsNotifyCheckBoxCubit>().getValue();
    context.read<EmailNotifyCheckBoxCubit>().getValue();
    context.read<PushNotifyCheckBoxCubit>().getValue();
  }

  Future<void> sendNotify() async {
    await NotificationService().sendNotification('title', 'body');
  }

  @override
  Widget build(final BuildContext context) => SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(22),
              child: Motion(child: UserCard()),
            ),
            CustomSection('Работа уведомлений', [
              SizedBox(
                width: double.infinity,
                child: BlocBuilder<PushNotifyCheckBoxCubit, PushNotifyState>(
                  builder: (final context, final state) {
                    if (state is LoadedPushState) {
                      return ElevatedButton(
                          onPressed: state.isEnable ? sendNotify : null,
                          child: const Text('Send PUSH'),);
                    }
                    return Shimmer.fromColors(
                        baseColor: AppColorScheme.of(context).shimmer,
                        highlightColor: Colors.grey,
                        child: ElevatedButton(
                            onPressed: () {}, child: const SizedBox(),),);
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: BlocBuilder<SmsNotifyCheckBoxCubit, SmsNotifyState>(
                  builder: (final context, final state) {
                    if (state is LoadedSmsState) {
                      return ElevatedButton(
                          onPressed: state.isEnable ? sendNotify : null,
                          child: const Text('Send SMS'),);
                    }
                    return Shimmer.fromColors(
                        baseColor: AppColorScheme.of(context).shimmer,
                        highlightColor: Colors.grey,
                        child: ElevatedButton(
                            onPressed: () {}, child: const SizedBox(),),);
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: BlocBuilder<EmailNotifyCheckBoxCubit, EmailNotifyState>(
                  builder: (final context, final state) {
                    if (state is LoadedEmailState) {
                      return ElevatedButton(
                          onPressed: state.isEnable ? sendNotify : null,
                          child: const Text('Send EMAIL'),);
                    }
                    return Shimmer.fromColors(
                        baseColor: AppColorScheme.of(context).shimmer,
                        highlightColor: Colors.grey,
                        child: ElevatedButton(
                            onPressed: () {}, child: const SizedBox(),),);
                  },
                ),
              ),
            ]),
            CustomSection('Открыть настройки', [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.pushNamed(Routes.settings.toName),
                  child: const Text('Открыть настройки'),
                ),
              ),
            ]),
            const SizedBox(
              height: 20,
            ),
          ],
        ).withSpacing(12),
      ),
    );
}

//return Container(
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(5),
    //     gradient: LinearGradient(
    //       begin: Alignment.topLeft,
    //       end: Alignment.bottomRight,
    //       colors: [
    //         AppColorScheme.of(context).surfaceSecondary,
    //         Colors.green[700]!
    //       ],
    //     ),
    //   ),
    //   constraints: const BoxConstraints(
    //       minWidth: 350, maxWidth: 400, minHeight: 160, maxHeight: 180),
    //   child: Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text('HEHEHE'),
    //         Text('HEHEHE'),
    //       ],
    //     ).withSpacing(8.0),
    //   ),
    // );
