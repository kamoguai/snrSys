import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
///颜色
class MyColors {
  static const String primaryValueString = "#24292E";
  static const String primaryLightValueString = "#42464b";
  static const String primaryDarkValueString = "#121917";
  static const String miWhiteString = "#ececec";
  static const String actionBlueString = "#267aff";
  static const String webDraculaBackgroundColorString = "#282a36";

  static const int primaryValue = 0xFF2D8FBB;
  static const int primaryLightValue = 0xFF42464b;
  static const int primaryDarkValue = 0xFF121917;

  static const int cardWhite = 0xFFFFFFFF;
  static const int textWhite = 0xFFFFFFFF;
  static const int miWhite = 0xffececec;
  static const int white = 0xFFFFFFFF;
  static const int actionBlue = 0xff267aff;
  static const int subTextColor = 0xff959595;
  static const int subLightTextColor = 0xffc4c4c4;

  static const int mainBackgroundColor = miWhite;

  static const int mainTextColor = primaryDarkValue;
  static const int textColorWhite = white;

  static const MaterialColor primarySwatch = const MaterialColor(
    primaryValue,
    const <int, Color>{
      50: const Color(primaryLightValue),
      100: const Color(primaryLightValue),
      200: const Color(primaryLightValue),
      300: const Color(primaryLightValue),
      400: const Color(primaryLightValue),
      500: const Color(primaryValue),
      600: const Color(primaryDarkValue),
      700: const Color(primaryDarkValue),
      800: const Color(primaryDarkValue),
      900: const Color(primaryDarkValue),
    },
  );

  ///將hex color傳入轉成輸出樣式e.g. ff0000
  static int hexFromStr(String colorStr) {
    colorStr = "FF" + colorStr;
    colorStr = colorStr.replaceAll("#", "");
    int val = 0;
    int len = colorStr.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = colorStr.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("An error occurred when converting a color");
      }
    }
    return val;
  }
}

///文本样式
class MyConstant {
  static const String app_default_share_url =
      "https://github.com/CarGuo/MyGithubAppFlutter";

  static const lagerTextSize = 30.0;
  static const bigTextSize = 20.0;
  static const normalTextSize = 18.0;
  static const middleTextWhiteSize = 16.0;
  static const smallTextSize = 14.0;
  static const minTextSize = 12.0;
  static const miniTextSize = 10.0;
  static const tinyTextSize = 8.0;

  static const minText = TextStyle(
    color: Color(MyColors.subLightTextColor),
    fontSize: minTextSize,
  );

  static const smallTextWhite = TextStyle(
    color: Color(MyColors.textColorWhite),
    fontSize: smallTextSize,
  );

  static const smallText = TextStyle(
    color: Color(MyColors.mainTextColor),
    fontSize: smallTextSize,
  );

  static const smallTextBold = TextStyle(
    color: Color(MyColors.mainTextColor),
    fontSize: smallTextSize,
    fontWeight: FontWeight.bold,
  );

  static const smallSubLightText = TextStyle(
    color: Color(MyColors.subLightTextColor),
    fontSize: smallTextSize,
  );

  static const smallActionLightText = TextStyle(
    color: Color(MyColors.actionBlue),
    fontSize: smallTextSize,
  );

  static const smallMiLightText = TextStyle(
    color: Color(MyColors.miWhite),
    fontSize: smallTextSize,
  );

  static const smallSubText = TextStyle(
    color: Color(MyColors.subTextColor),
    fontSize: smallTextSize,
  );

  static const middleText = TextStyle(
    color: Color(MyColors.mainTextColor),
    fontSize: middleTextWhiteSize,
  );

  static const middleTextWhite = TextStyle(
    color: Color(MyColors.textColorWhite),
    fontSize: middleTextWhiteSize,
  );

  static const middleSubText = TextStyle(
    color: Color(MyColors.subTextColor),
    fontSize: middleTextWhiteSize,
  );

  static const middleSubLightText = TextStyle(
    color: Color(MyColors.subLightTextColor),
    fontSize: middleTextWhiteSize,
  );

  static const middleTextBold = TextStyle(
    color: Color(MyColors.mainTextColor),
    fontSize: middleTextWhiteSize,
    fontWeight: FontWeight.bold,
  );

  static const middleTextWhiteBold = TextStyle(
    color: Color(MyColors.textColorWhite),
    fontSize: middleTextWhiteSize,
    fontWeight: FontWeight.bold,
  );

  static const middleSubTextBold = TextStyle(
    color: Color(MyColors.subTextColor),
    fontSize: middleTextWhiteSize,
    fontWeight: FontWeight.bold,
  );

