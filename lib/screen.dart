import 'package:flutter/material.dart';

// =======================
// 1. DASHBOARD SCREEN
// =======================
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Good Morning, Sarah", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
          const Text("Tuesday, October 24", style: TextStyle(color: Colors.grey, fontSize: 16)),
          const SizedBox(height: 30),
          
          // Layout: Switches from Column (Phone) to Row (Tablet)
          LayoutBuilder(builder: (context, constraints) {
            bool isWide = constraints.maxWidth > 800;
            return Flex(
              direction: isWide ? Axis.horizontal : Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main Goal Card
                Container(
                  width: isWide ? 400 : double.infinity,
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(24)),
                  child: Column(
                    children: [
                      const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text("Daily Goal", style: TextStyle(color: Colors.white, fontSize: 18)),
                        Chip(label: Text("ON TRACK", style: TextStyle(fontSize: 10, color: Colors.black)), backgroundColor: Color(0xFFCCFF00))
                      ]),
                      const SizedBox(height: 20),
                      Stack(alignment: Alignment.center, children: [
                        SizedBox(
                          height: 200, width: 200,
                          child: CircularProgressIndicator(value: 0.84, strokeWidth: 15, backgroundColor: Colors.grey[800], color: Colors.white),
                        ),
                        const Column(children: [
                          Text("8,432", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white)),
                          Text("/ 10,000 STEPS", style: TextStyle(color: Colors.grey)),
                        ])
                      ]),
                      const SizedBox(height: 20),
                      const Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                        Column(children: [Text("5.2", style: TextStyle(fontSize: 20, color: Color(0xFFCCFF00))), Text("km Distance", style: TextStyle(color: Colors.grey))]),
                        Column(children: [Text("480", style: TextStyle(fontSize: 20, color: Color(0xFFCCFF00))), Text("kcal Burned", style: TextStyle(color: Colors.grey))]),
                      ])
                    ],
                  ),
                ),
                SizedBox(width: isWide ? 20 : 0, height: isWide ? 0 : 20),
                
                // Grid of smaller stats
                Expanded(
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: isWide ? 2 : 2, // 2 columns for both for simplicity
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 1.3,
                    children: const [
                      StatCard(title: "Heart Rate", value: "98", unit: "bpm", icon: Icons.favorite, color: Colors.red),
                      StatCard(title: "Sleep", value: "7h 20m", unit: "Light Sleep", icon: Icons.bedtime, color: Colors.deepPurple),
                      StatCard(title: "Calories", value: "1,240", unit: "kcal", icon: Icons.local_fire_department, color: Colors.orange),
                      StatCard(title: "Hydration", value: "1,250", unit: "ml", icon: Icons.water_drop, color: Colors.blue),
                    ],
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title, value, unit;
  final IconData icon;
  final Color color;
  const StatCard({super.key, required this.title, required this.value, required this.unit, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(20)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(title, style: const TextStyle(color: Colors.grey)),
          Icon(icon, color: color),
        ]),
        const Spacer(),
        Text(value, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color)),
        Text(unit, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ]),
    );
  }
}

// =======================
// 2. WORKOUT LIBRARY SCREEN
// =======================
class WorkoutLibraryScreen extends StatelessWidget {
  const WorkoutLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Main Content
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Workout Library", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  const Text("Discover your next challenge.", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: ["All Workouts", "HIIT", "Yoga Flow", "Strength", "Cardio"]
                          .map((e) => Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Chip(
                                  label: Text(e),
                                  backgroundColor: e == "All Workouts" ? const Color(0xFFCCFF00) : Colors.grey[800],
                                  labelStyle: TextStyle(color: e == "All Workouts" ? Colors.black : Colors.white),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 300,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return const WorkoutCard();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Filter Sidebar (Responsive: Hides on small screens)
          if (MediaQuery.of(context).size.width > 900)
            Expanded(
              flex: 1,
              child: Container(
                color: const Color(0xFF161616),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text("Filters", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("Reset", style: TextStyle(color: Color(0xFFCCFF00))),
                    ]),
                    const SizedBox(height: 30),
                    const Text("DIFFICULTY", style: TextStyle(color: Colors.grey, fontSize: 12)),
                    const SizedBox(height: 10),
                    _buildCheckbox("Beginner", true),
                    _buildCheckbox("Intermediate", true),
                    _buildCheckbox("Advanced", false),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
  
  Widget _buildCheckbox(String label, bool value) {
    return Row(children: [
      Icon(value ? Icons.check_circle : Icons.circle_outlined, color: value ? const Color(0xFFCCFF00) : Colors.grey, size: 20),
      const SizedBox(width: 10),
      Text(label),
    ]);
  }
}

class WorkoutCard extends StatelessWidget {
  const WorkoutCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.grey, 
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                // Placeholder image since we don't have assets
                gradient: LinearGradient(colors: [Color(0xFF4A4A4A), Color(0xFF2A2A2A)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
              child: const Center(child: Icon(Icons.fitness_center, color: Colors.white54, size: 50)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                   Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), color: Colors.white24, child: const Text("HIIT", style: TextStyle(fontSize: 10))),
                   const SizedBox(width: 8),
                   Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), color: Colors.white24, child: const Text("ADVANCED", style: TextStyle(fontSize: 10))),
                ]),
                const SizedBox(height: 8),
                const Text("High Intensity Burn", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                const Text("30 min  •  350 kcal", style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// =======================
// 3. PROGRESS SCREEN
// =======================
class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text("Progress", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
        const Text("Your journey over the last 30 days.", style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 20),

        // Weight Loss Chart Card
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(24)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("Weight Loss", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Chip(label: Text("30 Days"), backgroundColor: Colors.white10),
              ]),
              const SizedBox(height: 20),
              
              // Custom Simple Line Chart
              SizedBox(
                height: 150,
                width: double.infinity,
                child: CustomPaint(painter: LineChartPainter()),
              ),
              const SizedBox(height: 20),
              const Text("72.4 kg", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              const Text("Current Weight", style: TextStyle(color: Colors.blue)),
              const SizedBox(height: 10),
              const Text("68.0 kg", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey)),
              const Text("Target Goal", style: TextStyle(color: Colors.pink)),
            ],
          ),
        ),
        
        const SizedBox(height: 20),
        
        // Consistency Heatmap (Simulated with Grid)
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(24)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                 Text("Consistency", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                 Text("Last 4 Weeks", style: TextStyle(color: Colors.grey)),
              ]),
              const SizedBox(height: 20),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(28, (index) {
                  // Simulate random activity levels
                  int opacityLevel = (index % 5 == 0) ? 100 : (index % 3 == 0) ? 200 : 800;
                  return Container(
                    width: 30, height: 30,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(opacityLevel / 900),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              )
            ],
          ),
        )
      ],
    );
  }
}

// Simple Custom Painter to draw the graph line without external packages
class LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height * 0.2);
    // Draw a smooth curve
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.3, size.width, size.height * 0.8);
    
    canvas.drawPath(path, paint);
    
    // Draw dashed target line
    final targetPaint = Paint()..color = Colors.pink.withOpacity(0.5)..strokeWidth = 2..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(0, size.height * 0.85), Offset(size.width, size.height * 0.85), targetPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}