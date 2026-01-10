import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:technician/feature/claim%20details/data/models/claim_details_model.dart';
import 'package:technician/feature/claim%20details/presentation/cubit/claim_details_cubit.dart';
import 'package:technician/feature/claim%20details/presentation/widgets/edit_material_screen.dart';
import '../../../../config/PrefHelper/prefs.dart';
import '../../../../core/utils/app_strings.dart';
import 'add_materials_screen.dart';

class ClaimMaterialsScreen extends StatefulWidget {
  final List<ClaimMaterials> materials;
  final String referenceId;
  final int claimId;

  const ClaimMaterialsScreen({
    super.key,
    required this.materials,
    required this.referenceId,
    required this.claimId,
  });

  @override
  State<ClaimMaterialsScreen> createState() => _ClaimMaterialsScreenState();
}

class _ClaimMaterialsScreenState extends State<ClaimMaterialsScreen> {
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
        ),
        body: BlocBuilder<ClaimDetailsCubit, ClaimDetailsState>(
          builder: (context, state) {
            if (state is ClaimDetailsIsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ClaimDetailsLoaded) {
              final materials = state.model.data.material;

              return Column(
                children: [
                  Expanded(
                    child: materials.isEmpty
                        ? const Center(
                      child: Text(
                        'No materials added yet.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    )
                        : ListView.builder(
                      itemCount: materials.length,
                      itemBuilder: (context, index) {
                        return MaterialItem(
                          material: materials[index],
                          permissions: _permissions,
                          showHint: index == 0, // 👈 show hint only once
                          onEdit: (material) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditMaterialScreen(
                                  material: material,
                                  id: widget.referenceId,
                                ),
                              ),
                            );
                          },
                          onDelete: (id) {
                            _confirmDelete(context, id.toString());
                          },
                        );
                      },
                    ),
                  ),
                  _permissions.contains("add_items_to_claim_request")
                      ? Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddMaterialsScreen(
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
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4A85F6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Add Material',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  )
                      : const SizedBox(),
                ],
              );
            } else if (state is ClaimDetailsError) {
              return Center(child: Text(state.msg));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Material'),
        content: const Text('Are you sure you want to delete this material?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<ClaimDetailsCubit>().deleteMaterial(id);
              context
                  .read<ClaimDetailsCubit>()
                  .getClaimDetails(widget.referenceId);
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

class MaterialItem extends StatefulWidget {
  final ClaimMaterials material;
  final Function(ClaimMaterials) onEdit;
  final Function(int) onDelete;
  final List<String> permissions;
  final bool showHint;

  const MaterialItem({
    super.key,
    required this.material,
    required this.onEdit,
    required this.onDelete,
    required this.permissions,
    required this.showHint,
  });

  @override
  State<MaterialItem> createState() => _MaterialItemState();
}

class _MaterialItemState extends State<MaterialItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _shake;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 600));

    _shake = Tween(begin: 0.0, end: 8.0)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(_controller);

    if (widget.showHint) {
      _controller.forward().then((_) => _controller.reverse());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shake,
      builder: (_, child) {
        return Transform.translate(
          offset: Offset(-_shake.value, 0),
          child: child,
        );
      },
      child: Slidable(
        key: Key(widget.material.id.toString()),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {
                if (widget.permissions.contains('edit_qty_item_claim')) {
                  widget.onEdit(widget.material);
                }
              },
              backgroundColor: Colors.blue.shade50,
              foregroundColor: Colors.blue,
              icon: Icons.edit,
            ),
            SlidableAction(
              onPressed: (_) {
                if (widget.permissions
                    .contains('delete_item_from_claim_request')) {
                  widget.onDelete(widget.material.id);
                }
              },
              backgroundColor: Colors.red.shade50,
              foregroundColor: Colors.red,
              icon: Icons.delete,
            ),
          ],
        ),
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: SvgPicture.network(widget.material.image),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.material.name,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                    '${widget.material.qty}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),

            // 👇 Swipe hint (first item only)
            if (widget.showHint)
              Positioned(
                right: 50,
                top: 0,
                bottom: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.arrow_back_ios, size: 14, color: Colors.grey),
                    Text(
                      'Swipe',
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
