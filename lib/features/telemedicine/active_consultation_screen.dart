import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';

class ActiveConsultationScreen extends StatefulWidget {
  const ActiveConsultationScreen({super.key});

  @override
  State<ActiveConsultationScreen> createState() => _ActiveConsultationScreenState();
}

class _ActiveConsultationScreenState extends State<ActiveConsultationScreen> {
  bool _muted = false;
  bool _cameraOff = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Doctor Video (Mock)
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?auto=format&fit=crop&w=800&q=80'),
                fit: BoxFit.cover,
                opacity: 0.8,
              ),
            ),
          ),
          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.4),
                  Colors.transparent,
                  Colors.transparent,
                  Colors.black.withOpacity(0.8),
                ],
              ),
            ),
          ),
          // User Video (PIP)
          Positioned(
            top: 60,
            right: 20,
            child: Container(
              width: 100,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white24, width: 1),
                boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10)],
              ),
              child: _cameraOff
                  ? const Icon(Icons.videocam_off_rounded, color: Colors.white38)
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network('https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=200&q=80', fit: BoxFit.cover),
                    ),
            ),
          ),
          // Top Controls
          Positioned(
            top: 50,
            left: 20,
            child: _buildIconButton(Icons.arrow_back_rounded, Colors.white24, () => context.pop()),
          ),
          // Doctor Info
          Positioned(
            bottom: 120,
            left: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Dr. Ngozi Adeyemi', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.success, shape: BoxShape.circle)),
                    const SizedBox(width: 8),
                    const Text('08:42 • MD, Cardiology', style: TextStyle(color: Colors.white70, fontSize: 14)),
                  ],
                ),
              ],
            ),
          ),
          // Bottom Controller
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCircleAction(
                  _muted ? Icons.mic_off_rounded : Icons.mic_rounded,
                  _muted ? Colors.redAccent : Colors.white24,
                  () => setState(() => _muted = !_muted),
                ),
                const SizedBox(width: 24),
                _buildCircleAction(
                  Icons.call_end_rounded,
                  Colors.red,
                  () => context.pushReplacement('/telemedicine/summary'),
                  size: 64,
                  iconSize: 32,
                ),
                const SizedBox(width: 24),
                _buildCircleAction(
                  _cameraOff ? Icons.videocam_off_rounded : Icons.videocam_rounded,
                  _cameraOff ? Colors.redAccent : Colors.white24,
                  () => setState(() => _cameraOff = !_cameraOff),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, Color bg, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _buildCircleAction(IconData icon, Color bg, VoidCallback onTap, {double size = 56, double iconSize = 24}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white, size: iconSize),
      ),
    );
  }
}
