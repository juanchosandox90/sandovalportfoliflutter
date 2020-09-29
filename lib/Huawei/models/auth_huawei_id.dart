import 'package:sandovalportfolio/Huawei//models/account.dart';

class AuthHuaweiId {
  Account account;
  String accessToken;
  String displayName;
  String email;
  String familyName;
  String givenName;
  String idToken;
  String authorizationCode;
  String unionId;
  String avatarUriString;
  String openId;
  List<dynamic> authorizedScopes;

  String countryCode;
  String serviceCountryCode;
  String uid;
  int status;
  int gender;

  AuthHuaweiId(
      {this.openId,
      this.email,
      this.accessToken,
      this.unionId,
      this.idToken,
      this.displayName,
      this.familyName,
      this.givenName,
      this.authorizationCode,
      this.authorizedScopes,
      this.avatarUriString,
      this.account,
      this.uid,
      this.serviceCountryCode,
      this.countryCode,
      this.status,
      this.gender});

  AuthHuaweiId.fromJson(Map<String, dynamic> json) {
    account =
        json['account'] != null ? new Account.fromJson(json['account']) : null;
    openId = json['openId'] ?? null;
    email = json['email'] ?? null;
    accessToken = json['accessToken'] ?? null;
    unionId = json['unionId'] ?? null;
    idToken = json['idToken'] ?? null;
    displayName = json['displayName'] ?? null;
    familyName = json['familyName'] ?? null;
    givenName = json['givenName'] ?? null;
    authorizationCode = json['authorizationCode'] ?? null;
    authorizedScopes = json['authorizedScopes'] ?? null;
    avatarUriString = json['avatarUriString'] ?? null;
    countryCode = json['countryCode'] ?? null;
    serviceCountryCode = json['serviceCountryCode'] ?? null;
    status = json['status'] ?? null;
    gender = json['gender'] ?? null;
    uid = json['uid'] ?? null;
  }

  Map<String, dynamic> toJson() => {
        'account': account == null
            ? null
            : account.toJson() != null
                ? account.toJson()
                : null,
        'openId': openId,
        'email': email,
        'accessToken': accessToken,
        'unionId': unionId,
        'idToken': idToken,
        'displayName': displayName,
        'familyName': familyName,
        'givenName': givenName,
        'authorizationCode': authorizationCode,
        'authorizedScopes': authorizedScopes,
        'avatarUriString': avatarUriString,
        'gender': gender,
        'status': status,
        'countryCode': countryCode,
        'serviceCountryCode': serviceCountryCode,
        'uid': uid
      };
}
