import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../colors/my_colors.dart';
import '../../../widgets/input_fields/text_input_field.dart';
import '../../../widgets/input_fields/dropdown_menu.dart';
import '../../../helpers/input_field_validators.dart';
import '../../../providers/product_stock_provider.dart';

class SubmitAddStockScreen extends StatefulWidget {
  const SubmitAddStockScreen({
    Key? key,
    required this.productName,
  }) : super(key: key);

  final String productName;

  @override
  State<SubmitAddStockScreen> createState() => _SubmitAddStockScreenState();
}

class _SubmitAddStockScreenState extends State<SubmitAddStockScreen> {
  final TextEditingController _quantityController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  // Future<void> _onConfirm() async {
  //   await Provider.of<ProductStockProvider>(context).addStock(
  //     double.parse(_quantityController.text),
  //     widget.productName,
  //     _dropdownValues,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Add `${widget.productName}`",
        actions: const [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Confirm',
                style: TextStyle(
                  color: MyColors.greenColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
        border: const Border(
          bottom: BorderSide(
            color: Colors.black12,
          ),
        ),
        onActionTapCallback: () {},
      ),
      body: Form(
        key: _key,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 50 / 100,
                child: TextInputField(
                  controller: _quantityController,
                  label: 'Quantity',
                  validatorCallback: (String? value) =>
                      InputFieldValidators.productQuantityValidator(value),
                  autofocus: true,
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 35 / 100,
                child: DropDownMenu(
                  validatorCallback: (String? value) =>
                      InputFieldValidators.productUmValidator(value),
                  options: const ['buc.', 'L', 'g', 'kg'],
                  icon: const RotatedBox(
                    quarterTurns: 3,
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.black,
                      size: 15,
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
