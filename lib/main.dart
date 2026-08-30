import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// --- MODELS & STATE ---

enum UserRole { none, alishka, nigishka }

class UserProfile {
  final String name;
  final String pin;
  final Color themeBgPrimary;
  final Color themeBgSecondary;
  final Color accentColor;
  final String avatarUrl;
  final int wins;
  final int rating;
  final int duels;

  const UserProfile({
    required this.name,
    required this.pin,
    required this.themeBgPrimary,
    required this.themeBgSecondary,
    required this.accentColor,
    required this.avatarUrl,
    required this.wins,
    required this.rating,
    required this.duels,
  });
}

const alishkaProfile = UserProfile(
  name: 'АЛИШКА',
  pin: '0609',
  themeBgPrimary: Color(0xFF7B1FA2),
  themeBgSecondary: Color(0xFF4A148C),
  accentColor: Color(0xFFFF8C00),
  avatarUrl: 'https://i.imgur.com/83p8xXN.png', // Bald man avatar
  wins: 15,
  rating: 55,
  duels: 40,
);

const nigishkaProfile = UserProfile(
  name: 'НИГИШКА',
  pin: '0504',
  themeBgPrimary: Color(0xFFE64A19),
  themeBgSecondary: Color(0xFFBF360C),
  accentColor: Color(0xFFE1BEE7),
  avatarUrl: 'https://i.imgur.com/2Xy5O2w.png', // Ponytail woman avatar
  wins: 15,
  rating: 55,
  duels: 40,
);

final currentUserProvider = StateProvider<UserProfile?>((ref) => null);
final pinInputProvider = StateProvider<String>((ref) => '');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: 'https://your_supabase_url.supabase.co',
    anonKey: 'YOUR_SUPABASE_ANON_KEY',
  );
  
  runApp(const ProviderScope(child: GBoxApp()));
}

class GBoxApp extends StatelessWidget {
  const GBoxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'G BOX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        textTheme: GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme),
      ),
      home: const SplashScreen(),
    );
  }
}

// --- REUSABLE UI COMPONENTS ---

class SatinBackground extends StatelessWidget {
  final Color primaryColor;
  final Color secondaryColor;
  final Widget child;

  const SatinBackground({
    super.key,
    required this.primaryColor,
    required this.secondaryColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(-0.2, -0.4),
          radius: 1.2,
          colors: [
            primaryColor,
            secondaryColor,
            const Color(0xFF111111),
          ],
          stops: const [0.0, 0.7, 1.0],
        ),
      ),
      child: SafeArea(child: child),
    );
  }
}

class VelvetPillow extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;

  const VelvetPillow({
    super.key,
    required this.child,
    this.onTap,
    this.width,
    this.height,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    this.borderRadius = const BorderRadius.all(Radius.circular(28)),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF2C2C2C),
              Color(0xFF181818),
              Color(0xFF0D0D0D),
            ],
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black80,
              blurRadius: 18,
              spreadRadius: 2,
              offset: Offset(0, 10),
            ),
            BoxShadow(
              color: Color(0x33FFFFFF),
              blurRadius: 4,
              spreadRadius: -2,
              offset: Offset(-2, -2),
            ),
          ],
          border: Border.all(
            color: const Color(0xFF333333),
            width: 1.5,
          ),
        ),
        child: Center(child: child),
      ),
    );
  }
}

