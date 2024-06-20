import 'package:equatable/equatable.dart';

enum BiometricStatus {
  pending,
  skipped,
  enabled,
}

String getBiometricStatusString({BiometricStatus? biometricStatus}) {
  return biometricStatus == BiometricStatus.pending
      ? 'pending'
      : biometricStatus == BiometricStatus.skipped
          ? 'skipped'
          : biometricStatus == BiometricStatus.enabled
              ? 'enabled'
              : 'null';
}

BiometricStatus? getBiometricStatusEnum({String? biometricStatus}) {
  if (biometricStatus == 'pending') {
    return BiometricStatus.pending;
  } else if (biometricStatus == 'skipped') {
    return BiometricStatus.skipped;
  } else if (biometricStatus == 'enabled') {
    return BiometricStatus.enabled;
  }
  return null;
}

class AppUser with EquatableMixin {
  AppUser(
      {this.id,
      this.name,
      this.panNumber,
      this.dateOfBirth,
      this.isPanVerified,
      this.isAadhaarVerified,
      this.isLivelinessVerified,
      this.mobileNumber,
      this.biometric,
      this.aadhaarVerificationStatus,
      this.livelinessVerificationStatus,
      this.profileQuestionsStatus,
      this.connectAccountsStatus,
      this.assetsStatus,
      this.liablitiesStatus});

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'] == null ? null : int.parse(json['id'].toString()),
      mobileNumber: json['mobile_number'].toString(),
      biometric:
          getBiometricStatusEnum(biometricStatus: json['biometric'].toString()),
      name: json['name'] as String?,
      panNumber: json['pan_number'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      isPanVerified: json['is_pan_verified'] as bool?,
      isAadhaarVerified: json['is_aadhaar_verified'] as bool?,
      isLivelinessVerified: json['is_liveliness_verified'] as bool?,
      aadhaarVerificationStatus: json['aadhaar_verification_status'] as String?,
      livelinessVerificationStatus:
          json['liveliness_verification_status'] as String?,
      profileQuestionsStatus: json['profile_questions_status'] as String?,
      connectAccountsStatus: json['connect_accounts_status'] as String?,
      assetsStatus: json['assets_status'] as String?,
      liablitiesStatus: json['liablities_status'] as String?,
    );
  }

  AppUser constructUser({
    int? id,
    String? mobileNumber,
    BiometricStatus? biometric,
    String? name,
    String? panNumber,
    String? dateOfBirth,
    bool? isAadhaarVerified,
    bool? isLivelinessVerified,
    bool? isPanVerified,
    String? aadhaarVerificationStatus,
    String? livelinessVerificationStatus,
    String? profileQuestionsStatus,
    String? assetsStatus,
    String? liablitiesStatus,
    String? connectAccountsStatus,
  }) {
    return AppUser(
      id: id ?? this.id,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      biometric: biometric ?? this.biometric,
      name: name ?? this.name,
      panNumber: panNumber ?? this.panNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      isAadhaarVerified: isAadhaarVerified ?? this.isAadhaarVerified,
      isLivelinessVerified: isLivelinessVerified ?? this.isLivelinessVerified,
      isPanVerified: isPanVerified ?? this.isPanVerified,
      aadhaarVerificationStatus:
          aadhaarVerificationStatus ?? this.aadhaarVerificationStatus,
      livelinessVerificationStatus:
          livelinessVerificationStatus ?? this.livelinessVerificationStatus,
      profileQuestionsStatus:
          profileQuestionsStatus ?? this.profileQuestionsStatus,
      assetsStatus: assetsStatus ?? this.assetsStatus,
      liablitiesStatus: liablitiesStatus ?? this.liablitiesStatus,
      connectAccountsStatus:
          connectAccountsStatus ?? this.connectAccountsStatus,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'mobile_number': mobileNumber,
      'biometric': getBiometricStatusString(biometricStatus: biometric),
      'name': name,
      'date_of_birth': dateOfBirth,
      'pan_number': panNumber,
      'is_pan_verified': isPanVerified,
      'is_aadhaar_verified': isAadhaarVerified,
      'is_liveliness_verified': isLivelinessVerified,
      'aadhaar_verification_status': aadhaarVerificationStatus,
      'liveliness_verification_status': livelinessVerificationStatus,
      'profile_questions_status': profileQuestionsStatus,
      'connect_accounts_status': connectAccountsStatus,
      'assets_status': assetsStatus,
      'liablities_status': liablitiesStatus,
    };
  }

  final int? id;
  final String? mobileNumber;
  final BiometricStatus? biometric;
  final String? name;
  final String? panNumber;
  final String? dateOfBirth;
  final bool? isPanVerified;
  final bool? isAadhaarVerified;
  final bool? isLivelinessVerified;
  final String? aadhaarVerificationStatus;
  final String? livelinessVerificationStatus;
  final String? profileQuestionsStatus;
  final String? connectAccountsStatus;
  final String? assetsStatus;
  final String? liablitiesStatus;

  @override
  List<Object?> get props => <Object?>[
        id,
        mobileNumber,
        biometric,
        name,
        panNumber,
        dateOfBirth,
        isPanVerified,
        isAadhaarVerified,
        isLivelinessVerified,
        livelinessVerificationStatus,
        profileQuestionsStatus,
        connectAccountsStatus,
        assetsStatus,
        liablitiesStatus,
      ];
}
