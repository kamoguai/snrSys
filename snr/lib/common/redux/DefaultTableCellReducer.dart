import 'package:snr/common/model/DefaultTableCell.dart';
import 'package:redux/redux.dart';

final DefaultTableCellReducer = combineReducers<List<DefaultTableCell>>([
  TypedReducer<List<DefaultTableCell>, RefreshDefaultTableCellAction>(_refresh),
]);

List<DefaultTableCell> _refresh(List<DefaultTableCell> list, action) {
  list.clear();
  if (action.list == null) {
    return list;
  }
  else {
    list.addAll(action.list);
    return list;
  }
}


class RefreshDefaultTableCellAction {
  final List<DefaultTableCell> list;
  RefreshDefaultTableCellAction(this.list);
}