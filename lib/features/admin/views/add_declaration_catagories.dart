import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mind_labify/features/admin/admin_bloc/admin_bloc.dart';
import 'package:mind_labify/features/admin/views/admin_button.dart';
import 'package:mind_labify/models/declaration_category_model.dart';
import 'package:mind_labify/utils/gaps.dart';
import 'package:mind_labify/widgets/app_text_fields.dart';

class AddDeclarationCategory extends StatefulWidget {
  final DeclarationCategoryModel? declarationCategory;
  const AddDeclarationCategory({
    super.key,
    this.declarationCategory,
  });

  @override
  State<AddDeclarationCategory> createState() => _AddDeclarationCategoryState();
}

class _AddDeclarationCategoryState extends State<AddDeclarationCategory> {
  late DeclarationCategoryModel declarationCategory;
  final TextEditingController _nameController = TextEditingController();
  String status = 'Inactive';
  String? declarationCategoryIcon;

  @override
  void initState() {
    if (widget.declarationCategory != null) {
      _nameController.text = widget.declarationCategory!.name ?? '';
      declarationCategoryIcon = widget.declarationCategory!.icon ?? '';
      status = widget.declarationCategory!.status ?? '';
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
          widget.declarationCategory != null
              ? "Edit Declaration Category"
              : 'Add Declaration Category',
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
                        controller: _nameController,
                        hintText: 'Name',
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
                const Text(
                  'Declaration Category Icon',
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
                                    declarationCategoryIcon = iconUrl;
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
                    declarationCategoryIcon != null
                        ? Image.network(
                            declarationCategoryIcon!,
                            width: 50,
                            height: 50,
                          )
                        : Container(),
                  ],
                ),
                Gaps.hGap35,
                BlocConsumer<AdminBloc, AdminState>(
                  listener: (context, state) {
                    if (state is CreateDeclarationCategorySuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Declaration category added successfully',
                          ),
                        ),
                      );
                      _nameController.clear();
                      Navigator.pop(
                        context,
                      );
                    } else if (state is CreateDeclarationCategoryFailed) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.message,
                          ),
                        ),
                      );
                    } else if (state is UpdateDeclarationCategorySuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Declaration Category Updated',
                          ),
                        ),
                      );
                      _nameController.clear();
                      Navigator.pop(context);
                    } else if (state is UpdateDeclarationCategoryFailed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.message,
                          ),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is CreatingDeclarationCategory ||
                        state is UpdatingDeclarationCategory) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return SizedBox(
                      width: 250,
                      child: AdminButton(
                        text: widget.declarationCategory != null
                            ? 'Update'
                            : 'Add',
                        onTap: () {
                          if (_nameController.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please enter the title',
                                ),
                              ),
                            );
                            return;
                          }
                          if (declarationCategoryIcon!.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please select the icon',
                                ),
                              ),
                            );
                            return;
                          }
                          if (widget.declarationCategory != null) {
                            adminBloc.add(
                              UpdateDeclarationCategory(
                                DeclarationCategoryModel(
                                  declarationCategoryId: widget
                                      .declarationCategory!
                                      .declarationCategoryId,
                                  name: _nameController.text,
                                  status: status,
                                  icon: declarationCategoryIcon,
                                ),
                                declarationCategoryIcon ==
                                        widget.declarationCategory?.icon
                                    ? null
                                    : XFile(declarationCategoryIcon!),
                              ),
                            );
                          } else {
                            adminBloc.add(
                              CreateDeclarationCategory(
                                DeclarationCategoryModel(
                                  declarationCategoryId:
                                      DateTime.now().toIso8601String(),
                                  name: _nameController.text,
                                  status: status,
                                  icon: declarationCategoryIcon,
                                ),
                                XFile(declarationCategoryIcon!),
                              ),
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
