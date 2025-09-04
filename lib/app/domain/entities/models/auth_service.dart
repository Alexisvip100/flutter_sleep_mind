// ignore_for_file: non_constant_identifier_names

class AuthUser {
  final String? user_id;
  final String? name;
  final String? email;
  final String? avatar;
  final bool? is_premium;

  AuthUser({
    required this.user_id, 
    required this.name, 
    required this.email, 
    required this.avatar, 
    required this.is_premium, 
  });

}
