import 'dart:io';
import 'package:flutter/services.dart';
import 'package:date_format/date_format.dart';
import 'package:snr/common/utils/AesUtils.dart';
///地址數據
class Address {
  static const String ssoDomain = "http://nsso.dctv.net.tw:8081/";
  static const String aesDomain = "http://asg.dctv.net.tw:8082/EncEDI/interfaceAES?data=";
  static const String ssoDomainName = "http://wos.dctv.net.tw:8081/";
  static const String testDomainName = "http://wos.dctv.net.tw:8081/";
  static const String kSNRHostName = "http://snr.dctv.tw:25888/";
  static const String kSNRHostPingName = "http://snr.dctv.tw:8989/";
  static const String phpService = "SNRping.php?";
  static const String getSsoKey = "SSO/json/login.do?";
  static const String getVersion = "ValidataVersion/json/index!checkVersion.action?";
  static const String loginAPI = "WorkOrder/json/wok!login.action?";
  static final String bundleID = "com.dctv.snrSys";
  static final String verNo = "3.0.0805";
  static final String AESKEY_en = "dctv2952dctv2952";
  static final String AESKEY_de = "dctv1688dctv1688";
  static final String AESKEY = "dctv1688dctv1688";
  static final int IV_SIZE = 16;

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
    return "${ssoDomain}${getSsoKey}function=login&accNo=$account&passWord=$password&uniqueCode=12343234&sysName=snrSys&tokenType=$deviceType&tokenID=slg;ksl;dc123&packageName=com.dctv.snrSys&type=$deviceType";
  }

  ///snr登入
  static snrLoginAPI(serviceURL, account, ssoKey) {
    return "$serviceURL?accno=$account&ssoKey=$ssoKey";
  }

  ///取得snr設定檔
  static getQueryConfigureAPI() {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=QueryConfigure");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }

  ///snr首頁api
  static getQueryCMTSMainTitleInfoAPI() {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=query_cmts_main_title_info");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }

  ///snr首頁api
  static getSNRProblemsSignal() {
    var nowTime = formatDate(DateTime.now(), [yyyy,'-',mm,'-',dd]);
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=QueryAllSNRSignal&Date=$nowTime");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }

  ///snr首頁api
  static getQueryCmtsTotal() {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=query_cmts_total");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }

  ///重大資料api
  static getQueryBigBad() {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=QueryBigBad");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }

  ///重大歷史api
  static getQueryBigBadHistory(area) {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=QueryBigBadHistory&City=$area");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }

  ///重大log api
  static getQueryFixRHiLowLogDetail(strContent) {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=query_hilowpass_from_info_ex&content=$strContent");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }

  ///回報記錄
  static getQueryFixReportLog(area) {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=query_hilowpass_from_info_ex&City=$area");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }


  ///可異統計表
  static getQueryVBADList() {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=query_vbad_list");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }

  ///可異詳情
  static getQuerySNRAllBigBad(area,sort,hub,accNo) {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=QuerySNRAllBigBad&City=$area&Sort=$sort&Hub=$hub&accNo=$accNo");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }

  ///可異(離線,問題,其他)
  static getQuerySNRAllBigBadOther(area, sort, hub, typeValue, typeOf, accNo) {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=QuerySNRAllBigBad&City=$area&Sort=$sort&Hub=$hub&$typeOf=$typeValue&accNo=$accNo");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }

  ///派修統計
  static getQueryAssignFixList() {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=query_assign_fix_list");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }

  ///派修大樓統計
  static getBuildAnalyse(type) {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=QueryBuildingAnalyse&Type=${type}");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }

  ///派修詳情
  static getAssignFix(area, sort, hub, accNo) {
    var str = "${kSNRHostName}SNRProcess?FunctionName=AssignFix&City=$area&Sort=$sort&Hub=$hub&accNo=$accNo";
    print(str);
    var aesUri = AesUtils.aes128Encrypt(str);
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }

  ///派修(拆改,NG,觀察)
  static getAssignFixOther(area, sort, hub, typeValue, typeOf, accNo) {
    var str = "${kSNRHostName}SNRProcess?FunctionName=AssignFix&City=$area&Sort=$sort&Hub=$hub&$typeOf=$typeValue&accNo=$accNo";
    print(str);
    var aesUri = AesUtils.aes128Encrypt(str);
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }

  ///派修(完工)
  static getAssignFixFinished(area, sort, hub, day, accNo) {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=AssignFix&City=$area&Sort=$sort&Hub=$hub&FINISH=1&accNo=$accNo&Day=$day");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }

  ///低hp詳情
  static getQueryHiPASS(strHipass,area,sort,hub, accNo) {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=QueryHiPass&City=$area&Sort=$sort&Hub=$hub&FINISH=1&accNo=$accNo&HiPass=$strHipass");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
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
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostPingName}/SNRping.php?Action=getSNR&$paraType=$str");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }

  ///關閉CM
  static postResetCM(cmts, custNo, accName) {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostPingName}/CMTSProcess.php?Action=ResetCM&Custno=$custNo&CMTS=$cmts&AccName=$accName");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }
  ///重啟CM
  static postReStartCM(cmts,custNo,accName) {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostPingName}/CMTSProcess.php?Action=RestartCM&Custno=$custNo&CMTS=$cmts&AccName=$accName");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }
  ///abnormal card
  static getSNRSignalByCMTSAPI(cmtsCode){
    var date = formatDate(DateTime.now(), [yyyy,'-',mm,'-',dd]);
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=QuerySNRSignalByCMTS&CMTSCode=${cmtsCode}&Date=${date}");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }
  ///abnormal node
  static getSNRSignalByCmtsAndCifAPI(cmtsCode, cif){
    var date = formatDate(DateTime.now(), [yyyy,'-',mm,'-',dd]);
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=QuerySNRNodeSignalByCMTS_CIF&CMTSCode=${cmtsCode}&CIF=${cif}&Date=${date}");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }
  ///abnormal detail
  static getSNRDetailByCMTSAndCIFAPI(cmts, cif, node, type, sort) {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=QuerySNRDetailByCMTSAndCIF&CMTSCode=${cmts}&CIF=${cif}&NODE=${node}&Type=${type}&Sort=${sort}");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }
  ///problem，overpower
  static getQueryListAPI(type, city, sort, hub) {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=QueryList&Type=${type}&city=${city}&Sort=${sort}&hub=${hub}");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }
  ///可異裡面的問題
  static getSNRProblemsAllBadSignalAPI(city, sort, hub, typeValue, typeOf, accNo) {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=QuerySNRAllBigBad&City=${city}&Sort=${sort}&Hub=${hub}&${typeOf}=${typeValue}&accNo=${accNo}");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }
  ///普通跳轉
  static didTransferAPI(to, from, accNo, accName, custCDList, {fromFunc}) {
    var custCDStr = "";
    if(fromFunc == null || fromFunc == "INST" || fromFunc == "MAINTAIN") {
      for (var str in custCDList) {
        if (custCDStr == "") {
          custCDStr = str;
        }
        else {
          custCDStr = "${custCDStr},${str}";
        }
      }
    }
    else {
      custCDStr = custCDList;
    }
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=Transfer&To=${to}&From=${from}&CustCD=${custCDStr}&SenderID=${accNo}&SenderName=${accName}");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
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
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=Transfer&To=${to}&From=${from}&Memo=${memo}&CustCD=${custCDStr}&SenderID=${accNo}&SenderName=${accName}");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }
  ///工異跳轉
  static didTransferPublicworksAPI(to, from, memo, accNo, accName, custCDList, {fromFunc}) {
    var custCDStr = "";
    if(fromFunc == null || fromFunc == "INST" || fromFunc == "MAINTAIN") {
      for (var str in custCDList) {
        if (custCDStr == "") {
          custCDStr = str;
        }
        else {
          custCDStr = "${custCDStr},${str}";
        }
      }
    }
    else {
      custCDStr = custCDList;
    }
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=Transfer&To=${to}&From=${from}&Memo=${memo}&CustCD=${custCDStr}&SenderID=${accNo}&SenderName=${accName}");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }
  ///完工統計
  static getQueryFinishAnalyseAPI(date) {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=QueryFinishAnalyse&QueryDate=$date");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }
  ///工務list & 超時list
  static getPublicworksAnalyseAPI() {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=QueryOverTimeAnalyse");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }
  ///工務詳情
  static getQueryWorkWarningAPI(type, city, sort, hub) {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=QueryWorkWarning&type=${type}&City=${city}&Sort=${sort}&Hub=${hub}");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }
  ///無對應
  static getQueryNoNodeAPI() {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=QueryNoNode");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }
  ///無對應刷新
  static getRefreshDataAPI(type, custNo) {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostPingName}/SNRping.php?Action=Refresh&Custno=$custNo&Type=$type");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }
  ///位置錯誤 - 詳情頁
  static getQueryWrongPlaceDetailAPI(page) {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=QueryWrongPlaceDetail&Page=$page");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }
  ///位置錯誤 - Node列表
  static getQueryWrongPlaceListAPI() {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=QueryWrongPlaceList&Level2=&PageCode=ALL");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }
  ///待確認，扣點
  static getQueryDeductDetailAPI(yeaMonth, page) {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=QueryDeductDetail&YearMonth=$yeaMonth&Page=$page");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }
  ///扣點統計
  static getQueryDeductAnalyseAPI(yeaMonth) {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=QueryDeductAnalyse&YearMonth=$yeaMonth");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }
  ///鎖HP統計
  static getQueryHiPassAnalyseAPI() {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=QueryHiPassAnalyse");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }
  ///鎖HP詳情頁面
  static getQueryHiPASSAPI(strHiPass, area, sort, hub) {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=QueryHiPass&HiPass=${strHiPass}&City=${area}&Sort=${sort}&Hub=${hub}");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }
  ///跳頻-cmts
  static getQueryJumpFreqCMTSAPI() {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=QueryJumpFreqCMTS");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }
  ///跳頻-時段時間
  static getQuerySwitchDelayTimeAPI() {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=QuerySwitchDelayTime");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }
  ///跳頻-四個區段
  static getQueryAutoFrequenceTimeAPI() {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=query_auto_freq_time");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }
  ///跳頻-卡板
  static getQueryJumpFreqCIFAPI(cType) {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=QueryJumpFreqCIF&CType=${cType}");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }
  ///跳頻-log
  static getQueryJumpFreqLOGAPI() {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=QueryJumpFreqLOG");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }
  ///跳頻-移頻
  static postUploadSwitchFreqAPI(cmts, cif, accName, delay) {
    String str = "${kSNRHostPingName}/CMTSProcess.php?Action=SwitchFreq&CMTS=$cmts&CIF=$cif&AccName=$accName";
    if (delay != "") {
      str += "&Delay=${delay}";
    }
    var aesUri = AesUtils.aes128Encrypt(str);
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }
  ///跳頻-自動跳頻時段
  static setAutoFrequenceTimeAPI(time1, time2, time3, time4,) {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=set_auto_freq_time&TIME1=$time1&TIME2=$time2&TIME3=$time3&TIME4=$time4");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }
  ///大ping-cpe
  static getCPEDataAPI(cmts, cmmac) {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostPingName}SNRping.php?Action=getCPE&CMTS=$cmts&CMMAC=$cmmac");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }
  ///大ping-flap
  static getFLAPDataAPI(cmts, cmmac) {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostPingName}SNRping.php?Action=getFLAP&CMTS=$cmts&CMMAC=$cmmac");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }
  ///大ping-清除flap
  static clearFLAPDataAPI(cmts, cmmac) {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostPingName}SNRping.php?Action=ClearFLAP&CMTS=$cmts&CMMAC=$cmmac");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }
  ///操作維修紀錄
  static getHipassLogDataAPI(custNo) {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=query_hilowpass_log&custNo=$custNo");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }
  ///清除維修記錄
  static delReportLog(senderId, senderName, logIdList, custId, from) {
    var logidStr = "";
    var i = 0;
    for (var str in logIdList) {
      if (str.contains("XXXXX")) {
        if (logidStr != "") {
          if (i < 1) {
            logidStr += ",XXXXX";
          }
        }
        else {
          if (i < 1) {
            logidStr += "XXXXX";
          }
        }
        i += 1;
      }
      else {
        if (logidStr == "") {
          logidStr = str;
        }
        else {
          logidStr = "${logidStr},${str}";
        }
      }
    }
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=DeleteReportLog&SenderID=$senderId&SenderName=$senderName&LogID=$logidStr&CustCD=$custId&From=$from");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }
  ///操作維修紀錄-添加log
  static addDescriptionAPI(custId, inputText, senderId, senderName, from) {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=AddReportLog&SenderID=$senderId&SenderName=$senderName&InputText=$inputText&CustCD=$custId&From=$from");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }
  ///操作維修紀錄-添加log-扣點
  static addDescription_deductAPI(custId, wkNo, inputText, senderId, senderName, from) {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=AddReportLog&SenderID=$senderId&SenderName=$senderName&InputText=$inputText&CustCD=$custId&From=$from&WorkNo=$wkNo");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }
  ///扣點log
  static getQueryDeductLogAPI(custCD, wkNo) {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=QueryDeductLog&CustCD=$custCD&WorkNo=$wkNo");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }
  ///位置錯誤log
  static getQueryWrongPlaceHistoryAPI(node) {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=QueryWrongPlaceHistory&Node=$node");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }
  ///取得指派人員
  static getQueryAssignManListAPI() {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=QueryAssignManList");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }
  ///post指派人員
  static setAssignManAPI(custCD, accNo, empName, assignMan, senderID, senderName, from) {
    var aesUri = AesUtils.aes128Encrypt("${kSNRHostName}SNRProcess?FunctionName=SetAssignMan&CustCD=$custCD&accNo=$accNo&empName=$empName&AssignMan=$assignMan&SenderID=$senderID&SenderName=$senderName");
    var appendUrl = aesDomain + aesUri;
    return appendUrl;
  }

}