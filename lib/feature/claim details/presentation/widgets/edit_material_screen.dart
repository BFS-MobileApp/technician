import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:technician/feature/claim%20details/data/models/claim_details_model.dart';

import '../cubit/claim_details_cubit.dart';

class EditMaterialScreen extends StatefulWidget {
  final ClaimMaterials material;
  final String id;
  const EditMaterialScreen({super.key, required this.material, required this.id});

  @override
  State<EditMaterialScreen> createState() => _EditMaterialScreenState();
}

class _EditMaterialScreenState extends State<EditMaterialScreen> {
  bool isExpanded = false;
  int currentQuantity = 1; // <-- Only one quantity for the selected material

  @override
  void initState() {
    super.initState();
    currentQuantity = widget.material.qty ?? 1; // set starting quantity
  }

  void toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  void incrementQuantity() {
    setState(() {
      currentQuantity++;
    });
  }

  void decrementQuantity() {
    setState(() {
      if (currentQuantity > 1) {
        currentQuantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Edit Material',
          style: TextStyle(
            color: Color(0xFF1A2F4B),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            MaterialItem(
              title: widget.material.name,
              category: widget.material.category,
              onExpandPressed: toggleExpanded,
              image: widget.material.image,
            ),
            if (isExpanded)
              buildExpandedSection(widget.material.id.toString(),currentQuantity),
          ],
        ),
      ),
    );
  }

  Widget buildExpandedSection(String id, int qty) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Quantity',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A2F4B),
                ),
              ),
              const SizedBox(width: 60),
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2.5),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: InkWell(
                  onTap: incrementQuantity,
                  child: const Icon(Icons.add, color: Colors.blue, size: 20),
                ),
              ),
              const SizedBox(width: 20),
              Text(
                '$currentQuantity',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A2F4B),
                ),
              ),
              const SizedBox(width: 20),
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2.5),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: InkWell(
                  onTap: decrementQuantity,
                  child: const Icon(Icons.remove, color: Colors.grey, size: 20),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () async {
                    await context.read<ClaimDetailsCubit>().editMaterialQuantity(id, qty);
                    await context.read<ClaimDetailsCubit>().getClaimDetails(widget.id);

                    Navigator.pop(context);

                    // After popping back, show a snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Quantity updated successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.withOpacity(0.1),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.withOpacity(0.1),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MaterialItem extends StatelessWidget {
  final String title;
  final String category;
  final String image;
  final VoidCallback onExpandPressed;

  const MaterialItem({
    super.key,
    required this.title,
    required this.category,
    required this.onExpandPressed,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 50,
          height: 50,
          padding: const EdgeInsets.all(4),
          child: image.isNotEmpty
              ? SvgPicture.network(
            image,
            placeholderBuilder: (context) => const Center(child: CircularProgressIndicator()),
          )
              : const Icon(Icons.image),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1A2F4B),
          ),
        ),
        subtitle: Text(
          category,
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.blue),
          onPressed: onExpandPressed,
        ),
      ),
    );
  }
}
