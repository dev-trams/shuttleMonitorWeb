import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Scaffold operScreen(BuildContext context) => Scaffold(
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width / 4,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.orange),
                  child: const Column(
                    children: [],
                  )),
              Container(
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.orange),
                  child: const Column()),
              Container(
                  width: MediaQuery.of(context).size.width / 4,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.orange),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.red,
                                border: Border.all(color: Colors.black)),
                          )
                        ],
                      )
                    ],
                  )),
            ],
          )),
    );
