import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:type_ahead/providers/providers_di.dart';
import 'package:type_ahead/screens/app/nav/app_nav_cubit.dart';
import 'package:type_ahead/screens/type_ahead/type_ahead_bloc.dart';
import 'package:type_ahead/screens/type_ahead/type_ahead_repository.dart';

class TypeAheadDi extends StatefulWidget {
  const TypeAheadDi({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<TypeAheadDi> createState() => _TypeAheadDiState();
}

class _TypeAheadDiState extends State<TypeAheadDi> {
  late TypeAheadBloc _bloc;

  @override
  void initState() {
    super.initState();

    final repository = TypeAheadRepositorySimple(
      provider: ProviderDI.apiProvider,
      favoriteProvider: ProviderDI.favorite,
    );
    final navigation = BlocProvider.of<AppNavCubit>(context);
    _bloc =
        TypeAheadBloc(typeAheadRepository: repository, navigation: navigation)
          ..add(const InitializedEvent());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: widget.child,
    );
  }
}
