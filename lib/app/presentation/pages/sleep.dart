import 'package:flutter/material.dart';

class SleepScreen extends StatefulWidget {
  const SleepScreen({super.key});

  @override
  State<SleepScreen> createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpeg'),
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Tab Bar
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white.withOpacity(0.2),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white70,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  tabs: const [
                    Tab(text: 'Sleep'),
                    Tab(text: 'Routine'),
                  ],
                ),
              ),
              // Tab Content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Sleep Tab
                    const Center(
                      child: Text(
                        'Sleep Tracking',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Routine Tab
                    const Center(
                      child: Text(
                        'Sleep Routine',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
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
