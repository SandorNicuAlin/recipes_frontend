import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/input_fields/text_input_field.dart';
import '../../../providers/product_provider.dart';
import '../../../colors/my_colors.dart';
import '../../../helpers/custom_animations.dart';
import './submit_add_stock_screen.dart';
import '../../../helpers/input_field_validators.dart';

class AddStockScreen extends StatefulWidget {
  const AddStockScreen({Key? key}) : super(key: key);

  @override
  State<AddStockScreen> createState() => _AddStockScreenState();
}

class _AddStockScreenState extends State<AddStockScreen> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  Future<void> _onSearchTextChanged(String text) async {
    await Future.delayed(const Duration(milliseconds: 250));
    if (!mounted) return;
    await Provider.of<ProductProvider>(
      context,
      listen: false,
    ).fetchByText(text);
  }

  void _onConfirm(String productName) {
    if (_key.currentState!.validate()) {
      Navigator.of(context).pushReplacement(
        CustomAnimations.pageTransitionRightToLeft(
          SubmitAddStockScreen(
            productName: productName,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Add Stock',
        border: const Border(
          bottom: BorderSide(
            color: Colors.black12,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Next',
                style: TextStyle(
                  color: MyColors.greenColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
        onActionTapCallback: () {
          _onConfirm(_controller.text);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Consumer<ProductProvider>(
          builder: (context, productProvider, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _key,
                child: TextInputField(
                  controller: _controller,
                  label: 'Product',
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  onChanged: _onSearchTextChanged,
                  validatorCallback: (String? value) =>
                      InputFieldValidators.productNameValidator(value),
                ),
              ),
              _controller.text == '' || productProvider.products.isEmpty
                  ? const SizedBox(height: 10)
                  : Container(),
              _controller.text == '' || productProvider.products.isEmpty
                  ? const Text(
                      'Name a product.',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    )
                  : Container(),
              _controller.text == '' || productProvider.products.isEmpty
                  ? Container()
                  : Container(
                      constraints: BoxConstraints(
                        maxHeight:
                            MediaQuery.of(context).size.height * 40 / 100,
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
                        itemCount: productProvider.products.length,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: Colors.black12,
                                ),
                              ),
                            ),
                            child: ListTile(
                              leading: Text(
                                productProvider.products[index].name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: Text(
                                productProvider.products[index].um,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
