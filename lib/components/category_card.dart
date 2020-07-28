import 'package:flutter/material.dart';
import 'package:qirana_app/model/product_model.dart';
import 'package:qirana_app/networking/api_driver.dart';
import 'package:qirana_app/networking/ApiResponse.dart';
import 'package:qirana_app/screens/vertical_view_page.dart';

// ignore: must_be_immutable
class CategoryCard extends StatelessWidget {
  final String categoryId;
  final Color color1;
  final Color color2;
  final IconData icon;
  final String text1;
  final String text2;
  final String url;

  CategoryCard(
      {this.color1,
      this.color2,
      this.icon,
      this.text1,
      this.text2,
      this.categoryId,
      this.url});

  final ApiDriver apiDriver = new ApiDriver();
  final List<ProductModel> productModel = List<ProductModel>();
  List<ProductModel> getData(List data) {
    for (var i = 0; i < data.length; i++) {
      productModel.add(ProductModel.fromMap(data[i]));
    }
    return productModel;
  }

  bool flag = false;

  String getCategoryUrl(String name) {
    if (name == 'Grocery') return 'category-name/grocery';
    if (name == 'Personal Care') return 'category-name/personal-care';
    if (name == 'Snacks & All') return 'category-name/snacks-&-all';
    if (name == 'Household Items') return 'category-name/household-items';
    if (name == 'Beverages')
      return 'category-name/beverages';
    else {
      print(url);
      flag = true;
      return 'sub-category-name/' + url;
    }
  }

  ApiResponse subCategoryResponse;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          ApiResponse response = await apiDriver.getData(getCategoryUrl(text1));
          if (!flag)
            subCategoryResponse = await apiDriver.getSubCategory(categoryId);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VerticalViewPage(
                      getData(response.listData),
                      subCategoryResponse == null
                          ? null
                          : subCategoryResponse.listData,
                      text1)));
        },
        child: Container(
          width: 85,
          height: 85,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: color1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Icon(
                      icon,
                      color: color2,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Text(
                          text1,
                          style: TextStyle(color: color2),
                          maxLines: 2,
                          softWrap: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
