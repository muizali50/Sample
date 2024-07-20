import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_labify/features/admin/admin_bloc/admin_bloc.dart';
import 'package:mind_labify/features/admin/views/admin_button.dart';
import 'package:mind_labify/models/journal_model.dart';
import 'package:mind_labify/utils/gaps.dart';
import 'package:mind_labify/widgets/app_text_fields.dart';

class AddJournals extends StatefulWidget {
  final JournalModel? journals;
  const AddJournals({
    super.key,
    this.journals,
  });

  @override
  State<AddJournals> createState() => _AddJournalsState();
}

class _AddJournalsState extends State<AddJournals> {
  late JournalModel journals;
  late final AdminBloc adminBloc;
  final TextEditingController _titleController = TextEditingController();
  String category = '';
  String status = 'Inactive';
  @override
  void initState() {
    adminBloc = context.read<AdminBloc>();
    adminBloc.add(
      GetJournalCategory(),
    );

    if (widget.journals != null) {
      _titleController.text = widget.journals!.title ?? '';
      category = widget.journals!.journalCategory ?? '';
      status = widget.journals!.status ?? '';
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
          widget.journals != null ? 'Edit Journal' : 'Add Journal',
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
                        'Journal Category',
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
                                        if (state is GettingJournalCategory) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        } else if (state
                                            is GetJournalCategoryFailed) {
                                          return Center(
                                            child: Text(
                                              state.message,
                                            ),
                                          );
                                        }
                                        return Expanded(
                                          child: ListView.builder(
                                            itemCount: adminBloc
                                                .activeJournalCategories.length,
                                            itemBuilder: (context, index) {
                                              return Align(
                                                alignment: Alignment.centerLeft,
                                                child: TextButton(
                                                  onPressed: () {
                                                    setState(
                                                      () {
                                                        category = adminBloc
                                                                .activeJournalCategories[
                                                                    index]
                                                                .name ??
                                                            '';
                                                      },
                                                    );
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    adminBloc
                                                            .activeJournalCategories[
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
                Gaps.hGap35,
                BlocConsumer<AdminBloc, AdminState>(
                  listener: (context, state) {
                    if (state is CreateJournalSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Journal created successfully',
                          ),
                        ),
                      );
                      _titleController.clear();
                      Navigator.pop(
                        context,
                      );
                    } else if (state is CreateJournalFailed) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.message,
                          ),
                        ),
                      );
                    } else if (state is UpdateJournalSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Journal updated successfully',
                          ),
                        ),
                      );
                      _titleController.clear();
                      Navigator.pop(
                        context,
                      );
                    } else if (state is UpdateJournalFailed) {
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
                    if (state is CreatingJournal || state is UpdatingJournal) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return SizedBox(
                      width: 250,
                      child: AdminButton(
                        text: widget.journals != null ? 'Update' : 'Add',
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
                          if (widget.journals != null) {
                            adminBloc.add(
                              UpdateJournal(
                                JournalModel(
                                  journalld: widget.journals!.journalld,
                                  title: _titleController.text,
                                  status: status,
                                  journalCategory: category,
                                ),
                              ),
                            );
                          } else {
                            adminBloc.add(
                              CreateJournal(
                                JournalModel(
                                  journalld: DateTime.now().toIso8601String(),
                                  title: _titleController.text,
                                  status: status,
                                  journalCategory: category,
                                ),
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
