import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseService {
  DatabaseService._();

  static Future<void> inicializar() async {
    final url = dotenv.env['SUPABASE_URL'];
    final anonKey = dotenv.env['SUPABASE_ANON_KEY'];

    if (url == null || url.isEmpty || anonKey == null || anonKey.isEmpty) {
      throw Exception(
        'SUPABASE_URL e SUPABASE_ANON_KEY devem estar definidos no arquivo .env',
      );
    }

    await Supabase.initialize(url: url, anonKey: anonKey);
  }
}
