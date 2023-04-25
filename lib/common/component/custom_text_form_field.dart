import 'package:codfac/common/const/color.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool autoFocus;
  final bool obscureText;
  final ValueChanged<String>? onChanged;

  const CustomTextFormField({
    super.key,
    this.hintText,
    this.errorText,
    this.autoFocus = false,
    this.obscureText = false,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const baseBorder = OutlineInputBorder(
        borderSide: BorderSide(color: INPUT_BORDER_COLOR, width: 1));
    return TextFormField(
      cursorColor: PRIMARY_COLOR,
      //비밀번호 입력할때
      obscureText: false,
      //위젯이 오는순간 바로 포거스로 됌
      autofocus: false,
      onChanged: onChanged,
      decoration: InputDecoration(
        //텍스트필드 안에 내용물에 패딩을 먹임(커서를 땡김)
        contentPadding: const EdgeInsets.all(20),
        hintText: hintText,
        //힌트텍스트 스타일
        hintStyle: const TextStyle(color: BODY_TEXT_COLOR, fontSize: 14),
        errorText: errorText,
        fillColor: INPUT_BG_COLOR,
        //이거 해야지 fill color가 보임
        filled: true,
        //기본값이 테두리가 검정색인데 이걸 없애기 위해 베이스보더를 사용한다
        enabledBorder: baseBorder,
        //border는 모든 인풋상태의 기본 스타일 셋팅
        border: baseBorder,
        //카피위드
        focusedBorder: baseBorder.copyWith(
            borderSide: baseBorder.borderSide.copyWith(color: PRIMARY_COLOR)),
      ),
    );
  }
}
