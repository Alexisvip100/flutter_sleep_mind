import 'dart:async';
import 'package:sleep_mind/app/domain/entities/models/post_user.dart';
import 'package:sleep_mind/app/domain/repositories/post_repository.dart';
import 'package:sleep_mind/app/data/datasources/remote/user_remote_data_source.dart';

class PostRepositoryImpl implements PostUserRepository {
  final UserRemoteDataSource remoteDataSource;
  final StreamController<List<PostUser>> _postsController = StreamController<List<PostUser>>.broadcast();
  
  PostRepositoryImpl(this.remoteDataSource);

  @override
  Stream<List<PostUser>> postStateChanges() => _postsController.stream;

  @override
  List<PostUser>? get allPostUser => _postsController.hasListener ? null : [];

  Future<void> loadPosts() async {
    try {
      print('🔄 Cargando posts desde el repositorio...');
      final posts = await remoteDataSource.getAllPostUser();
      print('✅ Posts cargados: ${posts.length} posts');
      _postsController.add(posts);
    } catch (e) {
      print('❌ Error cargando posts: $e');
      _postsController.add([]);
    }
  }

  void dispose() {
    _postsController.close();
  }
}
