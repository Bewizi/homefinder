import 'package:homefinder/core/data/supabase_api.dart';
import 'package:homefinder/features/home/domain/homes_domain.dart';
import 'package:homefinder/features/home/domain/homes_repository.dart';

class HomesData implements HomesRepository {
  @override
  Future<List<HomesDomain>> getAllHomes() async {
    try {
      final userId = supaBase.auth.currentUser?.id;

      // Fetch homes and check if they are in favorites for the current user
      // Using a RPC or a complex select if relationships are set up,
      // but for simplicity and clear logic:
      final List<dynamic> homesData = await supaBase
          .schema('homes_table')
          .from('homes')
          .select();

      var favouriteHomeIds = <dynamic>[];
      if (userId != null) {
        final favourites = await supaBase
            .schema('homes_table')
            .from('favourites')
            .select('home_id')
            .eq('user_id', userId);
        favouriteHomeIds = favourites.map((e) => e['home_id']).toList();
      }

      return homesData.map((e) {
        final map = e as Map<String, dynamic>;
        final isFavourite = favouriteHomeIds.contains(map['id']);
        return HomesDomain.fromMap({...map, 'is_favourite': isFavourite});
      }).toList();
    } catch (e) {
      throw Exception('Error Fetching All Homes: $e');
    }
  }

  @override
  Future<void> toggleFavourite(String homeId, bool isCurrentlyFavourite) async {
    try {
      final userId = supaBase.auth.currentUser?.id;
      if (userId == null) throw Exception('User not authenticated');

      if (isCurrentlyFavourite) {
        // Remove from favourites
        await supaBase
            .schema('homes_table')
            .from('favourites')
            .delete()
            .eq('user_id', userId)
            .eq('home_id', homeId);
      } else {
        // Add to favourites
        await supaBase.schema('homes_table').from('favourites').insert({
          'user_id': userId,
          'home_id': homeId,
        });
      }
    } catch (e) {
      throw Exception('Error toggling favourite: $e');
    }
  }

  @override
  Future<List<HomesDomain>> getFavouriteHomes() async {
    try {
      final userId = supaBase.auth.currentUser?.id;
      if (userId == null) return [];

      // Fetch homes joined with favourites table filtered by userId
      final List<dynamic> data = await supaBase
          .schema('homes_table')
          .from('favourites')
          .select('homes(*)')
          .eq('user_id', userId);

      return data.map((e) {
        final homeMap = e['homes'] as Map<String, dynamic>;
        return HomesDomain.fromMap({...homeMap, 'is_favourite': true});
      }).toList();
    } catch (e) {
      throw Exception('Error Fetching Favourite Homes: $e');
    }
  }
}
