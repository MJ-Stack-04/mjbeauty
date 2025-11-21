import 'package:get/get.dart';
import 'package:mjbeauty/model/model.dart';

class ProductController extends GetxController {
  var selectedProduct = Rxn<Product> ();

  void setProduct ( Product product) {
    selectedProduct.value= product;
  }
}