// --- SCREENS ---

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SatinBackground(
        primaryColor: const Color(0xFFFFD54F),
        secondaryColor: const Color(0xFFFFA000),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              VelvetPillow(
                height: 140,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'G BOX',
                      style: GoogleFonts.montserrat(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
              const VelvetPillow(
                width: 70,
                height: 70,
                borderRadius: BorderRadius.all(Radius.circular(35)),
                child: Icon(Icons.home_rounded, color: Colors.white, size: 32),
              ),
              VelvetPillow(
                child: Column(
                  children: [
                    Text(
                      'АЛИШКА  ★  НИГИШКА',
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'СЕМЬЯ ДОРОЖЕ ВСЕГО',
                      style: GoogleFonts.montserrat(
                        fontSize: 11,
                        color: Colors.white70,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              VelvetPillow(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
                borderRadius: const BorderRadius.all(Radius.circular(40)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.touch_app, color: Colors.white, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'TAP TO START',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  void _handleKeyPress(WidgetRef ref, String val, BuildContext context) {
    final current = ref.read(pinInputProvider);
    if (val == '<') {
      if (current.isNotEmpty) {
        ref.read(pinInputProvider.notifier).state = current.substring(0, current.length - 1);
      }
    } else if (current.length < 4) {
      final updated = current + val;
      ref.read(pinInputProvider.notifier).state = updated;

      if (updated == '0609') {
        ref.read(currentUserProvider.notifier).state = alishkaProfile;
        _navigateToPush(context);
      } else if (updated == '0504') {
        ref.read(currentUserProvider.notifier).state = nigishkaProfile;
        _navigateToPush(context);
      } else if (updated.length == 4) {
        Future.delayed(const Duration(milliseconds: 300), () {
          ref.read(pinInputProvider.notifier).state = '';
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('НЕВЕРНЫЙ PIN КОД')),
          );
        });
      }
    }
  }

  void _navigateToPush(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const PushScreen()),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pin = ref.watch(pinInputProvider);

    return Scaffold(
      body: SatinBackground(
        primaryColor: const Color(0xFFFFD54F),
        secondaryColor: const Color(0xFFFFA000),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              VelvetPillow(
                child: Column(
                  children: [
                    Text(
                      'G BOX',
                      style: GoogleFonts.montserrat(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ВВЕДИ PIN',
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  final isFilled = index < pin.length;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: VelvetPillow(
                      width: 50,
                      height: 50,
                      padding: EdgeInsets.zero,
                      borderRadius: BorderRadius.circular(25),
                      child: isFilled
                          ? Container(
                              width: 14,
                              height: 14,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  );
                }),
              ),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.2,
                children: [
                  ...['1', '2', '3', '4', '5', '6', '7', '8', '9'].map(
                    (num) => VelvetPillow(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () => _handleKeyPress(ref, num, context),
                      child: Text(
                        num,
                        style: GoogleFonts.montserrat(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox.shrink(),
                  VelvetPillow(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () => _handleKeyPress(ref, '0', context),
                    child: Text(
                      '0',
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  VelvetPillow(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () => _handleKeyPress(ref, '<', context),
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PushScreen extends ConsumerWidget {
  const PushScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider) ?? alishkaProfile;

    return Scaffold(
      body: SatinBackground(
        primaryColor: user.themeBgPrimary,
        secondaryColor: user.themeBgSecondary,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                VelvetPillow(
                  height: 160,
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const MainMenuScreen()),
                    );
                  },
                  child: Text(
                    'PUSH',
                    style: GoogleFonts.montserrat(
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 4,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                VelvetPillow(
                  child: Text(
                    user.name,
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: user.accentColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MainMenuScreen extends ConsumerWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider) ?? alishkaProfile;

    return Scaffold(
      body: SatinBackground(
        primaryColor: user.themeBgPrimary,
        secondaryColor: user.themeBgSecondary,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  VelvetPillow(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const ProfileScreen()),
                      );
                    },
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    child: Row(
                      children: [
                        const Icon(Icons.person, color: Colors.amber, size: 20),
                        const SizedBox(width: 6),
                        Text(
                          'ПРОФИЛЬ',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: user.accentColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  VelvetPillow(
                    onTap: () {
                      ref.read(pinInputProvider.notifier).state = '';
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    child: Row(
                      children: [
                        const Icon(Icons.exit_to_app, color: Colors.redAccent, size: 20),
                        const SizedBox(width: 6),
                        Text(
                          'ВЫХОД',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: user.accentColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              VelvetPillow(
                child: Text(
                  user.name,
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: user.accentColor,
                  ),
                ),
              ),
              const Spacer(),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.1,
                children: [
                  _buildMenuPillow('КТО ЛУЧШЕ\nЗНАЕТ?', user.accentColor),
                  _buildMenuPillow('СЛУЧАЙНОЕ\nЗАДАНИЕ', user.accentColor),
                  _buildMenuPillow('НАШИ\nВОПРОСЫ ?', user.accentColor),
                  _buildMenuPillow('УГАДАЙ\nМЕНЯ', user.accentColor),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuPillow(String text, Color accent) {
    return VelvetPillow(
      onTap: () {},
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w900,
          color: accent,
          height: 1.2,
        ),
      ),
    );
  }
}

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider) ?? alishkaProfile;

    return Scaffold(
      body: SatinBackground(
        primaryColor: user.themeBgPrimary,
        secondaryColor: user.themeBgSecondary,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: VelvetPillow(
                      child: Text(
                        'ВАШ ПРОФИЛЬ',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: user.accentColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  VelvetPillow(
                    width: 50,
                    height: 50,
                    padding: EdgeInsets.zero,
                    borderRadius: BorderRadius.circular(25),
                    child: Icon(Icons.settings, color: user.accentColor),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Donut Avatar Frame
              Container(
                width: 180,
                height: 180,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFF2C2C2C), Color(0xFF0D0D0D)],
                  ),
                  boxShadow: [
                    BoxShadow(color: Colors.black90, blurRadius: 20, offset: Offset(0, 10)),
                  ],
                ),
                child: ClipOval(
                  child: Container(
                    color: Colors.amber.shade100,
                    child: Icon(
                      Icons.person,
                      size: 90,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              VelvetPillow(
                child: Text(
                  user.name,
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: user.accentColor,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: VelvetPillow(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.bolt, color: user.accentColor, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            'ПОБЕД: ${user.wins}',
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: user.accentColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: VelvetPillow(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.emoji_events, color: user.accentColor, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            'РЕЙТИНГ: ${user.rating}%',
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: user.accentColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              VelvetPillow(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite, color: user.accentColor, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      'СЫГРАНО ДУЭЛЕЙ: ${user.duels}',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: user.accentColor,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              VelvetPillow(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Row(
                        children: [
                          const Icon(Icons.flash_on, color: Colors.white, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            'СЫГРАТЬ СНОВА',
                            style: GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(width: 1, height: 20, color: Colors.white24),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => const MainMenuScreen()),
                          (route) => false,
                        );
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.home, color: Colors.white, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            'ГЛАВНОЕ МЕНЮ',
                            style: GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
