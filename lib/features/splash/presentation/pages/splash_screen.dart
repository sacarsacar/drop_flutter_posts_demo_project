// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;
  late final Animation<double> _opacityAnim;
  late final Animation<Offset> _slideAnim;

  // Overlay controller for smooth navigation fade:
  late final AnimationController _overlayController;
  late final Animation<double> _overlayAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    final curved = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    _scaleAnim = Tween<double>(begin: 0.7, end: 1.0).animate(curved);
    _opacityAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.6)),
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(curved);

    // overlay used to fade into next route smoothly:
    _overlayController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );
    _overlayAnim = CurvedAnimation(
      parent: _overlayController,
      curve: Curves.easeIn,
    );

    // when splash animation finishes, run overlay fade then navigate:
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        _overlayController.forward();
      }
    });

    _overlayController.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        // final navigation after overlay fade completes:
        context.go('/');
      }
    });
    _controller.forward();

    // Safety navigation if animation stack doesn't finish for some reason.:
    Timer(
      _controller.duration! +
          _overlayController.duration! +
          const Duration(milliseconds: 400),
      () {
        if (mounted) context.go('/');
      },
    );
  }

  @override
  void dispose() {
    _overlayController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mq = MediaQuery.of(context);
    final width = mq.size.width;
    final logoSize = (width * 0.28).clamp(64.0, 160.0);
    final reducedMotion = mq.disableAnimations;

    // If reduced motion is requested, show static state and navigate quickly.:
    if (reducedMotion && _controller.status != AnimationStatus.completed) {
      _controller.value = 1.0;
      // skip overlay animation and navigate shortly:
      Timer(const Duration(milliseconds: 260), () {
        if (mounted) context.go('/');
      });
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary.withOpacity(0.12),
                  theme.colorScheme.secondary.withOpacity(0.06),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              child: Center(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _opacityAnim,
                      child: SlideTransition(
                        position: _slideAnim,
                        child: ScaleTransition(scale: _scaleAnim, child: child),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.all(logoSize * 0.18),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.primary.withOpacity(
                                0.18,
                              ),
                              blurRadius: 18,
                              offset: const Offset(0, 10),
                            ),
                          ],
                          border: Border.all(
                            color: theme.colorScheme.primary.withOpacity(0.06),
                          ),
                        ),
                        child: Icon(
                          Icons.flutter_dash,
                          size: logoSize,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 18),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: width * 0.75),
                        child: Text(
                          'Drop Flutter Posts',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Share minimal Flutter posts — fast.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.textTheme.bodyMedium?.color?.withOpacity(
                            0.9,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 56,
                        height: 6,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            color: theme.colorScheme.primary,
                            backgroundColor: theme.colorScheme.primary
                                .withOpacity(0.18),
                            minHeight: 6,
                            value: reducedMotion ? null : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // provide smooth fade overlay for navigation
          IgnorePointer(
            ignoring: true,
            child: FadeTransition(
              opacity: _overlayAnim,
              child: Container(color: theme.scaffoldBackgroundColor),
            ),
          ),
        ],
      ),
    );
  }
}
