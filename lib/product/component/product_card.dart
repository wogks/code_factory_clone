import 'package:codfac/common/const/color.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    //IntrinsicHeight 내부에 있는 모든 위젯들중 최대 높이를 가지고 있는 위젯에 높이가 맞춰진다
    return IntrinsicHeight(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              '/Users/SIMBAAT/Desktop/simbaat/codfac/codfac/asset/img/food/ddeok_bok_gi.jpg',
              width: 110,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          //클립알렉트가 왼쪽 끝에 붙어있으니까 나머지 오른쪽 공간은 익스팬디드로 먹어준다
          Expanded(
            child: Column(
              //좌우로 쭉 늘려준다
              crossAxisAlignment: CrossAxisAlignment.stretch,
              //컴포넌트간의 간격을 똑같이 준다
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  '떡볶이',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  '전통 떡볶이의 정석!\n맛있습니다',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14,
                      color: BODY_TEXT_COLOR,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  '₩10000',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 12,
                      color: PRIMARY_COLOR,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
