// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../utils/kai_utils.dart';
import '../common/theme.dart';
import 'catalog.dart';

class MyLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome',
                // style: Theme.of(context).textTheme.headline1,
                style: appTheme.textTheme.headline1,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Username',
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
                obscureText: true,
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                child: const Text('ENTER'),
                onPressed: () {
                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyCatalog()));
                  // BoostNavigator.instance.pushReplacement('/provider_shopper_page_catalog');
                  navigatorPushReplacement(context, '/provider_shopper_page_catalog');
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellow,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                child: const Text('to native Page'),
                onPressed: () {
                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyCatalog()));
                  Map args = <String, dynamic>{
                    'title': 'From Flutter (Login.dart)',
                    'keyInt': 1983,
                    'keyFloat': 12.24,
                    "keyMap": {'hahaKey': 'hahaValue'}
                  };
                  navigatorPush(context, 'nativeTestPage', arguments: args)
                      .then((value) => Fluttertoast.showToast(msg: 'kaiReturnValue: $value'));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellow,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
