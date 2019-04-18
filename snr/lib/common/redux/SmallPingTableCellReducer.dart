import 'package:redux/redux.dart';
import 'package:snr/common/model/SmallPingTableCell.dart';

final SmallPingTableCellReducer = combineReducers<SmallPingTableCell>([
  TypedReducer<SmallPingTableCell, RefreshSmallPingTableCellAction>(_refresh),
]);

SmallPingTableCell _refresh(SmallPingTableCell pingData, action) {
  pingData = action.pingData;
  return pingData;

}


class RefreshSmallPingTableCellAction {
  final SmallPingTableCell pingData;
  RefreshSmallPingTableCellAction(this.pingData);
}