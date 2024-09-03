import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_labify/features/user/user_bloc/user_bloc.dart';
import 'package:mind_labify/models/declaration_model.dart';

class DeclarationDetailScreen extends StatefulWidget {
  final DeclarationModel declaration;
  const DeclarationDetailScreen({
    super.key,
    required this.declaration,
  });

  @override
  State<DeclarationDetailScreen> createState() =>
      _DeclarationDetailScreenState();
}

class _DeclarationDetailScreenState extends State<DeclarationDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final userBloc = context.read<UserBloc>();
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            widget.declaration.image ?? '',
          ),
        ),
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            alignment: Alignment.center,
            color: Colors.black.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 30,
                horizontal: 15,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(
                            context,
                          );
                        },
                        icon: const Icon(
                          color: Color(
                            0xFFffffff,
                          ),
                          Icons.arrow_back,
                        ),
                      ),
                      Text(
                        widget.declaration.title ?? '',
                        style: const TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: 'Inter',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(
                            0xFFffffff,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                        width: 10,
                      ),
                    ],
                  ),
                  Text(
                    widget.declaration.description ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: 'Inter',
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Color(
                        0xFFffffff,
                      ),
                    ),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.withOpacity(
                              0.5,
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {
                              userBloc.add(
                                AddFavouriteDeclaration(
                                  widget.declaration.declarationId ?? '',
                                  FirebaseAuth.instance.currentUser!.uid,
                                ),
                              );
                            },
                            icon: widget.declaration.isFavorite!.contains(
                              FirebaseAuth.instance.currentUser!.uid,
                            )
                                ? const Icon(
                                    color: Colors.red,
                                    Icons.favorite,
                                  )
                                : const Icon(
                                    color: Color(
                                      0xffffffff,
                                    ),
                                    Icons.favorite_outline,
                                  ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.withOpacity(
                              0.5,
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              color: Color(
                                0xffffffff,
                              ),
                              Icons.share_outlined,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
