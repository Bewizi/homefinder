import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homefinder/features/auth/data/auth_data.dart';
import 'package:homefinder/features/auth/presentaion/auth_bloc/auth_bloc.dart';
import 'package:homefinder/features/home/data/homes_data.dart';
import 'package:homefinder/features/home/data/recommended_homes_data.dart';
import 'package:homefinder/features/home/presentation/homes_bloc/homes_bloc.dart';
import 'package:homefinder/features/home/presentation/recommended_homes_bloc/recommended_homes_bloc.dart';

final List<BlocProvider> appBlocProvider = [
  BlocProvider<AuthBloc>(
    create: (context) => AuthBloc(AuthRepositoryImpl())..add(CheckAuthStatus()),
  ),
  BlocProvider<HomesBloc>(
    create: (context) => HomesBloc(
      homesRepository: HomesData(),
    )..add(FetchHomes()),
  ),
  BlocProvider<RecommendedHomesBloc>(
    create: (context) => RecommendedHomesBloc(
      recommendedHomesRepository: RecommendedHomesData(),
    )..add(FetchRecommendedHomes()),
  ),
];
