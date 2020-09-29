import 'package:sandovalportfolio/Huawei/helpers/auth_params.dart';

class AuthParamHelper {
  Map<String, dynamic> authParamHelpers = <String, dynamic>{
    'authData': {
      'setIdToken': false,
      'setProfile': false,
      'setAccessToken': false,
      'setAuthorizationCode': false,
      'setEmail': false,
      'setId': false,
      'scopeList': [],
      'defaultParam': AuthParams.defaultAuthRequestParam,
      'requestCode': 8888
    }
  };

  void setDefaultParam(int param) {
    authParamHelpers['authData']['defaultParam'] = param;
  }

  void setIdToken() {
    authParamHelpers['authData']['setIdToken'] = true;
  }

  void setProfile() {
    authParamHelpers['authData']['setProfile'] = true;
  }

  void setAccessToken() {
    authParamHelpers['authData']['setAccessToken'] = true;
  }

  void setAuthorizationCode() {
    authParamHelpers['authData']['setAuthorizationCode'] = true;
  }

  void setEmail() {
    authParamHelpers['authData']['setEmail'] = true;
  }

  void setId() {
    authParamHelpers['authData']['setId'] = true;
  }

  void addToScopeList(List<String> scopes) {
    authParamHelpers['authData']['scopeList'] = scopes;
  }

  void setRequestCode(int requestCode) {
    authParamHelpers['authData']['requestCode'] = requestCode;
  }
}
