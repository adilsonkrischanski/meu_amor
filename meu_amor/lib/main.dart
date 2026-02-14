import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const ValentineApp());
}

class ValentineApp extends StatelessWidget {
  const ValentineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Happy Valentine's Day ❤️",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
        useMaterial3: true,
      ),
      home: const ValentinePage(),
    );
  }
}

class ValentinePage extends StatelessWidget {
  const ValentinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundGradient(),
          const HeartsAnimation(),
          const MainContent(),
        ],
      ),
    );
  }
}

class BackgroundGradient extends StatelessWidget {
  const BackgroundGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFFEEF3), Color(0xFFFFD6E0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}

class HeartsAnimation extends StatefulWidget {
  const HeartsAnimation({super.key});

  @override
  State<HeartsAnimation> createState() => _HeartsAnimationState();
}

class _HeartsAnimationState extends State<HeartsAnimation>
    with TickerProviderStateMixin {
  final Random random = Random();
  final int heartCount = 20;

  late List<AnimationController> controllers;
  late List<double> startPositions;
  late List<double> sizes;
  late List<double> speeds;

  @override
  void initState() {
    super.initState();

    controllers = List.generate(
      heartCount,
      (_) => AnimationController(
        vsync: this,
        duration: Duration(seconds: 6 + random.nextInt(6)),
      )..repeat(),
    );

    startPositions =
        List.generate(heartCount, (_) => random.nextDouble());

    sizes = List.generate(
        heartCount, (_) => 12 + random.nextDouble() * 18);

    speeds = List.generate(
        heartCount, (_) => random.nextDouble());
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;

    return Stack(
      children: List.generate(heartCount, (index) {
        return AnimatedBuilder(
          animation: controllers[index],
          builder: (_, child) {
            final progress = controllers[index].value;

            final top = progress * sizeScreen.height;
            final left =
                startPositions[index] * sizeScreen.width +
                    sin(progress * 2 * pi) * 20;

            return Positioned(
              top: top,
              left: left,
              child: Opacity(
                opacity: 1 - progress,
                child: Icon(
                  Icons.favorite,
                  color: Colors.pinkAccent.withOpacity(0.6),
                  size: sizes[index],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

class MainContent extends StatelessWidget {
  const MainContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                "assets/love.jpg",
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Happy Valentine's Day 💕",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Oii meuuu amooorr 💕\n\n"
              "Hoje ja fazemosss mtoss diass desde comecamosss a namorarr "
              "e cada diaaa que passa a gente tem mais eu tenho certezaa "
              "que tuu é a mulher da minha vidaaa ❤️\n\n"
              "Teee amoooooo pra sempreee ❤️❤️❤️❤️❤️❤️❤️❤️❤️",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
