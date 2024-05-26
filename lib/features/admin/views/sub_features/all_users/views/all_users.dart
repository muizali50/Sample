import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_labify/features/admin/admin_bloc/admin_bloc.dart';
import 'package:mind_labify/features/admin/views/sub_features/all_users/widgets/filter_field.dart';
import 'package:mind_labify/features/admin/views/sub_features/all_users/widgets/search_field.dart';
import 'package:mind_labify/models/app_user.dart';
import 'package:mind_labify/utils/gaps.dart';

import '../widgets/custom_dialog.dart';

class AllUsers extends StatefulWidget {
  const AllUsers({super.key});

  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  late final AdminBloc adminBloc;

  List<AppUser> filteruserData = [];
  final TextEditingController searchController = TextEditingController();
  final TextEditingController searchAgeController = TextEditingController();
  String _searchText = '';
  String genderFilter = '';
  String ageFilter = '';

  @override
  void initState() {
    adminBloc = context.read<AdminBloc>();
    adminBloc.add(
      GetUserData(),
    );

    searchAgeController.addListener(
      _onAgeSearchChanged,
    );

    searchController.addListener(
      _onSearchChanged,
    );
    super.initState();
  }

  void _onSearchChanged() {
    setState(
      () {
        _searchText = searchController.text;
        _filterUsers();
      },
    );
  }

  void _onAgeSearchChanged() {
    setState(
      () {
        ageFilter = searchAgeController.text;
        _filterAge();
      },
    );
  }

  void _filterUsers() {
    if (_searchText.isEmpty) {
      filteruserData = adminBloc.userData;
    } else {
      filteruserData = adminBloc.userData
          .where(
            (user) => user.name.toLowerCase().contains(
                  _searchText.toLowerCase(),
                ),
          )
          .toList();
    }
  }

  void _filterAge() {
    if (ageFilter.isEmpty) {
      filteruserData = adminBloc.userData;
    } else {
      filteruserData = adminBloc.userData.where(
        (user) {
          return user.age == ageFilter;
        },
      ).toList();
    }
  }

  void filterGender() {
    if (genderFilter.isEmpty) {
      filteruserData = adminBloc.userData;
    } else {
      filteruserData = adminBloc.userData.where(
        (user) {
          return user.gender == genderFilter;
        },
      ).toList();
    }
  }

  void clearSearch() {
    searchAgeController.clear();
    searchController.clear();
    setState(
      () {
        filteruserData = adminBloc.userData;
      },
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    searchAgeController.dispose();
    super.dispose();
  }

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
            horizontal: 21,
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
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => CustomDialogWidget(
                            isAge: true,
                            controller: searchAgeController,
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    FilterField(
                      title: 'Filter by Gender',
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => CustomDialogWidget(
                            onPressedMale: () {
                              setState(
                                () {
                                  genderFilter = 'male';
                                },
                              );
                              filterGender();
                              Navigator.pop(
                                context,
                              );
                            },
                            onPressedFemale: () {
                              setState(
                                () {
                                  genderFilter = 'female';
                                },
                              );
                              filterGender();
                              Navigator.pop(
                                context,
                              );
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      width: 05,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(
                          () {
                            genderFilter = '';
                          },
                        );
                        filterGender();
                        clearSearch();
                      },
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
                        controller: searchController,
                      ),
                    ),
                  ],
                ),
                Gaps.hGap30,
                BlocBuilder<AdminBloc, AdminState>(
                  builder: (context, state) {
                    if (state is GetUserDataLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is GetUserDataFailed) {
                      return Center(
                        child: Text(
                          state.message,
                        ),
                      );
                    }
                    return adminBloc.userData.isNotEmpty
                        ? DataTable(
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
                            rows: filteruserData.isNotEmpty
                                ? filteruserData
                                    .map(
                                      (user) => DataRow(
                                        cells: [
                                          DataCell(
                                            Text(
                                              user.name,
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              user.phoneNumber,
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              user.email,
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              '${user.age}years',
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              user.gender.toString(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                    .toList()
                                : adminBloc.userData
                                    .map(
                                      (user) => DataRow(
                                        cells: [
                                          DataCell(
                                            Text(
                                              user.name,
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              user.phoneNumber,
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              user.email,
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              '${user.age}years',
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              user.gender.toString(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                    .toList(),
                          )
                        : const Center(
                            child: Text(
                              'No Users',
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
