import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shuttle_monitor_web/service/account.dart';

Scaffold loginBox(context) => Scaffold(
      body: Center(
        child: Container(
          width: 500,
          height: 600,
          decoration: BoxDecoration(border: Border.all()),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                child: Center(
                  child: Text(
                    '경복대학교 셔틀버스 관리 시스템 (KSM System)',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
              loginInputBox,
              FutureBuilder(
                  future: getAccountFetch(),
                  builder: (context, snapshot) {
                    return TextButton(
                      onPressed: () {
                        authModule(context, _controllerID.value.text,
                            _controllerPWD.value.text);
                        if (snapshot.hasData) {
                          debugPrint(snapshot.data.toString());
                          // authModule(context, _controllerID.value.text,
                          //     _controllerPWD.value.text);
                        } else {
                          debugPrint(snapshot.error.toString());
                        }
                      },
                      child: const Text('로그인'),
                    );
                  })
            ],
          ),
        ),
      ),
    );

TextEditingController _controllerID = TextEditingController();
TextEditingController _controllerPWD = TextEditingController();

Column loginInputBox = Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    inputBox(label: 'ID', controller: _controllerID),
    const SizedBox(height: 20),
    inputBox(label: 'PWD', controller: _controllerPWD),
  ],
);

Container inputBox({
  required String label,
  required TextEditingController controller,
}) {
  return Container(
    padding: const EdgeInsets.all(2),
    decoration: BoxDecoration(border: Border.all()),
    width: 300,
    child: TextField(
      decoration: InputDecoration(border: InputBorder.none, helperText: label),
      controller: controller,
    ),
  );
}

void authModule(BuildContext context, String id, String pwd) {
  debugPrint('ID$id, PWD$pwd');
  if (id == 'OPER') {
    if (pwd == 'OPER') {
      GoRouter.of(context).goNamed('oper');
    }
  }
  if (id == 'mag') {
    if (pwd == 'mag') {
      GoRouter.of(context).goNamed('mag');
    }
  }
}
