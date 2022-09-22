import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../widgets/app_bar/custom_app_bar.dart';
import '../../../../../../colors/my_colors.dart';
import '../../../../../../providers/product_provider.dart';
import '../../../../../../widgets/input_fields/text_input_field.dart';
import '../../../../../../helpers/input_field_validators.dart';

class AddIngredientScreen extends StatefulWidget {
  const AddIngredientScreen({
    Key? key,
    required this.addIngredientCallback,
  }) : super(key: key);

  final Function addIngredientCallback;

  @override
  State<AddIngredientScreen> createState() => _AddIngredientScreenState();
}

class _AddIngredientScreenState extends State<AddIngredientScreen> {
  final TextEditingController _productController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final FocusNode _productInputFocusNode = FocusNode();
  final FocusNode _quantityInputFocusNode = FocusNode();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final List<String> _dropdownValues = ['buc.', 'ml', 'L', 'g', 'kg'];
  String _dropdownValue = 'buc.';
  bool _productNameEnabled = true;
  bool _productUmEnabled = true;

  Future<void> _onSearchTextChanged(String text) async {
    if (!mounted) return;
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    await Provider.of<ProductProvider>(
      context,
      listen: false,
    ).fetchByText(text);
  }

  void _onResetProduct() {
    if (!_productNameEnabled) {
      setState(() {
        _productNameEnabled = true;
        _productUmEnabled = true;
        _productController.text = '';
        _dropdownValue = _dropdownValues[0];
      });
    }
  }

  void _onProductSelected(String productName, String um) {
    setState(() {
      _productNameEnabled = false;
      _productUmEnabled = false;
      _productController.text = productName;
      _dropdownValue = um;
    });
    Provider.of<ProductProvider>(
      context,
      listen: false,
    ).resetProducts();
  }

  void _onFormSubmit() {
    if (_key.currentState!.validate()) {
      widget.addIngredientCallback({
        'name': _productController.text,
        'quantity': _quantityController.text,
        'um': _dropdownValue,
      });
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _productController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onActionTapCallback: _onFormSubmit,
        title: 'Add Ingredient',
        border: const Border(
          bottom: BorderSide(color: Colors.black12),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Add',
                style: TextStyle(
                  color: MyColors.greenColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _key,
              child: Column(
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    onTap: _onResetProduct,
                    child: TextInputField(
                      focusNode: _productInputFocusNode,
                      enabled: _productNameEnabled,
                      controller: _productController,
                      label: 'Product*',
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      onChanged: _onSearchTextChanged,
                      validatorCallback:
                          InputFieldValidators.productNameValidator,
                    ),
                  ),
                  Stack(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 50 / 100,
                            child: TextInputField(
                              focusNode: _quantityInputFocusNode,
                              controller: _quantityController,
                              label: 'Quantity*',
                              autofocus: false,
                              keyboardType: TextInputType.number,
                              validatorCallback:
                                  InputFieldValidators.productQuantityValidator,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 35 / 100,
                            child: DropdownButtonFormField<String>(
                              autofocus: false,
                              decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: MyColors.greenColor),
                                ),
                              ),
                              icon: const RotatedBox(
                                quarterTurns: 3,
                                child: Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: Colors.black,
                                  size: 15,
                                ),
                              ),
                              value: _dropdownValue,
                              items: _dropdownValues
                                  .map((value) => DropdownMenuItem(
                                        value: value,
                                        child: Text(value),
                                      ))
                                  .toList(),
                              onChanged: _productUmEnabled
                                  ? (String? newValue) {
                                      setState(() {
                                        _dropdownValue = newValue!;
                                      });
                                    }
                                  : null,
                            ),
                          ),
                        ],
                      ),
                      Consumer<ProductProvider>(
                        builder: (context, productProvider, child) =>
                            _productController.text == '' ||
                                    productProvider.products.isEmpty
                                ? Container()
                                : Container(
                                    constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(context).size.height *
                                              40 /
                                              100,
                                    ),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                          color: Colors.black12,
                                          width: 0.5,
                                        ),
                                        right: BorderSide(
                                          color: Colors.black12,
                                          width: 0.5,
                                        ),
                                        bottom: BorderSide(
                                          color: Colors.black12,
                                          width: 0.5,
                                        ),
                                      ),
                                    ),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          productProvider.products.length,
                                      itemBuilder: (context, index) => InkWell(
                                        onTap: () {
                                          _onProductSelected(
                                            productProvider
                                                .products[index].name,
                                            productProvider.products[index].um,
                                          );
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            border: Border(
                                              top: BorderSide(
                                                color: Colors.black12,
                                              ),
                                            ),
                                          ),
                                          child: ListTile(
                                            leading: Text(
                                              productProvider
                                                  .products[index].name,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            trailing: Text(
                                              productProvider
                                                  .products[index].um,
                                              style: const TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Name a product.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
