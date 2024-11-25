import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mixkage_sber_code/common/theme/app_color_scheme.dart';
import 'package:mixkage_sber_code/common/theme/app_text_scheme.dart';
import 'package:mixkage_sber_code/feature/home_screen/screens/home_screen_content.dart';
import 'package:mixkage_sber_code/routes/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                'Home',
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
                icon: const Icon(Icons.settings),
                onPressed: () => context.pushNamed(Routes.settings.toName),
              ),
            ],
          ),
          const HomeScreenContent(),
        ],
      ),
    );
}
