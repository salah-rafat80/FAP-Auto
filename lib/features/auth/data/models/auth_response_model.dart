class AuthResponseModel {
  final String status;
  final String? messageAr;
  final String? messageEn;
  final String? errorCode;
  final String? otp;
  final String? token;
  final int? userId;
  final String? userType;
  final String? nameArabic;
  final String? nameEnglish;
  final String? phone;
  final String? address;

  AuthResponseModel({
    required this.status,
    this.messageAr,
    this.messageEn,
    this.errorCode,
    this.otp,
    this.token,
    this.userId,
    this.userType,
    this.nameArabic,
    this.nameEnglish,
    this.phone,
    this.address,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      status: json['status'] ?? '',
      messageAr: json['messageArabic'] ?? json['messageAr'],
      messageEn: json['messageEnglish'] ?? json['messageEn'],
      errorCode: json['errorCode'],
      otp: json['otp']?.toString(),
      token: json['token'],
      userId: json['userId'],
      userType: json['userType'],
      nameArabic: json['nameArabic'],
      nameEnglish: json['nameEnglish'],
      phone: json['phone'],
      address: json['address'],
    );
  }
}