  static const normalText = TextStyle(
    color: Color(MyColors.mainTextColor),
    fontSize: normalTextSize,
  );

  static const normalTextBold = TextStyle(
    color: Color(MyColors.mainTextColor),
    fontSize: normalTextSize,
    fontWeight: FontWeight.bold,
  );

  static const normalSubText = TextStyle(
    color: Color(MyColors.subTextColor),
    fontSize: normalTextSize,
  );

  static const normalTextWhite = TextStyle(
    color: Color(MyColors.textColorWhite),
    fontSize: normalTextSize,
  );

  static const normalTextMitWhiteBold = TextStyle(
    color: Color(MyColors.miWhite),
    fontSize: normalTextSize,
    fontWeight: FontWeight.bold,
  );

  static const normalTextActionWhiteBold = TextStyle(
    color: Color(MyColors.actionBlue),
    fontSize: normalTextSize,
    fontWeight: FontWeight.bold,
  );

  static const normalTextLight = TextStyle(
    color: Color(MyColors.primaryLightValue),
    fontSize: normalTextSize,
  );

  static const largeText = TextStyle(
    color: Color(MyColors.mainTextColor),
    fontSize: bigTextSize,
  );

  static const largeTextBold = TextStyle(
    color: Color(MyColors.mainTextColor),
    fontSize: bigTextSize,
    fontWeight: FontWeight.bold,
  );

  static const largeTextWhite = TextStyle(
    color: Color(MyColors.textColorWhite),
    fontSize: bigTextSize,
  );

  static const largeTextWhiteBold = TextStyle(
    color: Color(MyColors.textColorWhite),
    fontSize: bigTextSize,
    fontWeight: FontWeight.bold,
  );

  static const largeLargeTextWhite = TextStyle(
    color: Color(MyColors.textColorWhite),
    fontSize: lagerTextSize,
    fontWeight: FontWeight.bold,
  );

  static const largeLargeText = TextStyle(
    color: Color(MyColors.primaryValue),
    fontSize: lagerTextSize,
    fontWeight: FontWeight.bold,
  );
}

class MyICons {
  static const String FONT_FAMILY = 'wxcIconFont';

  static const String DEFAULT_USER_ICON = 'static/images/logo_small.png';
  static const String DEFAULT_IMAGE = 'static/images/default_img.png';
  static const String DEFAULT_REMOTE_PIC =
      'https://raw.githubusercontent.com/CarGuo/MyGithubAppFlutter/master/static/images/logo.png';

  static const String SQUARE_FRAME_PIC = 'static/images/square-frame.png';
  static const String DCTV_LOGO_ICON = 'static/images/logo.png';

  static const IconData HOME =
      const IconData(0xe624, fontFamily: MyICons.FONT_FAMILY);
  static const IconData MORE =
      const IconData(0xe674, fontFamily: MyICons.FONT_FAMILY);
  static const IconData SEARCH =
      const IconData(0xe61c, fontFamily: MyICons.FONT_FAMILY);

  static const IconData MAIN_DT =
      const IconData(0xe684, fontFamily: MyICons.FONT_FAMILY);
  static const IconData MAIN_QS =
      const IconData(0xe818, fontFamily: MyICons.FONT_FAMILY);
  static const IconData MAIN_MY =
      const IconData(0xe6d0, fontFamily: MyICons.FONT_FAMILY);
  static const IconData MAIN_SEARCH =
      const IconData(0xe61c, fontFamily: MyICons.FONT_FAMILY);

  static const IconData LOGIN_USER =
      const IconData(0xe666, fontFamily: MyICons.FONT_FAMILY);
  static const IconData LOGIN_PW =
      const IconData(0xe60e, fontFamily: MyICons.FONT_FAMILY);

  static const IconData REPOS_ITEM_USER =
      const IconData(0xe63e, fontFamily: MyICons.FONT_FAMILY);
  static const IconData REPOS_ITEM_STAR =
      const IconData(0xe643, fontFamily: MyICons.FONT_FAMILY);
  static const IconData REPOS_ITEM_FORK =
      const IconData(0xe67e, fontFamily: MyICons.FONT_FAMILY);
  static const IconData REPOS_ITEM_ISSUE =
      const IconData(0xe661, fontFamily: MyICons.FONT_FAMILY);

  static const IconData REPOS_ITEM_STARED =
      const IconData(0xe698, fontFamily: MyICons.FONT_FAMILY);
  static const IconData REPOS_ITEM_WATCH =
      const IconData(0xe681, fontFamily: MyICons.FONT_FAMILY);
  static const IconData REPOS_ITEM_WATCHED =
      const IconData(0xe629, fontFamily: MyICons.FONT_FAMILY);
  static const IconData REPOS_ITEM_DIR = Icons.folder;
  static const IconData REPOS_ITEM_FILE =
      const IconData(0xea77, fontFamily: MyICons.FONT_FAMILY);
  static const IconData REPOS_ITEM_NEXT =
      const IconData(0xe610, fontFamily: MyICons.FONT_FAMILY);

