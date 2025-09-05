import 'package:sleep_mind/app/domain/entities/models/auth_service.dart';
import 'package:sleep_mind/app/domain/entities/models/post_user.dart';
import 'api/api_service.dart';

abstract class UserRemoteDataSource {
  Future<void> syncUserData(AuthUser user);
  Future<List<PostUser>> getAllPostUser();
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
  Future<List<PostUser>> getAllPostUser() async {
    try {
      print('🔄 Obteniendo posts del usuario...');
      final response = await apiService.getUserData(endpoint: '/post');
      print('✅ Posts obtenidos exitosamente: $response');

      // Convertir la respuesta a lista de PostUser
      final data = response['data'];
      if (data['posts'] is List) {
        final postsList = data['posts'] as List;
        return postsList.map((post) => PostUser.fromJson(post)).toList();
      }
      return [];
    } catch (e) {
      print('❌ Error obteniendo posts del usuario: $e');
      return [];
    }
  }
}
