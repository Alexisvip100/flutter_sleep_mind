import 'package:sleep_mind/app/domain/entities/models/auth_service.dart';
import 'api/api_service.dart';

abstract class UserRemoteDataSource {
  Future<void> syncUserData(AuthUser user);
  Future<AuthUser?> getUserData(String userId);
  Future<void> updateUserData(AuthUser user);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final ApiService apiService;

  UserRemoteDataSourceImpl(this.apiService);

  @override
  Future<void> syncUserData(AuthUser user) async {
    try {
      print('🔄 Intentando sincronizar usuario: ${user.name} (${user.email})');
      final response = await apiService.postUserData(
        endpoint: '/user',
        data: {
          'name': user.name,
          'email': user.email,
          'avatar': user.avatar,
          'isPremium': user.is_premium,
        },
      );
      print('✅ Usuario sincronizado exitosamente: $response');
    } catch (e) {
      // Log error but don't throw to avoid breaking login flow
      print('❌ Error syncing user data: $e');
    }
  }

  @override
  Future<AuthUser?> getUserData(String userId) async {
    try {
      final response = await apiService.getUserData(
        endpoint: '/api/users/$userId',
      );
      
      return AuthUser(
        user_id: response['user_id'],
        name: response['name'],
        email: response['email'],
        avatar: response['avatar'],
        is_premium: response['is_premium'] ?? false,
      );
    } catch (e) {
      print('Error getting user data: $e');
      return null;
    }
  }

  @override
  Future<void> updateUserData(AuthUser user) async {
    try {
      await apiService.postUserData(
        endpoint: '/api/users/${user.user_id}',
        data: {
          'name': user.name,
          'email': user.email,
          'avatar': user.avatar,
          'is_premium': user.is_premium,
          'updated_at': DateTime.now().toIso8601String(),
        },
      );
    } catch (e) {
      print('Error updating user data: $e');
      rethrow;
    }
  }
}
