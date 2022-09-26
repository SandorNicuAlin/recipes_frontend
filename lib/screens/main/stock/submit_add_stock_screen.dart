import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:another_flushbar/flushbar.dart';

import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../colors/my_colors.dart';
import '../../../widgets/input_fields/text_input_field.dart';
import '../../../helpers/input_field_validators.dart';
import '../../../providers/product_stock_provider.dart';

class SubmitAddStockScreen extends StatefulWidget {
  const SubmitAddStockScreen({
    Key? key,
    required this.productName,
    required this.previousPageData,
  }) : super(key: key);

  final String productName;
  final Map previousPageData;

  @override
  State<SubmitAddStockScreen> createState() => _SubmitAddStockScreenState();
}

class _SubmitAddStockScreenState extends State<SubmitAddStockScreen> {
  final TextEditingController _quantityController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final List<String> _dropdownValues = ['buc.', 'ml', 'L', 'g', 'kg'];
  String _dropdownValue = 'buc.';

  Future<void> _onConfirm() async {
    if (widget.previousPageData['page'] == 'Stock') {
      if (_key.currentState!.validate()) {
        Map response = await Provider.of<ProductStockProvider>(
          context,
          listen: false,
        ).updateQuantity(
          _quantityController.text,
          widget.previousPageData['productStockId'],
        );

        // 400 - validation error
        if (response['statusCode'] == 400) {
          if (!mounted) return;
          await Flushbar(
            backgroundColor: Colors.red,
            title: 'Error',
            message: 'Something went wrong',
            duration: const Duration(seconds: 2),
          ).show(context);
        }
        if (response['statusCode'] == 200) {
          if (!mounted) return;
          Navigator.pop(context);
        }
      }
    } else {
      if (_key.currentState!.validate()) {
        Map response = await Provider.of<ProductStockProvider>(
          context,
          listen: false,
        ).addStock(
          _quantityController.text,
          widget.productName,
          _dropdownValue,
        );

        // 400 - validation error
        if (response['statusCode'] == 400) {
          if (!mounted) return;
          await Flushbar(
            backgroundColor: Colors.red,
            title: 'Error',
            message: 'Something went wrong',
            duration: const Duration(seconds: 2),
          ).show(context);
        }
        if (response['statusCode'] == 200) {
          if (!mounted) return;
          Navigator.pop(context);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.previousPageData['page'] == 'Stock') {
      _dropdownValue = widget.previousPageData['product']!.um;
    } else if (widget.previousPageData['page'] == 'ProductSelected') {
      _dropdownValue = widget.previousPageData['um'];
    }
    return Scaffold(
      appBar: CustomAppBar(
        title:
            "${widget.previousPageData['page'] == 'Stock' ? "Edit" : "Add"} `${widget.productName}`",
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
        onActionTapCallback: _onConfirm,
      ),
      body: Form(
        key: _key,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 50 / 100,
                child: TextInputField(
                  controller: _quantityController,
                  label: 'Quantity',
                  validatorCallback:
                      InputFieldValidators.productQuantityValidator,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 35 / 100,
                child: DropdownButtonFormField<String>(
                  autofocus: false,
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: MyColors.greenColor),
                    ),
                  ),
                  icon: RotatedBox(
                    quarterTurns: 3,
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: widget.previousPageData['page'] == 'Stock' ||
                              widget.previousPageData['page'] ==
                                  'ProductSelected'
                          ? Colors.grey
                          : Colors.black,
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
                  onChanged: widget.previousPageData['page'] == 'Stock' ||
                          widget.previousPageData['page'] == 'ProductSelected'
                      ? null
                      : (String? newValue) {
                          setState(() {
                            _dropdownValue = newValue!;
                          });
                        },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
