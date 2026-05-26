import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_theme.dart';
import '../../core/providers/settings_provider.dart';
import '../../shared/widgets/bottom_nav.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _page = 0;

  // ★ Ganti icon, titleKey, subtitleKey sesuai konten app Anda
  static const _slides = [
    _Slide(
      icon: CupertinoIcons.rocket_fill,
      titleKey: 'onboarding_1_title',
      subtitleKey: 'onboarding_1_subtitle',
    ),
    _Slide(
      icon: CupertinoIcons.bolt_fill,
      titleKey: 'onboarding_2_title',
      subtitleKey: 'onboarding_2_subtitle',
    ),
    _Slide(
      icon: CupertinoIcons.checkmark_seal_fill,
      titleKey: 'onboarding_3_title',
      subtitleKey: 'onboarding_3_subtitle',
    ),
  ];

  void _next() {
    if (_page < _slides.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _finish();
    }
  }

  void _finish() {
    context.read<SettingsProvider>().completeOnboarding();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MainNavigation()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<SettingsProvider>().locale;
    String s(String key) => AppStrings.get(key, locale);
    final isLast = _page == _slides.length - 1;
    final color = Theme.of(context).colorScheme.primary;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: AppTheme.spacingXs, right: AppTheme.spacingSm),
                child: TextButton(
                  onPressed: _finish,
                  child: Text(s('onboarding_skip')),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (i) => setState(() => _page = i),
                itemCount: _slides.length,
                itemBuilder: (_, i) => _SlidePage(slide: _slides[i], locale: locale),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingLg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(_slides.length, (i) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.only(right: 6),
                        width: i == _page ? 20 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: i == _page
                              ? color
                              : color.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                        ),
                      );
                    }),
                  ),
                  FilledButton(
                    onPressed: _next,
                    child: Text(isLast ? s('onboarding_start') : s('onboarding_next')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SlidePage extends StatelessWidget {
  final _Slide slide;
  final String locale;

  const _SlidePage({required this.slide, required this.locale});

  @override
  Widget build(BuildContext context) {
    String s(String key) => AppStrings.get(key, locale);
    final color = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingXl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(slide.icon, size: 56, color: color),
          ),
          const SizedBox(height: AppTheme.spacingXl),
          Text(
            s(slide.titleKey),
            style: Theme.of(context).textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppTheme.spacingMd),
          Text(
            s(slide.subtitleKey),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.6),
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _Slide {
  final IconData icon;
  final String titleKey;
  final String subtitleKey;

  const _Slide({
    required this.icon,
    required this.titleKey,
    required this.subtitleKey,
  });
}
