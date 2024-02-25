import 'package:flutter/foundation.dart';
import 'package:myapp/model/follower_model.dart';
import 'package:myapp/other/api_service.dart';

class FollowerProvider extends ChangeNotifier {
  bool _isFollowing = false;

  bool get isFollowing => _isFollowing;

  Future<void> updateFollowers(FollowerModel followerModel) async {
    try {
      await ApiService.updateFollowers(followerModel);
      _isFollowing = !_isFollowing;
      notifyListeners();
    } catch (e) {
      print('Error: $e');
    }
  }
}
