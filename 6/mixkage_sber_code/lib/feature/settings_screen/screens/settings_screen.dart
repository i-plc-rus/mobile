import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mixkage_sber_code/assets/resources.dart';
import 'package:mixkage_sber_code/common/theme/app_color_scheme.dart';
import 'package:mixkage_sber_code/common/theme/app_text_scheme.dart';
import 'package:mixkage_sber_code/feature/settings_screen/screens/settings_screen_content.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(final BuildContext context) => Scaffold(
      backgroundColor: AppColorScheme.of(context).surface,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar.large(
            //TODO: LOCALE IT
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                'Settings',
                style: AppTextScheme.of(context).settingsLabel,
                textAlign: TextAlign.start,
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: [
                      AppColorScheme.of(context).primary,
                      AppColorScheme.of(context).positive,
                    ],
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: SvgPicture.asset(
                  SvgIcons.githubIcon,
                  colorFilter: ColorFilter.mode(
                    AppColorScheme.of(context).onSurface,
                    BlendMode.srcIn,
                  ),
                ),
                onPressed: () async {
                  final Uri url =
                      Uri.parse('https://github.com/MixKage/mixkage_sber_code');
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    throw 'Could not launch //';
                  }
                },
              ),
            ],
          ),
          const SettingsScreenContent(),
        ],
      ),
    );
}
