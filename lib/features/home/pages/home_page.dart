import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/home/widgets/playing_around.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isDisposed = false;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!mounted) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!mounted || _isDisposed) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return const PlayingAround();
  }
}
