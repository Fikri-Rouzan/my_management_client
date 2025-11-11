import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static const agendaCategories = ['Travel', 'Food & Drink', 'Sport', 'Family'];

  static final String googleAIAPIKey =
      dotenv.env['GOOGLE_AI_API_KEY'] ?? 'API_KEY_NOT_FOUND';
}
