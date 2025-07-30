import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '/features/place/domain/entities/cappadociModel.dart';
import '/features/place/data/repositories/cappadoci_service.dart';

class CappadociaDetailPage extends StatefulWidget {
  final int id;

  const CappadociaDetailPage({super.key, required this.id});

  @override
  State<CappadociaDetailPage> createState() => _CappadociaDetailPageState();
}

class _CappadociaDetailPageState extends State<CappadociaDetailPage> {
  CappadociModel? model;
  bool isLoading = true;
  bool isLiked = false;
  bool showFullDescription = false;

  final List<String> imageUrls = [
    'https://img.freepik.com/free-photo/vibrant-hot-air-balloon-soars-mid-air-colorful-adventure-generated-by-ai_188544-55263.jpg',
    'https://img.freepik.com/free-photo/sunrise-hot-air-balloon-over-mountains-generated-by-ai_188544-36024.jpg',
    'https://img.freepik.com/free-photo/balloon-flying-cappadocia-early-morning_335224-342.jpg',
    'https://img.freepik.com/free-photo/colorful-hot-air-balloons-flying-over-mountains-generated-by-ai_188544-29586.jpg',
  ];

  String? selectedImageUrl;

  @override
  void initState() {
    super.initState();
    fetchLocation();
    selectedImageUrl = imageUrls[0];
  }

  Future<void> fetchLocation() async {
    try {
      final data = await CappadociService.getById(widget.id);
      setState(() {
        model = data;
        isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() => isLoading = false);
    }
  }

  void changeImage() {
    final currentIndex = imageUrls.indexOf(selectedImageUrl!);
    final nextIndex = (currentIndex + 1) % imageUrls.length;
    setState(() {
      selectedImageUrl = imageUrls[nextIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (model == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text('No data found', style: TextStyle(color: Colors.white)),
        ),
      );
    }

    final location = model!;
    final lat = double.tryParse(location.latitude) ?? 0;
    final lng = double.tryParse(location.longitude) ?? 0;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: changeImage,
                  child: Image.network(
                    selectedImageUrl!,
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: const BackButton(color: Colors.white),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? Colors.red : Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            isLiked = !isLiked;
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.share, color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status & Time
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            "OPEN",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "2:00 AM - 11:59 PM",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Location and rating
                    Row(
                      children: [
                        const Icon(Icons.location_pin,
                            color: Colors.white70, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          "${location.city}, ${location.country}",
                          style: const TextStyle(color: Colors.white70),
                        ),
                        const Spacer(),
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        const Text("4.5",
                            style: TextStyle(color: Colors.white70)),
                      ],
                    ),
                    const SizedBox(height: 10),


                    Text(
                      location.name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),


                    Text(
                      showFullDescription
                          ? location.fullDescription
                          : location.description,
                      style: const TextStyle(color: Colors.white70),
                    ),

                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showFullDescription = !showFullDescription;
                        });
                      },
                      child: Text(
                        showFullDescription ? "See less" : "See more",
                        style: const TextStyle(
                            color: Colors.yellow,
                            fontWeight: FontWeight.bold),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Image previews
                    SizedBox(
                      height: 60,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: imageUrls.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(width: 10),
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedImageUrl = imageUrls[index];
                            });
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              imageUrls[index],
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Map
                    SizedBox(
                      height: 160,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(lat, lng),
                            zoom: 14,
                          ),
                          markers: {
                            Marker(
                              markerId: const MarkerId("location"),
                              position: LatLng(lat, lng),
                            ),
                          },
                          zoomControlsEnabled: false,
                          liteModeEnabled: true,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Price + Book Now
                    Row(
                      children: [
                        Text(
                          "\$${location.basePrice}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "\$360",
                          style: TextStyle(
                            color: Colors.white38,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                          ),
                          onPressed: () {

                          },
                          child: const Text(
                            "Book Now",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}