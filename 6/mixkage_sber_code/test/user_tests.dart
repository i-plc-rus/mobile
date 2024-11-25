import 'package:flutter_test/flutter_test.dart';
import 'package:mixkage_sber_code/api/data/user.dart';

void main() {
  group('User model tests', () {
    test('Convert User to JSON', () {
      // Создаем тестовые данные
      final user = User(
        id: 1,
        name: 'John Doe',
        notificationSettings: NotificationSettings(
          sms: SmsSettings(enabled: true, number: '+123456789'),
          push: PushSettings(enabled: true),
          email: EmailSettings(enabled: false, address: 'john.doe@example.com'),
        ),
      );

      // Преобразуем объект в JSON
      final json = user.toJson();

      // Проверяем, что преобразование прошло успешно
      expect(json, {
        'id': 1,
        'name': 'John Doe',
        'notificationSettings': {
          'sms': {'enabled': true, 'number': '+123456789'},
          'push': {'enabled': true},
          'email': {'enabled': false, 'address': 'john.doe@example.com'},
        },
      });
    });

    test('Convert JSON to User', () {
      // JSON данные, которые нужно конвертировать
      final json = {
        'id': 1,
        'name': 'John Doe',
        'notificationSettings': {
          'sms': {'enabled': true, 'number': '+123456789'},
          'push': {'enabled': true},
          'email': {'enabled': false, 'address': 'john.doe@example.com'},
        },
      };

      // Конвертируем JSON в объект User
      final user = User.fromJson(json);

      // Проверяем, что объект был создан правильно
      expect(user.id, 1);
      expect(user.name, 'John Doe');
      expect(user.notificationSettings.sms.enabled, true);
      expect(user.notificationSettings.sms.number, '+123456789');
      expect(user.notificationSettings.push.enabled, true);
      expect(user.notificationSettings.email.enabled, false);
      expect(user.notificationSettings.email.address, 'john.doe@example.com');
    });
  });

  group('NotificationSettings tests', () {
    test('Convert NotificationSettings to JSON', () {
      // Создаем тестовые данные
      final settings = NotificationSettings(
        sms: SmsSettings(enabled: true, number: '+123456789'),
        push: PushSettings(enabled: true),
        email: EmailSettings(enabled: false, address: 'john.doe@example.com'),
      );

      // Преобразуем объект в JSON
      final json = settings.toJson();

      // Проверяем, что преобразование прошло успешно
      expect(json, {
        'sms': {'enabled': true, 'number': '+123456789'},
        'push': {'enabled': true},
        'email': {'enabled': false, 'address': 'john.doe@example.com'},
      });
    });

    test('Convert JSON to NotificationSettings', () {
      // JSON данные, которые нужно конвертировать
      final json = {
        'sms': {'enabled': true, 'number': '+123456789'},
        'push': {'enabled': true},
        'email': {'enabled': false, 'address': 'john.doe@example.com'},
      };

      // Конвертируем JSON в объект NotificationSettings
      final settings = NotificationSettings.fromJson(json);

      // Проверяем, что объект был создан правильно
      expect(settings.sms.enabled, true);
      expect(settings.sms.number, '+123456789');
      expect(settings.push.enabled, true);
      expect(settings.email.enabled, false);
      expect(settings.email.address, 'john.doe@example.com');
    });
  });
}
