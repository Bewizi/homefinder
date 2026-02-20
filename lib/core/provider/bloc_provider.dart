import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homefinder/features/home/data/homes_data.dart';
import 'package:homefinder/features/home/presentation/bloc/homes_bloc.dart';

final appBlocProvider = [
  BlocProvider<HomesBloc>(
    create: (context) => HomesBloc(
      homesRepository: HomesData(),
    )..add(FetchHomes()),
  )
];
