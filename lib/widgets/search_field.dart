import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_paginator/flutter_paginator.dart';
import 'package:http/http.dart';
import 'package:idea_deck/database/shared_perf.dart';
import 'package:idea_deck/models/ads.dart';
import 'package:idea_deck/network/http.dart';

import '../constants.dart';
import '../size_config.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key key,
    this.paginatorGlobalKey,
  }) : super(key: key);

  final GlobalKey<PaginatorState> paginatorGlobalKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4.0),
      width: SizeConfig.screenWidth * 0.6,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
          textInputAction: TextInputAction.search,
          onSubmitted: (value) {
            print(value);

            Future<PaginatedProducts> searchAdvertisements(int page) async {
              //   '${baseURL}videos?cat=${widget.category.slug}&page=$page',

              try {
                final response = await get(
                    Uri.parse('${baseURL}videos?page=$page&q=$value'),
                    headers: {
                      'Content-Type': 'application/json',
                      'Accept': 'application/json',
                      'Authorization': 'Bearer ${sharedPrefs.token}',
                    });
                print(json.decode(response.body));
                return PaginatedProducts.fromResponse(response);
              } catch (e) {
                if (e is IOException) {
                  return PaginatedProducts.withError(
                      errorMessage: 'Please check your internet connection.');
                } else {
                  print(e.toString());
                  return PaginatedProducts.withError(
                      errorMessage: 'Something went wrong.');
                }
              }
            }

            paginatorGlobalKey.currentState.changeState(
                pageLoadFuture: searchAdvertisements, resetState: true);
          },
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                  vertical: getProportionateScreenWidth(9)),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              hintText: " search",
              prefixIcon: Icon(Icons.search, color: kPrimaryColor)),
          cursorColor: buttonColor),
    );
  }
}
