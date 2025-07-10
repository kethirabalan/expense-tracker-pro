import 'dart:ui';
import 'package:flutter/material.dart';

class StartupScreen extends StatelessWidget {
  final VoidCallback? onGetStarted;
  const StartupScreen({super.key, this.onGetStarted});

  @override
  Widget build(BuildContext context) {
    final Color blue = const Color(0xFF2979FF);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFe3f0ff), Color(0xFFf8fbff)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: _GlassCard(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 36),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Illustration (use a Flutter icon for now)
                    Container(
                      decoration: BoxDecoration(
                        color: blue.withOpacity(0.08),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(24),
                      child: Icon(Icons.savings, color: blue, size: 64),
                    ),
                    const SizedBox(height: 32),
                    Text('Expense Tracker', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: blue)),
                    const SizedBox(height: 12),
                    const Text(
                      'The easiest approach to handle your finances in a wise way.\nTrack, analyze, and plan your spending effortlessly.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: blue,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          elevation: 2,
                        ),
                        onPressed: onGetStarted ?? () {},
                        child: const Text('Get Started', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassCard extends StatelessWidget {
  final Widget child;
  const _GlassCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.55),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
              border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.2),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
} 