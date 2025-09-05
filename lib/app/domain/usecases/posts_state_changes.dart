import 'package:sleep_mind/app/domain/entities/models/post_user.dart';
import 'package:sleep_mind/app/domain/repositories/post_repository.dart';

class PostsStateChanges {
  final PostUserRepository repo;
  PostsStateChanges(this.repo);
  
  Stream<List<PostUser>> call() => repo.postStateChanges();
  
  Future<void> loadPosts() => repo.loadPosts();
}