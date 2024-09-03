import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_labify/features/user/user_bloc/user_bloc.dart';
import 'package:mind_labify/models/journal_model.dart';
import 'package:mind_labify/utils/gaps.dart';
import 'package:mind_labify/widgets/app_primary_button.dart';

class WriteJournals extends StatefulWidget {
  final JournalModel? journal;
  const WriteJournals({
    super.key,
    required this.journal,
  });

  @override
  State<WriteJournals> createState() => _WriteJournalsState();
}

class _WriteJournalsState extends State<WriteJournals> {
  late JournalModel journal;
  final TextEditingController answerController = TextEditingController();
  @override
  void initState() {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    if (widget.journal!.answers![userId] != null) {
      answerController.text = widget.journal!.answers![userId] ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = context.watch<UserBloc>();
    String userId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      backgroundColor: const Color(
        0xFFF4F2E9,
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
          icon: const Icon(
            CupertinoIcons.xmark,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: const Color(
                  0xFFffffff,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.journal!.title ?? '',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Gaps.hGap20,
                    TextFormField(
                      controller: answerController,
                      autofocus: true,
                      maxLines: 15,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Your Answer...',
                        hintStyle: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 211, 209, 209),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Gaps.hGap20,
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocConsumer<UserBloc, UserState>(
                      listener: (context, state) {
                        if (state is JournalAnswerUpdated ||
                            state is WriteJournalLoaded) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Answer added successfully',
                              ),
                            ),
                          );
                          answerController.clear();
                          Navigator.pop(
                            context,
                          );
                        } else if (state is JournalAnswerUpdatedFailed) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(
                            SnackBar(
                              content: Text(
                                state.message,
                              ),
                            ),
                          );
                        } else if (state is WriteJournalLoadingError) {
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
                        if (state is JournalAnswerUpdating ||
                            state is WriteJournalLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return SizedBox(
                          width: 150,
                          child: AppPrimaryButton(
                            text: widget.journal!.answers![userId] != null
                                ? 'Update'
                                : 'Save',
                            onTap: () {
                              if (answerController.text.trim().isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Please enter the answer',
                                    ),
                                  ),
                                );
                                return;
                              }
                              userBloc.add(
                                UpdateJournalAnswer(
                                  widget.journal!.journalld ?? '',
                                  answerController.text,
                                ),
                              );
                              userBloc.add(
                                WriteJournal(
                                  widget.journal!.journalld ?? '',
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 150,
                      child: AppPrimaryButton(
                        buttonColor: 0xFFD9D8D8,
                        text: 'Cancel',
                        onTap: () {
                          Navigator.pop(
                            context,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
