import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mind_labify/features/admin/admin_bloc/admin_bloc.dart';
import 'package:mind_labify/models/declaration_model.dart';
import 'package:mind_labify/utils/gaps.dart';
import 'package:mind_labify/widgets/app_primary_button.dart';

class CreateDeclarationScreen extends StatefulWidget {
  const CreateDeclarationScreen({super.key});

  @override
  State<CreateDeclarationScreen> createState() =>
      _CreateDeclarationScreenState();
}

class _CreateDeclarationScreenState extends State<CreateDeclarationScreen> {
  late final AdminBloc adminBloc;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String category = '';
  String createdBy = FirebaseAuth.instance.currentUser!.uid;
  String? declarationIcon;
  final picker = ImagePicker();

  @override
  void initState() {
    adminBloc = context.read<AdminBloc>();
    adminBloc.add(
      GetDeclarationCategory(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final adminBloc = context.watch<AdminBloc>();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text(
          'Create your own declarations',
        ),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 15,
          fontWeight: FontWeight.w800,
          color: Color(
            0xFF573926,
          ),
        ),
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        9.0,
                      ),
                      borderSide: const BorderSide(
                        color: Color(
                          0xFFCCCACA,
                        ),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        9.0,
                      ),
                      borderSide: const BorderSide(
                        color: Color(
                          0xFFCCCACA,
                        ),
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 11,
                    ),
                    hintText: 'Title',
                    hintStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(
                        0xFFB7B7B7,
                      ),
                    ),
                  ),
                ),
                Gaps.hGap20,
                TextFormField(
                  maxLines: 6,
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        9.0,
                      ),
                      borderSide: const BorderSide(
                        color: Color(
                          0xFFCCCACA,
                        ),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        9.0,
                      ),
                      borderSide: const BorderSide(
                        color: Color(
                          0xFFCCCACA,
                        ),
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 11,
                    ),
                    hintText: 'Description',
                    hintStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(
                        0xFFB7B7B7,
                      ),
                    ),
                  ),
                ),
                Gaps.hGap20,
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 11,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      9.0,
                    ),
                    border: Border.all(
                      color: const Color(
                        0xFFCCCACA,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        'Select category',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(
                            0xFFB7B7B7,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        category,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
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
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                            child: CircularProgressIndicator(),
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
                                                alignment: Alignment.centerLeft,
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
                          color: Color(
                            0xFFB7B7B7,
                          ),
                          Icons.arrow_drop_down_rounded,
                        ),
                      ),
                    ],
                  ),
                ),
                Gaps.hGap20,
                InkWell(
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
                  child: Row(
                    children: [
                      ImageIcon(
                        color: Theme.of(context).colorScheme.secondary,
                        size: 27,
                        const AssetImage(
                          'assets/icons/media.png',
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(
                        'Attach background',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(
                            0xFF333333,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Gaps.hGap20,
                declarationIcon != null
                    ? Image.network(declarationIcon!, width: 110, height: 160)
                    : Container(),
                Gaps.hGap45,
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
                    }
                  },
                  builder: (context, state) {
                    if (state is CreatingDeclaration) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25.0,
                      ),
                      child: AppPrimaryButton(
                        text: 'Create Post',
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
                          adminBloc.add(
                            CreateDeclaration(
                              DeclarationModel(
                                declarationId: DateTime.now().toIso8601String(),
                                title: _titleController.text,
                                status: 'Active',
                                description: _descriptionController.text,
                                declarationCategory: category,
                                image: declarationIcon,
                                createdBy: createdBy,
                              ),
                              XFile(declarationIcon!),
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
      ),
    );
  }
}
