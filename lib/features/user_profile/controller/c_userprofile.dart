import 'package:power_state/power_state.dart';
import 'package:task_management/features/user_profile/api/user_api.dart';
import 'package:task_management/features/user_profile/model/get_user_profile.dart';

class CUserProfile extends PowerController {
  final UserProfileAPI _userProfileAPI = UserProfileAPI();

  MUserProfile? _userProfile;
  bool _loading = true;

  MUserProfile? get userProfile => _userProfile;
  bool get loading => _loading;

  fetchUserProfile() async {
    setLoading(true);
    try {
      final profile = await _userProfileAPI.getProfile();
      _userProfile = profile;
    } catch (err) {
      //print(err);
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

  void setLoading(bool isLoading) {
    _loading = isLoading;
    notifyListeners();
  }
}
