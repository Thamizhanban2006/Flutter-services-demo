import 'package:flutter/material.dart';
import 'screen.dart'; // We will create this file next

void main() {
  runApp(const FlexiFitApp());
}

class FlexiFitApp extends StatelessWidget {
  const FlexiFitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlexiFit',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212), // Deep Charcoal
        primaryColor: const Color(0xFFCCFF00), // Electric Lime
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFCCFF00),
          secondary: Color(0xFF4A90E2),
          surface: Color(0xFF1E1E1E),
        ),
        useMaterial3: true,
        fontFamily: 'Roboto', // Default font
      ),
      home: const ResponsiveShell(),
    );
  }
}

class ResponsiveShell extends StatefulWidget {
  const ResponsiveShell({super.key});

  @override
  State<ResponsiveShell> createState() => _ResponsiveShellState();
}

class _ResponsiveShellState extends State<ResponsiveShell> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const WorkoutLibraryScreen(),
    const ProgressScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // Use LayoutBuilder to check screen width
    return LayoutBuilder(
      builder: (context, constraints) {
        // If width is > 600, we consider it a Tablet/Web view
        bool isWideScreen = constraints.maxWidth > 800;

        return Scaffold(
          body: Row(
            children: [
              // SIDEBAR (Only visible on Wide Screens)
              if (isWideScreen)
                NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  backgroundColor: const Color(0xFF121212),
                  indicatorColor: const Color(0xFFCCFF00),
                  labelType: NavigationRailLabelType.all,
                  selectedLabelTextStyle: const TextStyle(color: Color(0xFFCCFF00)),
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.dashboard_outlined),
                      selectedIcon: Icon(Icons.dashboard, color: Colors.black),
                      label: Text('Dashboard'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.fitness_center_outlined),
                      selectedIcon: Icon(Icons.fitness_center, color: Colors.black),
                      label: Text('Workouts'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.show_chart),
                      selectedIcon: Icon(Icons.show_chart, color: Colors.black),
                      label: Text('Progress'),
                    ),
                  ],
                ),

              if (isWideScreen)
                const VerticalDivider(thickness: 1, width: 1, color: Colors.grey),

              // MAIN CONTENT AREA
              Expanded(
                child: _screens[_selectedIndex],
              ),
            ],
          ),
          
          // BOTTOM NAVIGATION BAR (Only visible on Small Screens)
          bottomNavigationBar: isWideScreen
              ? null
              : NavigationBar(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (index) => setState(() => _selectedIndex = index),
                  backgroundColor: const Color(0xFF1E1E1E),
                  indicatorColor: const Color(0xFFCCFF00).withOpacity(0.5),
                  destinations: const [
                    NavigationDestination(icon: Icon(Icons.dashboard), label: 'Home'),
                    NavigationDestination(icon: Icon(Icons.fitness_center), label: 'Workouts'),
                    NavigationDestination(icon: Icon(Icons.show_chart), label: 'Progress'),
                  ],
                ),
        );
      },
    );
  }
}