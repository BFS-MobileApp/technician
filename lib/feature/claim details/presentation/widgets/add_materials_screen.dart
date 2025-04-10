import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:technician/feature/claim%20details/data/models/claim_details_model.dart';
import 'package:technician/feature/claim%20details/presentation/widgets/qr_scanner_sheet.dart';
import '../../../../core/usecase/use_case.dart';
import '../cubit/claim_details_cubit.dart';

class AddMaterialsScreen extends StatefulWidget {
  final String referenceId;
  final int claimId;
  const AddMaterialsScreen({super.key, required this.referenceId, required this.claimId});

  @override
  State<AddMaterialsScreen> createState() => _AddMaterialsScreenState();
}

class _AddMaterialsScreenState extends State<AddMaterialsScreen> {
  int? expandedItemIndex;
  Map<int, int> quantities = {};
  final TextEditingController _searchController = TextEditingController();
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    context.read<ClaimDetailsCubit>().getMaterial(widget.referenceId, page: 1);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      context.read<ClaimDetailsCubit>().loadMoreMaterials(widget.referenceId,_searchController.text);
    }
  }

  void toggleExpanded(int index) {
    setState(() {
      if (expandedItemIndex == index) {
        expandedItemIndex = null;
      } else {
        expandedItemIndex = index;
      }
    });
  }

  void incrementQuantity(int index) {
    setState(() {
      quantities[index] = (quantities[index] ?? 1) + 1;
    });
  }

  void decrementQuantity(int index) {
    setState(() {
      if ((quantities[index] ?? 1) > 1) {
        quantities[index] = (quantities[index] ?? 1) - 1;
      }
    });
  }
  void _onSearch(String query) {
    context.read<ClaimDetailsCubit>().getMaterial(
      widget.referenceId,
      page: 1,
      search: query, // <-- Pass search keyword
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Add Materials',
          style: TextStyle(
            color: Color(0xFF1A2F4B),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context, true),
        ),
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildHeader(),
          Expanded(
            child: BlocBuilder<ClaimDetailsCubit, ClaimDetailsState>(
              builder: (context, state) {
                if (state is ClaimDetailsIsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ClaimDetailsError) {
                  return Center(child: Text(state.msg));
                } else if (state is MaterialLoaded) {
                  final materials = state.model;
                  final cubit = context.read<ClaimDetailsCubit>();

                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: materials.data.length + (cubit.isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == materials.data.length) {
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      final material = materials.data[index];
                      final isExpanded = expandedItemIndex == index;
                      final currentQuantity = quantities[index] ?? 1;

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            MaterialItem(
                              title: material.name,
                              category: material.category,
                              onExpandPressed: () => toggleExpanded(index),
                              image: material.image,
                            ),
                            if (isExpanded)
                              buildExpandedSection(index, currentQuantity,material.id),
                            // const Divider(height: 1, indent: 16, endIndent: 16),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    onPressed: () {
                      _searchController.clear(); // clear text
                      _onSearch(''); // 🔥 reset search
                      FocusScope.of(context).unfocus(); // hide keyboard
                    },
                  )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
                onChanged: (value) {
                  setState(() {});
                  _onSearch(value);
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: const Icon(Icons.qr_code_scanner),
              onPressed: () async {
                final result = await showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const QRScannerSheet(),
                );
                if (result != null) {
                  _searchController.text = result;
                  _onSearch(result);
                }
              },
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: const BorderRadius.all(Radius.circular(12))
        ),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        // color: Colors.blue.withOpacity(0.1),
        child: const Text(
          'Frequently Used Materials',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1A2F4B),
          ),
        ),
      ),
    );
  }

  Widget buildExpandedSection(int index, int currentQuantity,int id) {
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
              const SizedBox(width: 60,),
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue,width: 2.5),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: InkWell(
                  onTap: () => incrementQuantity(index),
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
                  border: Border.all(color: Colors.grey,width: 2.5),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: InkWell(
                  onTap: () => decrementQuantity(index),
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
                  onPressed: () {
                    final cubit = context.read<ClaimDetailsCubit>();

                    cubit.addMaterial(
                      widget.claimId,
                      [
                        ProductItem(id: id, qty: quantities[index] ?? 1),
                      ],
                    ).then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Material added successfully!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                      toggleExpanded(index);
                      context.read<ClaimDetailsCubit>().getMaterial(widget.referenceId);
                    });
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
                    'Add',
                    style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              // const SizedBox(width: 12),
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () => toggleExpanded(index),
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


  Widget _quantityButton(IconData icon, Color color) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color),
      ),
      child: Icon(icon, color: color, size: 18),
    );
  }

  Widget _actionButton(String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withOpacity(0.2),
        foregroundColor: color,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        minimumSize: const Size(100, 36),
      ),
      child: Text(text),
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
        borderRadius: BorderRadius.circular(16), // <-- Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05), // Light shadow
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
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.blue),
          onPressed: onExpandPressed,
        ),
      ),
    );

  }
}
