import 'package:supabase_flutter/supabase_flutter.dart';

class SupaBaseApi {
  static const String url = 'https://xoyivdjzatxyibxxongv.supabase.co';
  static const String anonKey =
      'sb_publishable_JOa7YStwUDhhQbYowvB4tg_Q-AKOMcn';
}

final SupabaseClient supaBase = Supabase.instance.client;
