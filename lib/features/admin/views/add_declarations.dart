import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mind_labify/features/admin/admin_bloc/admin_bloc.dart';
import 'package:mind_labify/features/admin/views/admin_button.dart';
import 'package:mind_labify/models/declaration_model.dart';
import 'package:mind_labify/utils/gaps.dart';
import 'package:mind_labify/widgets/app_text_fields.dart';

class AddDeclarations extends StatefulWidget {
  final DeclarationModel? declarations;
  const AddDeclarations({
    super.key,
    this.declarations,
  });

  @override
  State<AddDeclarations> createState() => _AddDeclarationsState();
}

class _AddDeclarationsState extends State<AddDeclarations> {
  late DeclarationModel declarations;
  late final AdminBloc adminBloc;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String category = '';
  String status = 'Inactive';
  String? declarationIcon;
  final picker = ImagePicker();
  @override
  void initState() {
    adminBloc = context.read<AdminBloc>();
    adminBloc.add(
      GetDeclarationCategory(),
    );

    if (widget.declarations != null) {
      _titleController.text = widget.declarations!.title ?? '';
      _descriptionController.text = widget.declarations!.description ?? '';
      category = widget.declarations!.declarationCategory ?? '';
      declarationIcon = widget.declarations!.image ?? '';
      status = widget.declarations!.status ?? '';
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final adminBloc = context.watch<AdminBloc>();
    return Scaffold(
      backgroundColor: const Color(
        0xFFF1F1F1,
      ),
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        titleTextStyle: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: Color(
            0xFF000000,
          ),
        ),
        title: Text(
          widget.declarations != null ? 'Edit Declaration' : 'Add Declaration',
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            CupertinoIcons.back,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 20,
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 70,
            vertical: 15,
          ),
          decoration: BoxDecoration(
            color: const Color(
              0xFFffffff,
            ),
            borderRadius: BorderRadius.circular(
              05,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 500,
                      child: AppTextField(
                        controller: _titleController,
                        hintText: 'Title',
                      ),
                    ),
                    Container(
                      width: 500,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(
                          0xFFEAEAEA,
                        ),
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Status:',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          const Spacer(),
                          DropdownButton<String>(
                            underline: Container(),
                            value: status,
                            icon: const Icon(
                              Icons.arrow_drop_down_rounded,
                            ),
                            items: const [
                              DropdownMenuItem<String>(
                                value: 'Active',
                                child: Text(
                                  'Active',
                                ),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Inactive',
                                child: Text(
                                  'Inactive',
                                ),
                              ),
                            ],
                            onChanged: (String? newValue) {
                              setState(
                                () {
                                  status = newValue!;
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Gaps.hGap35,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 500,
                      child: AppTextField(
                        controller: _descriptionController,
                        hintText: 'Description',
                      ),
                    ),
                    Container(
                      width: 500,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(
                          0xFFEAEAEA,
                        ),
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Declaration Category',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            category,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  child: Container(
                                    height: 200,
                                    width: 300,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 15,
                                      horizontal: 20,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        12,
                                      ),
                                      color: const Color(
                                        0xFFffffff,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          'Select Category',
                                          style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color: Color(
                                              0xFF131313,
                                            ),
                                          ),
                                        ),
                                        Gaps.hGap15,
                                        BlocBuilder<AdminBloc, AdminState>(
                                          builder: (context, state) {
                                            if (state
                                                is GettingDeclarationCategory) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            } else if (state
                                                is GetDeclarationCategoryFailed) {
                                              return Center(
                                                child: Text(
                                                  state.message,
                                                ),
                                              );
                                            }
                                            return Expanded(
                                              child: ListView.builder(
                                                itemCount: adminBloc
                                                    .activeDeclarationCategories
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  return Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: TextButton(
                                                      onPressed: () {
                                                        setState(
                                                          () {
                                                            category = adminBloc
                                                                    .activeDeclarationCategories[
                                                                        index]
                                                                    .name ??
                                                                '';
                                                          },
                                                        );
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        adminBloc
                                                                .activeDeclarationCategories[
                                                                    index]
                                                                .name ??
                                                            '',
                                                        style: const TextStyle(
                                                          fontFamily: 'Inter',
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Color(
                                                            0xFF131313,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.arrow_drop_down_rounded,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Gaps.hGap35,
                const Text(
                  'Declaration Image',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color(
                      0xFF371B34,
                    ),
                  ),
                ),
                Gaps.hGap15,
                Row(
                  children: [
                    DottedBorder(
                      dashPattern: const [4, 4],
                      strokeWidth: 2,
                      color: const Color(
                        0xFF000000,
                      ),
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Center(
                          child: InkWell(
                            onTap: () async {
                              final pickedFile = await ImagePicker().pickImage(
                                source: ImageSource.gallery,
                              );

                              if (pickedFile != null) {
                                final iconUrl = pickedFile.path;
                                setState(
                                  () {
                                    declarationIcon = iconUrl;
                                  },
                                );
                              }
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(
                                  0xFF000000,
                                ),
                              ),
                              child: const Center(
                                child: Icon(
                                  color: Color(
                                    0xFFffffff,
                                  ),
                                  Icons.add,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    declarationIcon != null
                        ? Image.network(declarationIcon!, width: 50, height: 50)
                        : Container(),
                  ],
                ),
                Gaps.hGap35,
                BlocConsumer<AdminBloc, AdminState>(
                  listener: (context, state) {
                    if (state is CreateDeclarationSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Declaration created successfully',
                          ),
                        ),
                      );
                      _titleController.clear();
                      _descriptionController.clear();
                      Navigator.pop(
                        context,
                      );
                    } else if (state is CreateDeclarationFailed) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.message,
                          ),
                        ),
                      );
                    } else if (state is UpdateDeclarationSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Declaration updated successfully',
                          ),
                        ),
                      );
                      _titleController.clear();
                      _descriptionController.clear();
                      Navigator.pop(
                        context,
                      );
                    } else if (state is UpdateDeclarationFailed) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.message,
                          ),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is CreatingDeclaration ||
                        state is UpdatingDeclaration) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return SizedBox(
                      width: 250,
                      child: AdminButton(
                        text: widget.declarations != null ? 'Update' : 'Add',
                        onTap: () {
                          if (_titleController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please enter the title',
                                ),
                              ),
                            );
                            return;
                          }
                          if (_descriptionController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please enter the description',
                                ),
                              ),
                            );
                            return;
                          }
                          if (category.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please select the category',
                                ),
                              ),
                            );
                            return;
                          }
                          if (declarationIcon!.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please select the image',
                                ),
                              ),
                            );
                            return;
                          }
                          if (widget.declarations != null) {
                            adminBloc.add(
                              UpdateDeclaration(
                                DeclarationModel(
                                  declarationId:
                                      widget.declarations!.declarationId,
                                  title: _titleController.text,
                                  status: status,
                                  description: _descriptionController.text,
                                  declarationCategory: category,
                                  image: declarationIcon,
                                ),
                                declarationIcon == widget.declarations!.image
                                    ? null
                                    : XFile(declarationIcon!),
                              ),
                            );
                          } else {
                            adminBloc.add(
                              CreateDeclaration(
                                DeclarationModel(
                                  declarationId:
                                      DateTime.now().toIso8601String(),
                                  title: _titleController.text,
                                  status: status,
                                  description: _descriptionController.text,
                                  declarationCategory: category,
                                  image: declarationIcon,
                                ),
                                XFile(declarationIcon!),
                              ),
                            );
                          }
                        },
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
