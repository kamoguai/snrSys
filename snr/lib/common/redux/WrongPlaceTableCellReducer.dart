
import 'package:redux/redux.dart';
import 'package:snr/common/model/WrongPlaceTableCell.dart';

final WrongPlaceTableCellReducer = combineReducers<WrongPlaceTableCell>([
  TypedReducer<WrongPlaceTableCell, RefreshWrongPlaceTableCellAction>(_refresh),
]);

WrongPlaceTableCell _refresh(WrongPlaceTableCell refreshData, action) {
  refreshData = action.refreshData;
  return refreshData;

}


class RefreshWrongPlaceTableCellAction {
  final WrongPlaceTableCell refreshData;
  RefreshWrongPlaceTableCellAction(this.refreshData);
}