import 'package:flutter/material.dart';
import 'package:snr/common/local/LocalStorage.dart';
import 'package:snr/common/config/Config.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:snr/common/net/Address.dart';
import 'package:snr/common/redux/SysState.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/widget/MyInputWidget.dart';
import 'package:snr/common//utils/CommonUtils.dart';
import 'package:snr/widget/MyFlexButton.dart';
import 'package:snr/common/dao/UserDao.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snr/common/utils/NavigatorUtils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/**
 * 登入頁面
 * Date: 2019-03-11
 */
class LoginPage extends StatefulWidget {
  static final String sName = "login";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _account = "";
  var _password = "";

  final TextEditingController accountController = new TextEditingController();
  final TextEditingController pwController = new TextEditingController();

  _LoginPageState() : super();

  @override
  void initState() {
    super.initState();
    UserDao.validNewVersion(context);
    initParams();
  }

  initParams() async {
    _account = await LocalStorage.get(Config.USER_NAME_KEY);
    _password = await LocalStorage.get(Config.PW_KEY);
    accountController.value = new TextEditingValue(text: _account ?? "");
    pwController.value = new TextEditingValue(text: _password ?? "");
  }

  ///版號顯示
  Widget _buildAppVerNo() {
    double verFontSize = 20.0;
    return new AutoSizeText(
      CommonUtils.getLocale(context).appVerNo_text + Address.verNo,
      style: TextStyle(fontSize: ScreenUtil().setSp(verFontSize)),
      minFontSize: 1.0,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height)..init(context);
    return new StoreBuilder<SysState>(builder: (context, store) {
      return new GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
          //滿版的contrainer
          body: new Container(
            //背景色
            color: Color(MyColors.hexFromStr("#eeeeee")),
            child: new Center(
              //防止overFlow現象
              child: SafeArea(
                child: SingleChildScrollView(
                  child: new Column(
                    children: <Widget>[
                      new Padding(
                        padding: new EdgeInsets.only(
                            left: 30.0, top: 0.0, right: 30.0, bottom: 0.0),
                        child: new Image(
                            image: new AssetImage('static/images/logo.png')),
                      ),
                      new Padding(padding: new EdgeInsets.all(10.0)),
                      new Text(
                        CommonUtils.getLocale(context).sysTitle_text,
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(20.0) 
                        ),  
                      ),
                      new Padding(padding: new EdgeInsets.all(10.0)),
                      new Card(
                        elevation: 5.0,
                        shape: new RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        color: Colors.white70,
                        margin: const EdgeInsets.only(left: 30.0, right: 30.0),
                        child: new Padding(
                          padding: new EdgeInsets.only(left: 30.0, top: 40.0, right: 30.0, bottom: 0.0),
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new Padding(padding: new EdgeInsets.all(10.0)),
                              new MyInputWidget(
                                textStyle: TextStyle(fontSize: ScreenUtil().setSp(20.0)),
                                hintText: CommonUtils.getLocale(context).login_userAccount_hint_text,
                                onChanged: (String value) {
                                  _account = value;
                                },
                                controller: accountController,
                              ),
                              new Padding(padding: new EdgeInsets.all(10.0)),
                              new MyInputWidget(
                                textStyle: TextStyle(fontSize: ScreenUtil().setSp(20.0)),
                                hintText: CommonUtils.getLocale(context).login_password_hint_text,
                                obscureText: true,
                                onChanged: (String value) {
                                  _password = value;
                                },
                                controller: pwController,
                              ),
                              new Padding(padding: new EdgeInsets.all(20.0)),
                              new MyFlexButton(
                                text: CommonUtils.getLocale(context).login_text,
                                color: Color(MyColors.hexFromStr("#358cb0")),
                                textColor: Color(MyColors.textWhite),
                                fontSize: ScreenUtil().setSp(20.0),
                                onPress: () {
                                  if (_account == null || _account.length == 0) {
                                    return;
                                  }
                                  if (_password == null ||
                                      _password.length == 0) {
                                    return;
                                  }
                                  CommonUtils.showLoadingDialog(context);
                                  UserDao.login(_account.trim(), _password.trim(),store, context).then((res) {                                
                                    Navigator.pop(context);
                                    if (res != null && res.result) {                                 
                                      if (res.data.retCode == "14") {
                                          UserDao.updateDummyApp(context, res.data.blankURL);
                                      }
                                      else if (res.data.retCode == "00"){
                                          CommonUtils.showLoadingDialog(context);
                                          UserDao.getUserInfo(res.data.serverURL, res.data.ssoKey, _account, _password, store).then((res) {
                                            Navigator.pop(context);
                                            if (res != null && res.result) {
                                                new Future.delayed(const Duration(seconds: 1),() {
                                                  NavigatorUtils.goHome(context);
                                                  return true;
                                                });
                                            }
                                          });
                                      }
                                      else {
                                        Fluttertoast.showToast(msg: res.data.retMSG);
                                      }                                     
                                    } else {
                                      print("holy 喵喵喵");
                                    }
                                  });
                                },
                              ),
                              new Padding(padding: new EdgeInsets.all(10.0)),
                            ],
                          ),
                        ),
                      ),
                      new Padding(padding: new EdgeInsets.all(10.0)),
                      new Padding(
                        padding: EdgeInsets.only(left: 30.0, right: 30.0),
                        child: new Column(
                          children: <Widget>[
                            ///使用auto_size_text元件
                            new AutoSizeText(
                              CommonUtils.getLocale(context).copyRight_text,
                              style: TextStyle(fontSize: ScreenUtil().setSp(20.0) ),
                              minFontSize: 1.0,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            new Padding(padding: new EdgeInsets.all(10.0)),
                            new Align(
                              alignment: Alignment.bottomRight,
                              child: _buildAppVerNo()
                            )
                          ],
                        ),
                      ),
                    ],
                )),
              ),
            ),
          ),
        ),
      );
    });
  }
}
class DummyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}