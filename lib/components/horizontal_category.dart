import 'package:flutter/material.dart';
import 'package:qirana_app/model/category_model.dart';
import 'category_card.dart';

class HorizontalCategory extends StatelessWidget {
  HorizontalCategory({this.categoryModel});
  final List<CategoryModel> categoryModel;

  IconData getIcon(String name) {
    if (name == 'Grocery') return Icons.local_mall;
    if (name == 'Personal Care') return Icons.favorite_border;
    if (name == 'Snacks & All') return Icons.fastfood;
    if (name == 'Beverages') return Icons.local_bar;
    return Icons.local_dining;
  }

  Color getColor1(String name) {
    if (name == 'Grocery') return Color(0xff066E4B);
    if (name == 'Personal Care') return Color(0xffA8DEEA);
    if (name == 'Snacks & All') return Color(0xffFEBE50);
    if (name == 'Household') return Color(0xffF3DCEC);
    if (name == 'Beverages') return Color(0xffFEBE50);
    return Color(0xff183B8C);
  }

  Color getColor2(String name) {
    if (name == 'Grocery') return Color(0xffFFB74A);
    if (name == 'Personal Care') return Color(0xff066E4B);
    if (name == 'Snacks & All') return Color(0xffFF5465);
    if (name == 'Household') return Color(0xff1D4491);
    if (name == 'Beverages') return Color(0xffFFFFFF);
    return Color(0xffF3DCEC);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 125,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'SHOP BY CATEGORIES',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: categoryModel == null
                  ? Container()
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryModel.length,
                      itemBuilder: (BuildContext context, int index) =>
                          CategoryCard(
                        text1: categoryModel[index].name,
                        text2: categoryModel[index].description,
                        icon: getIcon(categoryModel[index].name),
                        color1: getColor1(categoryModel[index].name),
                        color2: getColor2(categoryModel[index].name),
                      ),
                    ),
            ), 
          ],
        ),
      ),
    );
  }
}
