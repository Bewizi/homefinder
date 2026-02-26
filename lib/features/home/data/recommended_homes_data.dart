import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:homefinder/features/home/domain/recommended_homes_domain.dart';
import 'package:homefinder/features/home/domain/recommended_homes_repository.dart';

class RecommendedHomesData implements RecommendedHomesRepository {
  @override
  Future<List<RecommendedHomesDomain>> getAllRecommendedHomes() async {
    try {
      final allRecommendedHomes = await rootBundle.loadString(
        'lib/core/data/dummy_data/dummy_home.json',
      );
      final list = json.decode(allRecommendedHomes) as List;
      return list
          .map((e) => RecommendedHomesDomain.fromMap(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Error Fetching All Home: $e');
    }
  }
}
