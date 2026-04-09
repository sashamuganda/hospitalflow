import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class FacilitiesMapScreen extends StatefulWidget {
  const FacilitiesMapScreen({super.key});

  @override
  State<FacilitiesMapScreen> createState() => _FacilitiesMapScreenState();
}

class _FacilitiesMapScreenState extends State<FacilitiesMapScreen> {
  String _selectedCategory = 'Hospitals';
  final List<String> _categories = ['Hospitals', 'Clinics', 'Labs', 'Pharmacies'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: MedFlowAppBar(
        title: 'Find Facilities',
        actions: [
          IconButton(
            onPressed: () => context.push('/facilities/list'),
            icon: const Icon(Icons.list_alt_rounded),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Mock Map Background
          Positioned.fill(
            child: Container(
              color: const Color(0xFF1A1F2E),
              child: CustomPaint(
                painter: MapGridPainter(),
              ),
            ),
          ),
          
          // Marker Overlay
          _buildMarker(0.35, 0.45, 'St. Nicholas Hospital', '2.4 km'),
          _buildMarker(0.65, 0.3, 'Clinix Healthcare', '1.8 km'),
          _buildMarker(0.5, 0.7, 'Reddingon Hospital', '3.1 km'),

          // Category Pills
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  final isSelected = _selectedCategory == cat;
                  return ChoiceChip(
                    label: Text(cat),
                    selected: isSelected,
                    onSelected: (val) => setState(() => _selectedCategory = cat),
                  );
                },
              ),
            ),
          ),

          // Search Overlay
          Positioned(
            top: 80,
            left: 20,
            right: 20,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by name or specialty...',
                prefixIcon: const Icon(Icons.search_rounded),
                filled: true,
                fillColor: AppColors.surface.withOpacity(0.9),
              ),
            ),
          ),

          // Bottom Sheet / Preview Card
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: _buildFacilityPreview(context),
          ),
        ],
      ),
    );
  }

  Widget _buildMarker(double top, double left, String name, String dist) {
    return Positioned(
      top: MediaQuery.of(context).size.height * top,
      left: MediaQuery.of(context).size.width * left,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 4)],
            ),
            child: Text(name, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
          ),
          const Icon(Icons.location_on_rounded, color: AppColors.primary, size: 28),
        ],
      ),
    );
  }

  Widget _buildFacilityPreview(BuildContext context) {
    return GlassCard(
      onTap: () => context.push('/facilities/detail/1'),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.local_hospital_rounded, color: AppColors.primary, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('St. Nicholas Hospital', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const Text('Lagos Island, Lagos', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star_rounded, color: Colors.amber, size: 14),
                    const SizedBox(width: 4),
                    const Text('4.8 (240+ reviews)', style: TextStyle(fontSize: 12)),
                    const Spacer(),
                    Text('1.2 km', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..strokeWidth = 1.0;

    for (double i = 0; i < size.width; i += 40) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += 40) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }

    final roadPaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 8.0
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height * 0.4);
    path.lineTo(size.width, size.height * 0.45);
    path.moveTo(size.width * 0.3, 0);
    path.lineTo(size.width * 0.35, size.height);
    
    canvas.drawPath(path, roadPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
