import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:another_flushbar/flushbar.dart';

import '../../../providers/product_stock_provider.dart';
import '../../../widgets/cards/custom_card.dart';
import '../../../widgets/buttons/square_button.dart';
import '../../../colors/my_colors.dart';
import './add_stock_screen.dart';
import './submit_add_stock_screen.dart';
import '../../../helpers/custom_animations.dart';
import '../../../widgets/loading/custom_circular_progress_indicator.dart';
import '../../../widgets/modals/yes_no_modal.dart';
import '../../../classes/product_stock.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({Key? key}) : super(key: key);

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  bool _firstTime = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() async {
    if (_firstTime) {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<ProductStockProvider>(
        context,
        listen: false,
      ).fetchStock();
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      _firstTime = false;
    }
    super.didChangeDependencies();
  }

  Future<void> _incrementDecrementHandler(
    bool isIncrementing,
    int productStockId,
  ) async {
    Map response = await Provider.of<ProductStockProvider>(
      context,
      listen: false,
    ).incrementDecrementQuantity(
      isIncrementing,
      productStockId,
    );

    // 400 response
    if (response['statusCode'] == 400) {
      if (!mounted) return;
      await Flushbar(
        backgroundColor: Colors.red,
        title: 'Error',
        message: 'Something went wrong',
        duration: const Duration(seconds: 2),
      ).show(context);
    }
  }

  Future<void> _onProductStockDelete(ProductStock productStock) async {
    showCupertinoDialog(
      context: context,
      builder: (context) => YesNoModal.yesNoModal(
        title: const Text(
          'Delete product from stock',
        ),
        content: Text(
          "Do you want to delete '${productStock.product.name}' from the stock?",
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('Yes'),
            onPressed: () async {
              Navigator.pop(context);
              Map response = await Provider.of<ProductStockProvider>(
                context,
                listen: false,
              ).removeStock(
                productStock.id,
              );
            },
          ),
          CupertinoDialogAction(
            child: const Text('No'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      barrierDismissible: true,
    );
  }

  Future<void> _onPageRefresh() async {
    await Provider.of<ProductStockProvider>(
      context,
      listen: false,
    ).fetchStock();
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 9.0,
              left: 16.0,
              right: 9.0,
              bottom: 9.0,
            ),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black12,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Stock',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                IconButton(
                  splashRadius: 30,
                  onPressed: () {
                    Navigator.of(context).push(
                      CustomAnimations.pageTransitionRightToLeft(
                        const AddStockScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.add_rounded,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          _isLoading
              ? const Expanded(
                  child: Center(
                    child: CustomCircularProgressIndicator(
                      color: MyColors.greenColor,
                    ),
                  ),
                )
              : Consumer<ProductStockProvider>(
                  builder: (context, productStockProvider, child) => Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        // left: 16.0,
                        // right: 16.0,
                        bottom: MediaQuery.of(context).size.height * 10.3 / 100,
                      ),
                      child: RefreshIndicator(
                        color: MyColors.greenColor,
                        onRefresh: _onPageRefresh,
                        child: productStockProvider.stock.isEmpty
                            ? GridView(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                ),
                                children: [
                                  Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Padding(
                                          padding: EdgeInsets.all(30.0),
                                          child: Image(
                                            image: AssetImage(
                                              'images/stock.png',
                                            ),
                                          ),
                                        ),
                                        Text(
                                          'Your stock is empty at the moment',
                                          style:
                                              TextStyle(color: Colors.black45),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : GridView.builder(
                                padding: const EdgeInsets.only(
                                  left: 16.0,
                                  right: 16.0,
                                ),
                                itemCount: productStockProvider.stock.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 220,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                ),
                                itemBuilder: (context, index) => CustomCard(
                                  key: Key(productStockProvider.stock[index].id
                                      .toString()),
                                  onClickCallback: () {
                                    Navigator.of(context).push(
                                      CustomAnimations
                                          .pageTransitionRightToLeft(
                                        SubmitAddStockScreen(
                                          productName: productStockProvider
                                              .stock[index].product.name,
                                          previousPageData: {
                                            'page': 'Stock',
                                            'product': productStockProvider
                                                .stock[index].product,
                                            'productStockId':
                                                productStockProvider
                                                    .stock[index].id,
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  onDeleteCallback: () {
                                    _onProductStockDelete(
                                      productStockProvider.stock[index],
                                    );
                                  },
                                  image: const AssetImage(
                                      'images/bakery&snacks.png'),
                                  title: productStockProvider
                                      .stock[index].product.name,
                                  subtitle: productStockProvider
                                      .stock[index].product.um,
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SquareButton(
                                        onTap: () {
                                          _incrementDecrementHandler(
                                            false,
                                            productStockProvider
                                                .stock[index].id,
                                          );
                                        },
                                        content: const Icon(
                                          Icons.remove,
                                          color: Colors.grey,
                                          size: 18,
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      SizedBox(
                                        width: 30,
                                        child: Center(
                                          child: Text(
                                            productStockProvider
                                                .stock[index].quantity
                                                .toString(),
                                            maxLines: 1,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      SquareButton(
                                        onTap: () {
                                          _incrementDecrementHandler(
                                            true,
                                            productStockProvider
                                                .stock[index].id,
                                          );
                                        },
                                        content: const Icon(
                                          Icons.add,
                                          color: MyColors.greenColor,
                                          size: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
