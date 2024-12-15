import 'package:power_state/power_state.dart';
import 'package:task_management/features/user_profile/api/view_user_api.dart';
import 'package:task_management/features/user_profile/model/update_profile_model.dart';

class CUpdateProfile extends PowerController {
  final ViewProfileAPI _viewProfileAPI = ViewProfileAPI();

  MPatchProfile? _viewProfile;
  bool _loading = true;

  MPatchProfile? get viewProfile => _viewProfile;
  bool get loading => _loading;

  patchProfile() async {
    setLoading(true);
    try {
      final update = await _viewProfileAPI.getUpdate();
      _viewProfile = update;
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
