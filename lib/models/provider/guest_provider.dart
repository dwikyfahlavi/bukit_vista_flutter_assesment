import 'package:bukit_vista_flutter_assesment/models/guest.dart';
import 'package:bukit_vista_flutter_assesment/models/repository/service.dart';
import 'package:flutter/foundation.dart';

enum GuestProviderState { none, loading, error }

class GuestProvider extends ChangeNotifier {
  final Service service = Service();

  GuestProviderState _state = GuestProviderState.none;
  GuestProviderState get state => _state;

  String? errorMessage;

  int _bottomNavItem = 0;
  int get bottomNavItem => _bottomNavItem;

  int _tabIndex = 0;
  int get tabIndex => _tabIndex;

  List<GuestData>? _guest = [];
  List<GuestData>? get guest => _guest;

  List<GuestData>? _baru = [];
  List<GuestData>? get baru => List.unmodifiable(_baru!);

  changeState(GuestProviderState state) {
    _state = state;
    notifyListeners();
  }

  void setBottomNavItem(int bottomNavItem) {
    _bottomNavItem = bottomNavItem;
    notifyListeners();
  }

  changeTabIndex(int index) {
    _tabIndex = index;
    notifyListeners();
  }

  search(String search) {
    changeState(GuestProviderState.loading);

    if (search == "") {
      _baru = [];
    }
    List<GuestData>? temp = [];
    _guest?.forEach((element) {
      if (element.name!.toLowerCase().contains(search)) {
        temp.add(element);
      }
    });
    _baru = temp;
    changeState(GuestProviderState.none);
    if (temp.isEmpty) {
      changeState(GuestProviderState.error);
    }
    notifyListeners();
  }

  Future<void> getAllGuest() async {
    changeState(GuestProviderState.loading);
    try {
      List<GuestData>? guestApi = await service.getAllGuestData();
      _guest = guestApi;
      changeState(GuestProviderState.none);
      notifyListeners();
    } catch (e) {
      changeState(GuestProviderState.error);
      print('error bos $e');
      notifyListeners();
    }
  }
}
