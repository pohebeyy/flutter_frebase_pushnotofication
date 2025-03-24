import 'package:firebase_messaging/firebase_messaging.dart';

class Firebaseapi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<String?> initNotification() async {
    // Запрос разрешения на отправку уведомлений
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // Получение токена
      String? fcmToken = await _firebaseMessaging.getToken();
      print('FCM Token: $fcmToken');

      // Обработка входящих сообщений в foreground
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Получено сообщение: ${message.notification?.title}');
        // Здесь можно добавить дополнительную логику для отображения уведомления
      });

      return fcmToken;
    } else {
      print('Пользователь не дал разрешение на уведомления');
      return null;
    }
  }
}