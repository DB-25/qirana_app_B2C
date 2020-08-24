import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'item_view_vertical.dart';
import 'package:qirana_app/model/product_model.dart';

class VerticalView extends StatelessWidget {
  final List<ProductModel> productModel;

  VerticalView({this.productModel});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 150) / 2;
    final double itemWidth = size.width / 2;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 2 + 140,
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: (itemWidth / itemHeight),
            shrinkWrap: true,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: List.generate(productModel.length, (index) {
              return ItemViewVertical(
                productModel: productModel[index],
                showQuantity: false,
              );
            }),
          )),
    );
  }
}
