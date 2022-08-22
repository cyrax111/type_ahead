import 'package:type_ahead/navigation/navigation.dart';
import 'package:type_ahead/screens/app/nav/app_nav_cubit.dart';

class NavigationMock implements BaseNav {
  @override
  BasePath get currentPath => HomePath();

  @override
  BasePath get homePath => HomePath();

  @override
  BaseNav? get parent => null;

  @override
  void pop() {}

  @override
  void routeTo(BasePath state) {}
}
