import 'package:jamal_ed/ui/screens/home/home.dart';
import 'package:jamal_ed/ui/screens/login/login.dart';
import 'package:jamal_ed/ui/screens/splash/splash.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

const String routeSplash = '/';
const String routeHome = '/home';
const String routeLogin = '/login';

List<GetPage> routes = [
  GetPage(
    name: routeSplash,
    page: () => const SplashScreen(),
  ),
  GetPage(
    name: routeHome,
    page: () => const HomeScreen(),
  ),
  GetPage(
    name: routeLogin,
    page: () => const LoginScreen(),
  ),
];