  static const IconData USER_ITEM_COMPANY =
      const IconData(0xe63e, fontFamily: MyICons.FONT_FAMILY);
  static const IconData USER_ITEM_LOCATION =
      const IconData(0xe7e6, fontFamily: MyICons.FONT_FAMILY);
  static const IconData USER_ITEM_LINK =
      const IconData(0xe670, fontFamily: MyICons.FONT_FAMILY);
  static const IconData USER_NOTIFY =
      const IconData(0xe600, fontFamily: MyICons.FONT_FAMILY);

  static const IconData ISSUE_ITEM_ISSUE =
      const IconData(0xe661, fontFamily: MyICons.FONT_FAMILY);
  static const IconData ISSUE_ITEM_COMMENT =
      const IconData(0xe6ba, fontFamily: MyICons.FONT_FAMILY);
  static const IconData ISSUE_ITEM_ADD =
      const IconData(0xe662, fontFamily: MyICons.FONT_FAMILY);

  static const IconData ISSUE_EDIT_H1 = Icons.filter_1;
  static const IconData ISSUE_EDIT_H2 = Icons.filter_2;
  static const IconData ISSUE_EDIT_H3 = Icons.filter_3;
  static const IconData ISSUE_EDIT_BOLD = Icons.format_bold;
  static const IconData ISSUE_EDIT_ITALIC = Icons.format_italic;
  static const IconData ISSUE_EDIT_QUOTE = Icons.format_quote;
  static const IconData ISSUE_EDIT_CODE = Icons.format_shapes;
  static const IconData ISSUE_EDIT_LINK = Icons.insert_link;

  static const IconData NOTIFY_ALL_READ =
      const IconData(0xe62f, fontFamily: MyICons.FONT_FAMILY);

  static const IconData PUSH_ITEM_EDIT = Icons.mode_edit;
  static const IconData PUSH_ITEM_ADD = Icons.add_box;
  static const IconData PUSH_ITEM_MIN = Icons.indeterminate_check_box;
}
class MyScreen {
  ///首頁bar按鈕長度
  static double homePageBarButtonWidth(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    double width = 0.0;
    if (deviceHeight < 570) {
      width = 50.0;
    } else {
      width = 60.0;
    }
    return width;
  }

