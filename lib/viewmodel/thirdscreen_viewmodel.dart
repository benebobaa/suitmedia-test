import 'package:flutter/widgets.dart';
import 'package:flutter_suitmedia/model/model_data.dart';
import 'package:flutter_suitmedia/service/api.dart';

class ThirdScreenViewModel with ChangeNotifier {
  Api api = Api();
  List<Data> _data = [];

  List<Data> get data => _data;
  bool isLoading = false;

  int limit = 50;
  bool _isLimit = false;

  bool get isLimit => _isLimit;

  Future<void> getData(int page) async {
    print('hit load');
    isLoading = true;
    notifyListeners();
    final data = await api.getData(page, limit);

    _data = data;
    isLoading = false;
    notifyListeners();
  }

  Future<void> getDataScroll(int page) async {
    print('hit load');

    notifyListeners();
    final newdata = await api.getData(page, limit);
    print(newdata.length + data.length);
    if ((newdata.length + data.length) > limit) {
      _isLimit = true;
      notifyListeners();
      return;
    }

    _data.addAll(data.map(((e) {
      return Data(
          id: e.id,
          email: e.email,
          firstName: e.firstName,
          lastName: e.lastName,
          avatar: e.avatar);
    })).toList());

    print(data);
    print('data ini yg panjang');
    notifyListeners();
  }
}
