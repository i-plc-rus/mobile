/// Хранит все ключи для secure_storage
enum SSKeys {
  /// Думал реализовать систему авторизации, но что-то не успеваю
  /// Ключ, по которому хранится JWT токен
  jwtToken('jwt_token'),

  /// Ключ, по которому хранится Refresh-токен
  refreshToken('refresh_token'),

  /// Вместо системы авторизации
  userId('user_id'),

  /// User in json
  user('user');

  final String keyName;

  const SSKeys(this.keyName);
}
