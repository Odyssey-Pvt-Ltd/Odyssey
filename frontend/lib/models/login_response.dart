class LoginResponse {
  final String jwt;
  final String message;
  final String role;

  LoginResponse({
    required this.jwt,
    required this.message,
    required this.role,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      jwt: json['jwt'] ?? '',
      message: json['message'] ?? '',
      role: json['role'] ?? '',
    );
  }
}