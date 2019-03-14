import 'package:flutter/material.dart';
import 'package:snr/common/local/LocalStorage.dart';
import 'package:snr/common/config/Config.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:snr/common/redux/SysState.dart';
import 'package:snr/common/style/MyStyle.dart';
import 'package:snr/widget/MyInputWidget.dart';
import 'package:snr/common//utils/CommonUtils.dart';
import 'package:snr/widget/MyFlexButton.dart';
import 'package:snr/common/dao/UserDao.dart';
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

  _LoginPageState(): super();

  @override
  void initStatue() {
    super.initState();
    initParams();
  }

  initParams() async {
    _account = await  LocalStorage.get(Config.USER_NAME_KEY);
    _password = await LocalStorage.get(Config.PW_KEY);
    accountController.value = new TextEditingValue(text: _account ?? "");
    pwController.value = new TextEditingValue(text: _password ?? "");
  }

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter: ColorFilter.mode(
        Colors.black.withOpacity(0.5),
        BlendMode.dstATop
      ),
      image: AssetImage('static/images/sqaure-frame.png')
    );
  }



  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<SysState>(builder: (context, store){
      return new GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: (){
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
          body: new Container(
            // decoration: BoxDecoration(
            //   image: _buildBackgroundImage(),
            // ),
            
            color: Colors.white70,
            child: new Center(
              //防止overFlow現象
              child: SafeArea(
                child: SingleChildScrollView(
                  child: new Card(    
                    elevation: 5.0,
                    shape: new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    color: Color(MyColors.cardWhite),
                    margin: const EdgeInsets.only(left: 30.0, right: 30.0),
                    child: new Padding(
                      padding: new EdgeInsets.only(left: 30.0, top: 40.0, right: 30.0, bottom: 0.0),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Padding(padding: new EdgeInsets.all(10.0)),
                          new MyInputWidget(
                            hintText: CommonUtils.getLocale(context).login_userAccount_hint_text,                
                            onChanged: (String value) {
                              _account = value;
                            },
                            controller: accountController,
                          ),
                          new Padding(padding: new EdgeInsets.all(10.0)),
                          new MyInputWidget(
                            hintText: CommonUtils.getLocale(context).login_password_hint_text,
                            onChanged: (String value) {
                              _password = value;
                            },
                            controller: pwController,
                          ),
                          new Padding(padding: new EdgeInsets.all(20.0)),
                          new MyFlexButton(
                            text: CommonUtils.getLocale(context).login_text,
                            color: Colors.blue[300],
                            textColor: Color(MyColors.textWhite),
                            onPress: () {
                              if (_account == null || _account.length == 0 ){
                                return;
                              }
                              if (_password == null || _password.length == 0){
                                return;
                              }
                              CommonUtils.showLoadingDialog(context);
                              UserDao.login(_account.trim(), _password.trim(), store).then((res) {
                                  print("res ---- ");
                                  Navigator.pop(context);
                                  if (res != null && res.result) {
                                    print("call api resp => "+ res.result.toString());
                                  }
                                  else {
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
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}