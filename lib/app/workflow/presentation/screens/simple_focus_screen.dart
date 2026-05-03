import 'dart:async';
import 'package:flutter/material.dart';
import '../../infrastructure/workflow_services.dart';

class SimpleFocusScreen extends StatefulWidget {
  const SimpleFocusScreen({super.key});

  @override
  State<SimpleFocusScreen> createState() => _SimpleFocusScreenState();
}

class _SimpleFocusScreenState extends State<SimpleFocusScreen> {
  final NativeDistractionBlockService _blockService = NativeDistractionBlockService();
  
  // State
  bool _isBlocking = false;
  Duration _remainingTime = const Duration(minutes: 30); // Default to 30 min
  Timer? _timer;

  void _startFocus() {
    setState(() {
      _isBlocking = true;
    });
    
    // Tell Android to start blocking!
    _blockService.blockDistractingApps();

    // Start UI countdown
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime.inSeconds <= 0) {
        _stopFocus();
      } else {
        setState(() {
          _remainingTime = _remainingTime - const Duration(seconds: 1);
        });
      }
    });
  }

  void _stopFocus() {
    _timer?.cancel();
    setState(() {
      _isBlocking = false;
      _remainingTime = const Duration(minutes: 30); // Reset for next time
    });

    // Tell Android to stop blocking!
    _blockService.unblockDistractingApps();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
      appBar: AppBar(
        title: const Text('Focusy'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _isBlocking ? const Color(0xFFEF4444) : const Color(0xFF8B5CF6),
                    width: 8,
                  ),
                ),
                child: Text(
                  _formatDuration(_remainingTime),
                  style: const TextStyle(
                    fontSize: 56,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 60),
              if (!_isBlocking) ...[
                const Text(
                  'Ready to focus?',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                const SizedBox(height: 12),
                Text(
                  'This will block distracting apps for 30 minutes.',
                  style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.6)),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8B5CF6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: _startFocus,
                    child: const Text(
                      'START FOCUS',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ] else ...[
                const Text(
                  'Focus Active',
                  style: TextStyle(fontSize: 24, color: Color(0xFFEF4444), fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Text(
                  'Distractions are currently blocked.',
                  style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.6)),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFEF4444)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: _stopFocus,
                    child: const Text(
                      'STOP EARLY',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFEF4444)),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
