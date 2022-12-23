import 'package:get/get.dart';
import 'package:user_smart_tv/views/home_view.dart';
import 'package:user_smart_tv/views/login_view.dart';


final List<GetPage<dynamic>> route = [
  GetPage(name: '/login', page:()=> const LoginView()),
  GetPage(name: '/home', page:()=> const HomeView()),
];

