import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:technician/feature/claim%20details/data/models/claim_details_model.dart';
import 'package:technician/feature/claim%20details/presentation/cubit/claim_details_cubit.dart'; // <-- your existing cubit
import 'package:technician/feature/claim%20details/presentation/widgets/edit_material_screen.dart';
import '../../../../config/PrefHelper/prefs.dart';
import '../../../../core/utils/app_strings.dart';
import 'add_materials_screen.dart';

class ClaimMaterialsScreen extends StatefulWidget {
  final List<ClaimMaterials> materials;
  final String referenceId;
  final int claimId;
  const ClaimMaterialsScreen({super.key, required this.materials, required this.referenceId, required this.claimId});

  @override
  State<ClaimMaterialsScreen> createState() => _ClaimMaterialsScreenState();
}

class _ClaimMaterialsScreenState extends State<ClaimMaterialsScreen> {
  int? selectedItemIndex;
  void toggleSelection(int index) {
    setState(() {
      if (selectedItemIndex == index) {
        selectedItemIndex = null;
      } else {
        selectedItemIndex = index;
      }
    });
  }
  List<String> _permissions = [];

  @override
  void initState() {
    super.initState();
    _loadPermissions();
  }

  Future<void> _loadPermissions() async {
    final permissions = Prefs.getStringList(AppStrings.permissions);
    if (permissions != null) {
      setState(() {
        _permissions = permissions;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<ClaimDetailsCubit>(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Claim Materials',
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
          // actions: [
          //   TextButton(
          //     onPressed: () {
          //       // Save logic here
          //     },
          //     child: const Text(
          //       'Save',
          //       style: TextStyle(
          //         color: Colors.blue,
          //         fontWeight: FontWeight.w500,
          //       ),
          //     ),
          //   ),
          // ],
        ),
        body: BlocBuilder<ClaimDetailsCubit, ClaimDetailsState>(
          builder: (context, state) {
            if (state is ClaimDetailsIsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ClaimDetailsLoaded) {
              final materials = state.model.data.material;

              return Column(
                children: [
                  // If materials is empty, show text message, else show the list
                  Expanded(
                    child: materials.isEmpty
                        ? Center(
                      child: Text(
                        'No materials added yet.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                        : ListView.builder(
                      itemCount: materials.length,
                      itemBuilder: (context, index) {
                        final material = materials[index];
                        final isSelected = selectedItemIndex == index;
                        return MaterialItem(
                          material: material,
                          isSelected: isSelected,
                          onEdit: (material) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditMaterialScreen(
                                  material: material,
                                  id: widget.referenceId,
                                ),
                              ),
                            );
                          },
                          onDelete: (id) {
                            _confirmDelete(context, material.id.toString());
                          },
                          permissions: _permissions,
                        );
                      },
                    ),
                  ),
                  // This button will always show
                  _permissions.contains("add_items_to_claim_request") ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_permissions.contains("add_items_to_claim_request")) {
                            final result = await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AddMaterialsScreen(
                                  referenceId: widget.referenceId,
                                  claimId: widget.claimId,
                                ),
                              ),
                            );

                            if (result == true) {
                              context
                                  .read<ClaimDetailsCubit>()
                                  .getClaimDetails(widget.referenceId);
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'You do not have permission to Add materials.'),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4A85F6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Add Material',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ) : const SizedBox(),
                ],
              );
            } else if (state is ClaimDetailsError) {
              return Center(child: Text(state.msg));
            } else {
              return const SizedBox();
            }
          },
        ),

      ),
    );
  }

  void _confirmDelete(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Material'),
        content: const Text('Are you sure you want to delete this material?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<ClaimDetailsCubit>().deleteMaterial(id);
              context.read<ClaimDetailsCubit>().getClaimDetails(widget.referenceId);
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

class MaterialItem extends StatelessWidget {
  final ClaimMaterials material;
  final bool isSelected;
  final Function(ClaimMaterials material) onEdit;
  final Function(int materialId) onDelete;
  final List<String> permissions;

  const MaterialItem({
    Key? key,
    required this.material,
    required this.isSelected,
    required this.onEdit,
    required this.onDelete,
    required this.permissions
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(material.id.toString()),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.25,
        children: [
          Flexible(
            child: CustomSlidableAction(
              icon: Icons.edit,
              color: Colors.blue,
              onPressed: () {
                if (permissions.contains('edit_qty_item_claim')) {
                  onEdit(material);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('You do not have permission to edit this material.'),
                    ),
                  );

                }
              },
            ),
          ),
          Flexible(
            child: CustomSlidableAction(
              icon: Icons.delete,
              color: Colors.red,
              onPressed: () {
                if (permissions.contains('delete_item_from_claim_request')) {
                  onDelete(material.id);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('You do not have permission to delete this material.'),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.05) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              child: Center(child: SvgPicture.network(material.image)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    material.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A2F4B),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    material.code,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        material.unit,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        material.category,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "/",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        material.group,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                const Text(
                  'Qty.',
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
                Text(
                  '${material.qty}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSlidableAction extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const CustomSlidableAction({
    super.key,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: color,
          size: 20,
        ),
      ),
    );
  }
}
