import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef ScrollControllerBuilder =
    Widget Function(
      BuildContext context,
      ScrollController controller,
      ValueListenable<double> progressListenable,
      ValueListenable<bool> showScrollToTopListenable,
      Future<void> Function() scrollToTop,
    );

class ScrollControllerProvider extends StatefulWidget {
  final ScrollControllerBuilder builder;
  const ScrollControllerProvider({super.key, required this.builder});

  @override
  State<ScrollControllerProvider> createState() =>
      _ScrollControllerProviderState();
}

class _ScrollControllerProviderState extends State<ScrollControllerProvider> {
  final ScrollController _controller = ScrollController();
  final ValueNotifier<double> _progress = ValueNotifier<double>(0.0);
  final ValueNotifier<bool> _show = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    final max = _controller.hasClients
        ? _controller.position.maxScrollExtent
        : 0;
    final progress = (max <= 0)
        ? 0.0
        : (_controller.offset / max).clamp(0.0, 1.0);
    final show = _controller.offset > 200;

    // throttle small updates
    if ((progress - _progress.value).abs() > 0.005) {
      _progress.value = progress;
    }
    if (show != _show.value) {
      _show.value = show;
    }
  }

  Future<void> _scrollToTop() async {
    if (!_controller.hasClients) return;
    await _controller.animateTo(
      0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_onScroll);
    _controller.dispose();
    _progress.dispose();
    _show.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _controller, _progress, _show, _scrollToTop);
  }
}
