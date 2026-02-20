import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:homefinder/features/home/domain/homes_domain.dart';
import 'package:homefinder/features/home/domain/homes_repository.dart';

class HomesData implements HomesRepository {
  @override
  Future<List<HomesDomain>> getAllHomes() async {
    try {
      final allHomes = await rootBundle.loadString(
        'lib/core/data/dummy_data/dummy_home.json',
      );
      final list = json.decode(allHomes) as List;
      return list
          .map((e) => HomesDomain.fromMap(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Error Fetching All Home: $e');
    }
  }
}