  ///首頁字體大小
  static double homePageFontSize(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    double fontSize = 0.0;
    if (deviceHeight < 570) {
      fontSize = MyConstant.middleTextWhiteSize;
    } else if (deviceHeight > 800) {
      fontSize = MyConstant.bigTextSize;
    } else if (deviceHeight > 600 && deviceHeight < 800) {
      fontSize = MyConstant.normalTextSize;
    } else {
      fontSize = MyConstant.bigTextSize;
    }
    return ScreenUtil().setSp(fontSize);
  }
  ///首頁字體大小
  static double homePageFontSize_s(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    double fontSize = 0.0;
    if (deviceHeight < 570) {
      fontSize = MyConstant.smallTextSize;
    } else if (deviceHeight > 800) {
      fontSize = MyConstant.bigTextSize;
    } else if (deviceHeight > 600 && deviceHeight < 800) {
      fontSize = MyConstant.normalTextSize;
    } else {
      fontSize = MyConstant.bigTextSize;
    }
    return ScreenUtil().setSp(fontSize);
  }
  ///首頁字體大小
  static double homePageCmtsTableSize(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    double fontSize = 0.0;
    if (deviceHeight < 570) {
      fontSize = MyConstant.smallTextSize;
    } else if (deviceHeight > 800) {
      fontSize = MyConstant.middleTextWhiteSize;
    } else if (deviceHeight > 600 && deviceHeight < 800) {
      fontSize = MyConstant.middleTextWhiteSize;
    } else {
      fontSize = MyConstant.middleTextWhiteSize;
    }
    return ScreenUtil().setSp(fontSize);
  }
  ///卡板字體大小
  static double normalPageFontSize(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    double fontSize = 0.0;
    if (deviceHeight < 570) {
      fontSize = MyConstant.normalTextSize;
    } else if (deviceHeight > 800) {
      fontSize = MyConstant.bigTextSize;
    } else if (deviceHeight > 600 && deviceHeight < 800) {
      fontSize = MyConstant.normalTextSize;
    } else {
      fontSize = MyConstant.bigTextSize;
    }
    return ScreenUtil().setSp(fontSize);
  }
  ///卡板字體大小s
  static double normalPageFontSize_s(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    double fontSize = 0.0;
    if (deviceHeight < 570) {
      fontSize = MyConstant.normalTextSize;
    } else if (deviceHeight > 800) {
      fontSize = MyConstant.bigTextSize;
    } else if (deviceHeight > 600 && deviceHeight < 800) {
      fontSize = MyConstant.normalTextSize;
    } else {
      fontSize = MyConstant.bigTextSize;
    }
    return ScreenUtil().setSp(fontSize);
  }
  ///卡板list字體大小
  static double normalListPageFontSize(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    double fontSize = 0.0;
    if (deviceHeight < 570) {
      fontSize = MyConstant.minTextSize;
    } else if (deviceHeight > 800) {
      fontSize = MyConstant.normalTextSize;
    } else if (deviceHeight > 600 && deviceHeight < 800) {
      fontSize = MyConstant.middleTextWhiteSize;
    } else {
      fontSize = MyConstant.normalTextSize;
    }
    return ScreenUtil().setSp(fontSize);
  }
  ///卡板list字體大小s
  static double normalListPageFontSize_s(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    double fontSize = 0.0;
    if (deviceHeight < 570) {
      fontSize = MyConstant.miniTextSize;
    } else if (deviceHeight > 800) {
      fontSize = MyConstant.middleTextWhiteSize;
    } else if (deviceHeight > 600 && deviceHeight < 800) {
      fontSize = MyConstant.middleTextWhiteSize;
    }
    else {
      fontSize = MyConstant.normalTextSize;
    }
    return ScreenUtil().setSp(fontSize);
  }
  ///通用detailList字體大小
  static double defaultTableCellFontSize(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    double fontSize = 0.0;
    if (deviceHeight < 570) {
      fontSize = MyConstant.smallTextSize;
    } else if (deviceHeight > 800) {
      fontSize = MyConstant.middleTextWhiteSize;
    } else if (deviceHeight > 600 && deviceHeight < 800) {
      fontSize = MyConstant.smallTextSize;
    }
    else {
      fontSize = MyConstant.smallTextSize;
    }
    return ScreenUtil().setSp(fontSize);
  }
  ///通用detailList字體大小s
  static double defaultTableCellFontSize_s(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    double fontSize = 0.0;
    if (deviceHeight < 570) {
      fontSize = MyConstant.miniTextSize ;
    } else if (deviceHeight > 800) {
      fontSize = MyConstant.smallTextSize;
    } else if (deviceHeight > 600 && deviceHeight < 800) {
      fontSize = MyConstant.minTextSize;
    }
    else {
      fontSize = MyConstant.smallTextSize;
    }
    return ScreenUtil().setSp(fontSize);
  }
  ///四顆按鈕width
  static double default4BtnWidth(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    double width = 60.0;
    if (deviceHeight < 570) {
      width = 60.0;
    } else if (deviceHeight > 800) {
      width = 80.0;
    } else if (deviceHeight > 600 && deviceHeight < 800) {
      width = 70.0;
    }
    else {
      width = 70.0;
    }
    return width;
  }
   ///四顆按鈕width
  static double op4BtnWidth(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    double width = 30.0;
    if (deviceHeight < 570) {
      width = 30.0;
    } else if (deviceHeight > 800) {
      width = 30.0;
    } else if (deviceHeight > 600 && deviceHeight < 800) {
      width = 30.0;
    }
    else {
      width = 30.0;
    }
    return width;
  }
  ///通用analyzeList字體大小
  static double analyzeListFontSize(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    double fontSize = 0.0;
    if (deviceHeight < 570) {
      fontSize = MyConstant.smallTextSize ;
    } else if (deviceHeight > 800) {
      fontSize = MyConstant.bigTextSize;
    } else if (deviceHeight > 600 && deviceHeight < 800) {
      fontSize = MyConstant.middleTextWhiteSize;
    }
    else {
      fontSize = MyConstant.smallTextSize;
    }
    return ScreenUtil().setSp(fontSize);
  }
  ///appbar button size
  static double appBarFontSize(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    double fontSize = 0.0;
    if (deviceHeight < 570) {
      fontSize = MyConstant.smallTextSize;
    } else if (deviceHeight > 800) {
      fontSize = MyConstant.bigTextSize;
    } else if (deviceHeight > 600 && deviceHeight < 800) {
      fontSize = MyConstant.normalTextSize;
    }
    else {
      fontSize = MyConstant.normalTextSize;
    }
    return ScreenUtil().setSp(fontSize);
  }
}