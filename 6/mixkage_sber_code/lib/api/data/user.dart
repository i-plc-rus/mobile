// ignore_for_file: public_member_api_docs, sort_constructors_first

class User {
  int id;
  String name;
  NotificationSettings notificationSettings;

  // Конструктор с параметрами
  User({
    required this.id,
    required this.name,
    required this.notificationSettings,
  });

  // Конструктор по умолчанию
  User.defaultConstructor()
      : id = 1,
        name = 'John Doe',
        notificationSettings = NotificationSettings.defaultConstructor();

  // Конвертация объекта в JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'notificationSettings': notificationSettings.toJson(),
      };

  // Создание объекта из JSON
  factory User.fromJson(final Map<String, dynamic> json) => User(
        id: json['id'] is int ? json['id'] : int.parse(json['id']),
        name: json['name'],
        notificationSettings:
            NotificationSettings.fromJson(json['notificationSettings']),
      );

  User copyWith({
    final int? id,
    final String? name,
    final NotificationSettings? notificationSettings,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        notificationSettings: notificationSettings ?? this.notificationSettings,
      );
}

class NotificationSettings {
  SmsSettings sms;
  PushSettings push;
  EmailSettings email;

  // Конструктор с параметрами
  NotificationSettings({
    required this.sms,
    required this.push,
    required this.email,
  });

  // Конструктор по умолчанию
  NotificationSettings.defaultConstructor()
      : sms = SmsSettings.defaultConstructor(),
        push = PushSettings.defaultConstructor(),
        email = EmailSettings.defaultConstructor();

  // Конвертация объекта в JSON
  Map<String, dynamic> toJson() => {
        'sms': sms.toJson(),
        'push': push.toJson(),
        'email': email.toJson(),
      };

  // Создание объекта из JSON
  factory NotificationSettings.fromJson(final Map<String, dynamic> json) =>
      NotificationSettings(
        sms: SmsSettings.fromJson(json['sms']),
        push: PushSettings.fromJson(json['push']),
        email: EmailSettings.fromJson(json['email']),
      );

  NotificationSettings copyWith({
    final SmsSettings? sms,
    final PushSettings? push,
    final EmailSettings? email,
  }) =>
      NotificationSettings(
        sms: sms ?? this.sms,
        push: push ?? this.push,
        email: email ?? this.email,
      );
}

class SmsSettings {
  bool enabled;
  String? number;

  // Конструктор с параметрами
  SmsSettings({
    required this.enabled,
    this.number,
  });

  // Конструктор по умолчанию
  SmsSettings.defaultConstructor()
      : enabled = true,
        number = '+123456789';

  // Конвертация объекта в JSON
  Map<String, dynamic> toJson() => {
        'enabled': enabled,
        'number': number,
      };

  // Создание объекта из JSON
  factory SmsSettings.fromJson(final Map<String, dynamic> json) => SmsSettings(
        enabled: json['enabled'],
        number: json['number'],
      );

  SmsSettings copyWith({
    final bool? enabled,
    final String? number,
  }) =>
      SmsSettings(
        enabled: enabled ?? this.enabled,
        number: number ?? this.number,
      );
}

class PushSettings {
  bool enabled;

  // Конструктор с параметрами
  PushSettings({
    required this.enabled,
  });

  // Конструктор по умолчанию
  PushSettings.defaultConstructor() : enabled = true;

  // Конвертация объекта в JSON
  Map<String, dynamic> toJson() => {
        'enabled': enabled,
      };

  // Создание объекта из JSON
  factory PushSettings.fromJson(final Map<String, dynamic> json) =>
      PushSettings(
        enabled: json['enabled'],
      );

  PushSettings copyWith({
    final bool? enabled,
  }) =>
      PushSettings(
        enabled: enabled ?? this.enabled,
      );
}

class EmailSettings {
  bool enabled;
  String? address;

  // Конструктор с параметрами
  EmailSettings({
    required this.enabled,
    this.address,
  });

  // Конструктор по умолчанию
  EmailSettings.defaultConstructor()
      : enabled = false,
        address = 'john.doe@example.com';

  // Конвертация объекта в JSON
  Map<String, dynamic> toJson() => {
        'enabled': enabled,
        'address': address,
      };

  // Создание объекта из JSON
  factory EmailSettings.fromJson(final Map<String, dynamic> json) =>
      EmailSettings(
        enabled: json['enabled'],
        address: json['address'],
      );

  EmailSettings copyWith({
    final bool? enabled,
    final String? address,
  }) =>
      EmailSettings(
        enabled: enabled ?? this.enabled,
        address: address ?? this.address,
      );
}
