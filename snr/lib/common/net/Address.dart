import 'dart:io';
import 'package:flutter/services.dart';
import 'package:date_format/date_format.dart';

///地址數據
class Address {
  static const String ssoDomain = "http://nsso.dctv.net.tw:8081/";
  static const String ssoDomainName = "http://wos.dctv.net.tw:8081/";
  static const String testDomainName = "http://wos.dctv.net.tw:8081/";
  static const String kSNRHostName = "http://snr.dctv.tw:25888/";
  static const String kSNRHostPingName = "http://snr.dctv.tw:8989/";
  static const String phpService = "SNRping.php?";
  static const String getSsoKey = "SSO/json/login.do?";
  static const String getVersion = "ValidataVersion/json/index!checkVersion.action?";
  static const String loginAPI = "WorkOrder/json/wok!login.action?";
  static final String bundleID = "com.dc.SNR";
  // static final String verNo = "3.0.0311";
  static final String verNo = "2.19.0226";

  ///檢查是否有更新app
  static getValidateVersionAPI() {
    String deviceType = "";
    try {
      if (Platform.isAndroid) {
        deviceType = "android";
      }
      else if (Platform.isIOS) {
        deviceType = 'ios';
      }
    } on PlatformException {
      
    }
    return "${ssoDomainName}/${getVersion}packageName=${bundleID}&type=$deviceType&verNo=${verNo}";
  }

  ///登入SSO
  static ssoLoginAPI(account, password) {
    String deviceType = "";
    try {
      if (Platform.isAndroid) {
        deviceType = "android";
      }
      else if (Platform.isIOS) {
        deviceType = 'ios';
      }
    } on PlatformException {
      
    }
    return "${ssoDomain}${getSsoKey}function=login&accNo=$account&passWord=$password&uniqueCode=12343234&sysName=SNR&tokenType=$deviceType&tokenID=slg;ksl;dc123&packageName=com.dc.SNR&type=$deviceType";
  }

  ///snr登入
  static snrLoginAPI(serviceURL, account, ssoKey) {
    return "$serviceURL?accno=$account&ssoKey=$ssoKey";
  }

  ///取得snr設定檔
  static getQueryConfigureAPI() {
    return "${kSNRHostName}SNRProcess?FunctionName=QueryConfigure";
  }

  ///snr首頁api
  static getQueryCMTSMainTitleInfoAPI() {
    return "${kSNRHostName}SNRProcess?FunctionName=query_cmts_main_title_info";
  }

  ///snr首頁api
  static getSNRProblemsSignal() {
    var nowTime = formatDate(DateTime.now(), [yyyy,'-',mm,'-',dd]);
    return "${kSNRHostName}SNRProcess?FunctionName=QueryAllSNRSignal&Date=$nowTime";
  }

  ///snr首頁api
  static getQueryCmtsTotal() {
    return "${kSNRHostName}SNRProcess?FunctionName=query_cmts_total";
  }

  ///重大資料api
  static getQueryBigBad() {
    return "${kSNRHostName}SNRProcess?FunctionName=QueryBigBad";
  }

  ///重大歷史api
  static getQueryBigBadHistory(area) {
    return "${kSNRHostName}SNRProcess?FunctionName=QueryBigBadHistory&City=$area";
  }

  ///重大log api
  static getQueryFixRHiLowLogDetail(strContent) {
    return "${kSNRHostName}SNRProcess?FunctionName=query_hilowpass_from_info_ex&content=$strContent";
  }

  ///回報記錄
  static getQueryFixReportLog(area) {
    return "${kSNRHostName}SNRProcess?FunctionName=query_hilowpass_from_info_ex&City=$area";
  }


  ///可異統計表
  static getQueryVBADList() {
    return "${kSNRHostName}SNRProcess?FunctionName=query_vbad_list";
  }

  ///可異詳情
  static getQuerySNRAllBigBad(area,sort,hub,accNo) {
    return "${kSNRHostName}SNRProcess?FunctionName=QuerySNRAllBigBad&City=$area&Sort=$sort&Hub=$hub&accNo=$accNo";
  }

  ///可異(離線,問題,其他)
  static getQuerySNRAllBigBadOther(area, sort, hub, typeValue, typeOf, accNo) {
    return "${kSNRHostName}SNRProcess?FunctionName=QuerySNRAllBigBad&City=$area&Sort=$sort&Hub=$hub&$typeOf=$typeValue&accNo=$accNo";
  }

  ///派修統計
  static getQueryAssignFixList() {
    return "${kSNRHostName}SNRProcess?FunctionName=query_assign_fix_list";
  }

  ///派修大樓統計
  static getBuildAnalyse(type) {
    return "${kSNRHostName}SNRProcess?FunctionName=QueryBuildingAnalyse&Type=${type}";
  }

  ///派修詳情
  static getAssignFix(area, sort, hub, accNo) {
    return "${kSNRHostName}SNRProcess?FunctionName=AssignFix&City=$area&Sort=$sort&Hub=$hub&accNo=$accNo";
  }

  ///派修(拆改,NG,觀察)
  static getAssignFixOther(area, sort, hub, typeValue, typeOf, accNo) {
    return "${kSNRHostName}SNRProcess?FunctionName=AssignFix&City=$area&Sort=$sort&Hub=$hub&$typeOf=$typeValue&accNo=$accNo";
  }

