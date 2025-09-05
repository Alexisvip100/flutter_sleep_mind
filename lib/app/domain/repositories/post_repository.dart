

import 'package:sleep_mind/app/domain/entities/models/post_user.dart';

abstract class PostUserRepository {
  Stream<List<PostUser>> postStateChanges();
  List<PostUser>? get allPostUser;
  Future<void> loadPosts();
  void dispose();
}