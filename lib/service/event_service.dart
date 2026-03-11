import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:local_baba/service/user_service.dart';


class EventService {

  Future<void> logEvent({
    required String eventType,
    String? productId,
    String? categoryId,
    String? storeId,
    String? sessionId,
    Map<String, dynamic>? metadata,
  }) async {

    final body = {
      "event_type": eventType,
      "product_id": productId,
      "category_id": categoryId,
      "store_id": storeId,
      "session_id": sessionId,
      "metadata": metadata,
      "device_id": "deviceInfo",
      "time": DateTime.now().toIso8601String()
    };

    try {
      await http.post(
        Uri.parse("$baseUrl/store/log-event"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(body),
      );
    } catch (e) {
      print("Event logging failed: $e");
    }
  }
}