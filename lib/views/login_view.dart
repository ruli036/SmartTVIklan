import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:user_smart_tv/controllers/login_controller.dart';
import 'package:user_smart_tv/helpers/helpers.dart';
import 'package:user_smart_tv/views/home_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());
    switch (loginController.loginStatus){
      case LoginStatus.notSignIn:
        return Scaffold(
          backgroundColor: Colors.white,
          body: RotatedBox(
            quarterTurns: -3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: SizedBox(
                    height: 300,
                    width: 300,
                    child: Image.asset("assets/logo.jpg"),
                  ),
                ),
                const Center(child: Text("Wellcome!",style: TextStyle(fontSize: 20),)),
                Center(
                  child: Shortcuts(
                    shortcuts: <LogicalKeySet, Intent>{
                      LogicalKeySet(LogicalKeyboardKey.select):const ActivateIntent()
                    },
                    child: SizedBox(
                      width: 200,
                      child: ElevatedButton(
                          onPressed: (){
                            loginController.cekKoneksi();
                          },
                          child: Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: FaIcon(FontAwesomeIcons.google),
                              ),
                              Text("Login With Google")
                            ],
                          )
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      case LoginStatus.signIn:
           return const HomeView();
    }

  }
}
