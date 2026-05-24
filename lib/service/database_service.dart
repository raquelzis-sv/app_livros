import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseService {
  // Torna o construtor privado para evitar que a classe seja instanciada
  DatabaseService._();
  // Método estático responsável por inicializar a conexão com a nuvem
  static Future<void> inicializar() async {
    await Supabase.initialize(
      url: 'https://drtvkykbvgsvffedqmge.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRydHZreWtidmdzdmZmZWRxbWdlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzk2MzAxMjAsImV4cCI6MjA5NTIwNjEyMH0.zo86r6mekFwnG6SnhfjTDR1CNdNklqpDCauZTTRWGZs',
    );
  }
}
