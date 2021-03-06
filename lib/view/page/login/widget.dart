import 'package:fitween1/global/config/theme.dart';
import 'package:fitween1/presenter/page/before_main/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

// 로그인 페이지 관련 위젯 모음

// 로그인 타입
enum LoginType { google, apple }

// 로그인 버튼
class SignInButton extends StatelessWidget {
  const SignInButton({
    Key? key,
    required this.type,
  }) : super(key: key);

  final LoginType type;

  @override
  Widget build(BuildContext context) {

    const Map<LoginType, Color> fillColor = {
      LoginType.google: FWTheme.white,
      LoginType.apple: FWTheme.dark,
    };

    const Map<LoginType, Color> textColor = {
      LoginType.google: FWTheme.dark,
      LoginType.apple: FWTheme.white,
    };

    return SizedBox(
      width: 285.0,
      child: ElevatedButton(
        onPressed: () => LoginPresenter.loginButtonPressed(type),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(fillColor[type]),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/image/logo/${type.name}.svg',
              width: 23.0,
              height: 23.0,
            ),
            const SizedBox(width: 16.0),
            Text(
              'Continue with ${toBeginningOfSentenceCase(type.name)}',
              style: TextStyle(
                color: textColor[type],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