  ///派修(完工)
  static getAssignFixFinished(area, sort, hub, day, accNo) {
    return "${kSNRHostName}SNRProcess?FunctionName=AssignFix&City=$area&Sort=$sort&Hub=$hub&FINISH=1&accNo=$accNo&Day=$day";
  }

  ///低hp詳情
  static getQueryHiPASS(strHipass,area,sort,hub, accNo) {
    return "${kSNRHostName}SNRProcess?FunctionName=QueryHiPass&City=$area&Sort=$sort&Hub=$hub&FINISH=1&accNo=$accNo&HiPass=$strHipass";
  }

  ///小ping資料
  static getPingSNR(str) {
    String paraType = "";
    int type = 0;
    switch (type) {
      case 0: {
          paraType = "CustCode";
        }
        break;
      case 1: {
          paraType = "Telephone";
        }
        break;
      case 2: {
          paraType = "Address";
        }
        break;
      case 3: {
          paraType = "CMMAC";
        }
        break;
      default: {}
        break;

    }
    return "${kSNRHostPingName}/SNRping.php?Action=getSNR&$paraType=$str";
  }

  ///關閉CM
  static postResetCM(cmts, custNo, accName) {
    return "${kSNRHostPingName}/SNRping.php?Action=ResetCM&Custno=$custNo&CMTS=$cmts&AccName=$accName";
  }
  ///重啟CM
  static postReStartCM(cmts,custNo,accName) {
    return "${kSNRHostPingName}/SNRping.php?Action=RestartCM&Custno=$custNo&CMTS=$cmts&AccName=$accName";
  }
  ///abnormal card
  static getSNRSignalByCMTSAPI(cmtsCode){
    var date = formatDate(DateTime.now(), [yyyy,'-',mm,'-',dd]);
    return "${kSNRHostName}SNRProcess?FunctionName=QuerySNRSignalByCMTS&CMTSCode=${cmtsCode}&Date=${date}";
  }
  ///abnormal node
  static getSNRSignalByCmtsAndCifAPI(cmtsCode, cif){
    var date = formatDate(DateTime.now(), [yyyy,'-',mm,'-',dd]);
    return "${kSNRHostName}SNRProcess?FunctionName=QuerySNRNodeSignalByCMTS_CIF&CMTSCode=${cmtsCode}&CIF=${cif}&Date=${date}";
  }
  ///abnormal detail
  static getSNRDetailByCMTSAndCIFAPI(cmts, cif, node, type, sort) {
    return "${kSNRHostName}SNRProcess?FunctionName=QuerySNRDetailByCMTSAndCIF&CMTSCode=${cmts}&CIF=${cif}&NODE=${node}&Type=${type}&Sort=${sort}";
  }
  ///problem，overpower
  static getQueryListAPI(type, city, sort, hub) {
    return "${kSNRHostName}SNRProcess?FunctionName=QueryList&Type=${type}&city=${city}&Sort=${sort}&hub=${hub}";
  }
  ///可異裡面的問題
  static getSNRProblemsAllBadSignalAPI(city, sort, hub, typeValue, typeOf, accNo) {
    return "${kSNRHostName}SNRProcess?FunctionName=QuerySNRAllBigBad&City=${city}&Sort=${sort}&Hub=${hub}&${typeOf}=${typeValue}&accNo=${accNo}";
  }
  ///普通跳轉
  static didTransferAPI(to, from, accNo, accName, custCDList) {
    var custCDStr = "";
    for (var str in custCDList) {
      if (custCDStr == "") {
        custCDStr = str;
      }
      else {
        custCDStr = "${custCDStr},${str}";
      }
    }
    return '';
    // return "${kSNRHostName}SNRProcess?FunctionName=Transfer&To=${to}&From=${from}&CustCD=${custCDStr}&SenderID=${accNo}&SenderName=${accName}";
  }
  ///包含輸入匡跳轉
  static didTransferInputTextAPI(to, from, memo, accNo, accName, custCDList) {
    var custCDStr = "";
    for (var str in custCDList) {
      if (custCDStr == "") {
        custCDStr = str;
      }
      else {
        custCDStr = "${custCDStr},${str}";
      }
    }
    return "${kSNRHostName}SNRProcess?FunctionName=Transfer&To=${to}&From=${from}&Memo=${memo}&CustCD=${custCDStr}&SenderID=${accNo}&SenderName=${accName}";
  }
  ///工異跳轉
  static didTransferPublicworksAPI(to, from, memo, accNo, accName, jsonCustCD) {
    return '';
    // return "${kSNRHostName}SNRProcess?FunctionName=Transfer&To=${to}&From=${from}&Memo=${memo}&CustCD=${jsonCustCD}&SenderID=${accNo}&SenderName=${accName}";
  }
  ///完工統計
  static getQueryFinishAnalyseAPI(date) {
    return "${kSNRHostName}SNRProcess?FunctionName=QueryFinishAnalyse&QueryDate=$date";
  }
  ///工務list & 超時list
  static getPublicworksAnalyseAPI() {
    return "${kSNRHostName}SNRProcess?FunctionName=QueryOverTimeAnalyse";
  }
  ///工務詳情
  static getQueryWorkWarningAPI(type, city, sort, hub) {
    return "${kSNRHostName}SNRProcess?FunctionName=QueryWorkWarning&type=${type}&City=${city}&Sort=${sort}&Hub=${hub}";
  }
}