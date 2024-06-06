import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mind_labify/features/admin/admin_bloc/admin_bloc.dart';
import 'package:mind_labify/features/admin/views/admin_button.dart';
import 'package:mind_labify/models/breathwork_model.dart';
import 'package:mind_labify/utils/gaps.dart';
import 'package:mind_labify/widgets/app_text_fields.dart';

class AddBreathworkCategory extends StatefulWidget {
  final BreathWorkModel? breathWork;
  const AddBreathworkCategory({
    super.key,
    this.breathWork,
  });

  @override
  State<AddBreathworkCategory> createState() => _AddBreathworkCategoryState();
}

class _AddBreathworkCategoryState extends State<AddBreathworkCategory> {
  late BreathWorkModel breathWork;
  final TextEditingController _nameController = TextEditingController();
  String status = 'Inactive';
  String? breathworkIcon;

  @override
  void initState() {
    if (widget.breathWork != null) {
      _nameController.text = widget.breathWork!.title ?? '';
      breathworkIcon = widget.breathWork!.icon ?? '';
      status = widget.breathWork!.status ?? '';
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
          widget.breathWork != null
              ? "Edit Breathwork Category"
              : 'Add Breathwork Category',
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
                  'Breathwork Icon',
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
                                    breathworkIcon = iconUrl;
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
                    breathworkIcon != null
                        ? Image.network(breathworkIcon!, width: 50, height: 50)
                        : Container(),
                  ],
                ),
                Gaps.hGap35,
                BlocConsumer<AdminBloc, AdminState>(
                  listener: (context, state) {
                    if (state is CreateBreathWorkCategorySuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Breathwork category added successfully',
                          ),
                        ),
                      );
                      _nameController.clear();
                      Navigator.pop(
                        context,
                      );
                    } else if (state is CreateBreathWorkCategoryFailed) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.message,
                          ),
                        ),
                      );
                    } else if (state is UpdateBreathWorkCategorySuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Breathwork Category Updated',
                          ),
                        ),
                      );
                      _nameController.clear();
                      Navigator.pop(context);
                    } else if (state is UpdateBreathWorkCategoryFailed) {
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
                    if (state is CreatingBreathWorkCategory ||
                        state is UpdatingBreathWorkCategory) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return SizedBox(
                      width: 250,
                      child: AdminButton(
                        text: widget.breathWork != null ? 'Update' : 'Add',
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
                          if (breathworkIcon!.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Please select the icon',
                                ),
                              ),
                            );
                            return;
                          }
                          if (widget.breathWork != null) {
                            adminBloc.add(
                              UpdateBreathWorkCategory(
                                BreathWorkModel(
                                  breathworkId: widget.breathWork!.breathworkId,
                                  title: _nameController.text,
                                  status: status,
                                  icon: breathworkIcon,
                                ),
                                breathworkIcon == widget.breathWork?.icon
                                    ? null
                                    : XFile(breathworkIcon!),
                              ),
                            );
                          } else {
                            adminBloc.add(
                              CreateBreathWorkCategory(
                                BreathWorkModel(
                                  breathworkId:
                                      DateTime.now().toIso8601String(),
                                  title: _nameController.text,
                                  status: status,
                                  icon: breathworkIcon,
                                ),
                                XFile(breathworkIcon!),
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
