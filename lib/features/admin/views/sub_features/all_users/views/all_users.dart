import 'package:flutter/material.dart';
import 'package:mind_labify/features/admin/views/sub_features/all_users/widgets/filter_field.dart';
import 'package:mind_labify/features/admin/views/sub_features/all_users/widgets/search_field.dart';
import 'package:mind_labify/utils/gaps.dart';

class AllUsers extends StatefulWidget {
  const AllUsers({super.key});

  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
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
                      'All Users',
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
                    FilterField(
                      title: 'Filter by Age',
                      onPressed: () {},
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    FilterField(
                      title: 'Filter by Gender',
                      onPressed: () {},
                    ),
                    const SizedBox(
                      width: 05,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Clear All',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontFamily: 'Inter',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(
                            0xFF131313,
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
                DataTable(
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
                        'User ID',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'User Name',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Mobile No.',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'User Email',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Age',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Gender',
                      ),
                    ),
                  ],
                  rows: const [
                    DataRow(
                      cells: [
                        DataCell(
                          Text(
                            '#12222',
                          ),
                        ),
                        DataCell(
                          Text(
                            'Austin',
                          ),
                        ),
                        DataCell(
                          Text(
                            '222-2222-222',
                          ),
                        ),
                        DataCell(
                          Text(
                            'abc@gmail.com',
                          ),
                        ),
                        DataCell(
                          Text(
                            '32 years',
                          ),
                        ),
                        DataCell(
                          Text(
                            'Male',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
