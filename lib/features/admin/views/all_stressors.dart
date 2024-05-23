import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_labify/features/admin/admin_bloc/admin_bloc.dart';
import 'package:mind_labify/features/admin/views/add_stressor.dart';
import 'package:mind_labify/features/admin/views/sub_features/all_users/widgets/search_field.dart';
import 'package:mind_labify/utils/gaps.dart';

class AllStressors extends StatefulWidget {
  const AllStressors({super.key});

  @override
  State<AllStressors> createState() => _AllStressorsState();
}

class _AllStressorsState extends State<AllStressors> {
  late final AdminBloc adminBloc;

  @override
  void initState() {
    adminBloc = context.read<AdminBloc>();
    if (adminBloc.stressors.isEmpty) {
      adminBloc.add(
        GetStressor(),
      );
    }
    super.initState();
  }

  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF1F1F1,
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
            vertical: 55,
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
                  children: [
                    const Text(
                      'All Stressors',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Color(
                          0xFF131313,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddStressor(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFF000000,
                          ),
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                        ),
                        child: const Text(
                          '+ Add Stressor',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(
                              0xFFffffff,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 277,
                      child: SearchField(
                        controller: _searchController,
                      ),
                    ),
                  ],
                ),
                Gaps.hGap30,
                BlocBuilder<AdminBloc, AdminState>(
                  builder: (context, state) {
                    if (state is GettingStressor) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is GetStressorFailed) {
                      return Center(
                        child: Text(state.message),
                      );
                    }
                    return adminBloc.stressors.isEmpty
                        ? const Center(
                            child: Text(
                              'No Stressors',
                            ),
                          )
                        : DataTable(
                            headingTextStyle: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(
                                0xFF131313,
                              ),
                            ),
                            dataTextStyle: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(
                                0xFF131313,
                              ),
                            ),
                            columns: const [
                              DataColumn(
                                label: Text(
                                  'Name',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Status',
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Actions',
                                ),
                              ),
                            ],
                            rows: adminBloc.stressors
                                .map(
                                  (stressor) => DataRow(
                                    cells: [
                                      DataCell(
                                        Text(
                                          stressor.title ?? '',
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          stressor.status ?? '',
                                        ),
                                      ),
                                      DataCell(
                                        TextButton(
                                          onPressed: () {},
                                          child: const Text(
                                            'Edit',
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                              color: Color(
                                                0xFF131313,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),);
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
