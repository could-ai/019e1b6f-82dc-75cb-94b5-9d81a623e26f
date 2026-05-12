import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const UrbanFoundryApp());
}

class UrbanFoundryApp extends StatelessWidget {
  const UrbanFoundryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Urban Foundry',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F0F0F),
        primaryColor: const Color(0xFFB8860B), // Deep Bronze
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFB8860B),
          secondary: Color(0xFF2C2C2C), // Charcoal
          surface: Color(0xFF1A1A1A),
        ),
        textTheme: TextTheme(
          displayLarge: GoogleFonts.playfairDisplay(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
          displayMedium: GoogleFonts.playfairDisplay(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          headlineLarge: GoogleFonts.playfairDisplay(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: GoogleFonts.lato(
            color: Colors.white70,
          ),
          bodyMedium: GoogleFonts.lato(
            color: Colors.white60,
          ),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainWebScreen(),
      },
    );
  }
}

class MainWebScreen extends StatefulWidget {
  const MainWebScreen({super.key});

  @override
  State<MainWebScreen> createState() => _MainWebScreenState();
}

class _MainWebScreenState extends State<MainWebScreen> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _menuKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _reservationsKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.8),
        elevation: 0,
        title: Text(
          'THE URBAN FOUNDRY',
          style: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: const Color(0xFFB8860B),
          ),
        ),
        centerTitle: !isDesktop,
        actions: isDesktop
            ? [
                _NavBarItem(title: 'About', onTap: () => _scrollTo(_aboutKey)),
                _NavBarItem(title: 'Menu', onTap: () => _scrollTo(_menuKey)),
                _NavBarItem(title: 'Experience', onTap: () => _scrollTo(_experienceKey)),
                _NavBarItem(title: 'Reservations', onTap: () => _scrollTo(_reservationsKey)),
                const SizedBox(width: 20),
              ]
            : null,
      ),
      drawer: isDesktop
          ? null
          : Drawer(
              backgroundColor: const Color(0xFF0F0F0F),
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  const SizedBox(height: 40),
                  _NavBarItem(title: 'About', onTap: () { Navigator.pop(context); _scrollTo(_aboutKey); }),
                  _NavBarItem(title: 'Menu', onTap: () { Navigator.pop(context); _scrollTo(_menuKey); }),
                  _NavBarItem(title: 'Experience', onTap: () { Navigator.pop(context); _scrollTo(_experienceKey); }),
                  _NavBarItem(title: 'Reservations', onTap: () { Navigator.pop(context); _scrollTo(_reservationsKey); }),
                ],
              ),
            ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            HeroSection(key: _heroKey, onReserve: () => _scrollTo(_reservationsKey)),
            AboutSection(key: _aboutKey),
            MenuSection(key: _menuKey),
            ExperienceSection(key: _experienceKey),
            ReservationSection(key: _reservationsKey),
            const FooterSection(),
          ],
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _NavBarItem({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          title.toUpperCase(),
          style: GoogleFonts.lato(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// SECTIONS
// -----------------------------------------------------------------------------

class HeroSection extends StatelessWidget {
  final VoidCallback onReserve;
  const HeroSection({super.key, required this.onReserve});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 800;

    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          // Replace with real asset/URL later
          image: NetworkImage('https://images.unsplash.com/photo-1514933651103-005eec06c04b?auto=format&fit=crop&q=80&w=2000'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        color: Colors.black.withOpacity(0.6), // Dark overlay
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'THE URBAN FOUNDRY',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: isDesktop ? 80 : 48,
                        letterSpacing: 8,
                        color: const Color(0xFFB8860B),
                      ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Where Food, Music & Nightlife Collide',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontStyle: FontStyle.italic,
                        letterSpacing: 2,
                        color: Colors.white70,
                      ),
                ),
                const SizedBox(height: 48),
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  alignment: WrapAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: onReserve,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFB8860B),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        textStyle: GoogleFonts.lato(fontWeight: FontWeight.bold, letterSpacing: 2),
                      ),
                      child: const Text('RESERVE A TABLE'),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        textStyle: GoogleFonts.lato(fontWeight: FontWeight.bold, letterSpacing: 2),
                      ),
                      child: const Text('VIEW MENU'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : 24,
        vertical: 80,
      ),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Flex(
        direction: isDesktop ? Axis.horizontal : Axis.vertical,
        children: [
          Expanded(
            flex: isDesktop ? 1 : 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'OUR STORY',
                  style: GoogleFonts.lato(
                    color: const Color(0xFFB8860B),
                    letterSpacing: 4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Forging Unforgettable Evenings in Baner.',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 24),
                Text(
                  'The Urban Foundry is Pune\'s premium industrial-themed destination. We blend innovative mixology, global culinary masterpieces, and high-energy nightlife into a singular immersive experience. With an aesthetic that pays homage to raw industrial materials layered with luxurious accents, we set the stage for epic nights out.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.8),
                ),
              ],
            ),
          ),
          if (isDesktop) const SizedBox(width: 80),
          if (!isDesktop) const SizedBox(height: 40),
          Expanded(
            flex: isDesktop ? 1 : 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?auto=format&fit=crop&q=80&w=1000',
                height: 400,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuSection extends StatelessWidget {
  const MenuSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      color: const Color(0xFF141414),
      child: Column(
        children: [
          Text(
            'CULINARY & MIXOLOGY',
            style: GoogleFonts.lato(
              color: const Color(0xFFB8860B),
              letterSpacing: 4,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'A Taste of Foundry',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 800 ? 3 : (constraints.maxWidth > 500 ? 2 : 1);
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 24,
                crossAxisSpacing: 24,
                childAspectRatio: 0.8,
                children: const [
                  _MenuCard(
                    title: 'Signature Cocktails',
                    image: 'https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?auto=format&fit=crop&q=80&w=800',
                    desc: 'Expertly crafted drinks with premium spirits.',
                  ),
                  _MenuCard(
                    title: 'Global Tapas',
                    image: 'https://images.unsplash.com/photo-1541518763669-27fef04b14ea?auto=format&fit=crop&q=80&w=800',
                    desc: 'Elevated small plates perfect for sharing.',
                  ),
                  _MenuCard(
                    title: 'Fine Dining',
                    image: 'https://images.unsplash.com/photo-1414235077428-33898dd1444c?auto=format&fit=crop&q=80&w=800',
                    desc: 'Exquisite mains prepared by master chefs.',
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final String title;
  final String image;
  final String desc;

  const _MenuCard({required this.title, required this.image, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              child: Image.network(image, fit: BoxFit.cover),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: const Color(0xFFB8860B),
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    desc,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const NetworkImage('https://images.unsplash.com/photo-1566417713940-fe7c737a9ef2?auto=format&fit=crop&q=80&w=2000'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.darken),
        ),
      ),
      child: Column(
        children: [
          Text(
            'THE EXPERIENCE',
            style: GoogleFonts.lato(
              color: const Color(0xFFB8860B),
              letterSpacing: 4,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Nightlife, Reimagined.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: 600,
            child: Text(
              'From high-energy DJ sets to exclusive live music events, The Urban Foundry is Baner\'s beating heart of nightlife. Step into a world of rhythm, lights, and luxury.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.8),
            ),
          ),
        ],
      ),
    );
  }
}

class ReservationSection extends StatelessWidget {
  const ReservationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : 24,
        vertical: 80,
      ),
      color: const Color(0xFF0F0F0F),
      child: Flex(
        direction: isDesktop ? Axis.horizontal : Axis.vertical,
        children: [
          Expanded(
            flex: isDesktop ? 1 : 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BOOKINGS',
                  style: GoogleFonts.lato(
                    color: const Color(0xFFB8860B),
                    letterSpacing: 4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Reserve Your Table',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 24),
                Text(
                  'Ensure your spot at The Urban Foundry. For large gatherings or VIP sections, please contact us directly via WhatsApp.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 40),
                OutlinedButton.icon(
                  onPressed: () {}, // WhatsApp integration
                  icon: const Icon(Icons.chat_bubble_outline),
                  label: const Text('BOOK VIA WHATSAPP'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF25D366),
                    side: const BorderSide(color: Color(0xFF25D366)),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
                ),
              ],
            ),
          ),
          if (isDesktop) const SizedBox(width: 80),
          if (!isDesktop) const SizedBox(height: 40),
          Expanded(
            flex: isDesktop ? 1 : 0,
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFF2C2C2C)),
              ),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                      filled: true,
                      fillColor: Colors.black,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Date & Time',
                      filled: true,
                      fillColor: Colors.black,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Guests',
                      filled: true,
                      fillColor: Colors.black,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFB8860B),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: GoogleFonts.lato(fontWeight: FontWeight.bold, letterSpacing: 1.5),
                      ),
                      child: const Text('REQUEST RESERVATION'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      child: Column(
        children: [
          Text(
            'THE URBAN FOUNDRY',
            style: GoogleFonts.playfairDisplay(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 4,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            '1, Balewadi High St, Laxman Nagar, Baner, Pune, Maharashtra 411045',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Text(
            '+91 99999 99999  |  info@theurbanfoundry.com',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xFFB8860B)),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.facebook, color: Colors.white54)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.camera_alt, color: Colors.white54)),
            ],
          ),
          const SizedBox(height: 40),
          Text(
            '© ${DateTime.now().year} The Urban Foundry. All Rights Reserved.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white30),
          ),
        ],
      ),
    );
  }
}
