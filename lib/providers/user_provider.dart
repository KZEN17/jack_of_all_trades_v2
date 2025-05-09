import 'package:flutter/foundation.dart';
import 'package:jack_of_all_trades/models/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  bool _isLoading = false;
  String _userType = ''; // client or handyman

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _user != null;
  String get userType => _userType;
  bool get isClient => _userType == 'client';
  bool get isHandyman => _userType == 'handyman';

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setUser(UserModel? user) {
    _user = user;
    notifyListeners();
  }

  void setUserType(String type) {
    _userType = type;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }

  // This is a placeholder for now, will be implemented with authentication later
  void updateUserProfile({
    String? name,
    String? email,
    String? phone,
    String? address,
    String? avatar,
  }) {
    if (_user == null) return;

    _user = _user!.copyWith(
      name: name ?? _user!.name,
      email: email ?? _user!.email,
      phone: phone ?? _user!.phone,
      address: address ?? _user!.address,
      avatar: avatar ?? _user!.avatar,
    );

    notifyListeners();
  }
}
