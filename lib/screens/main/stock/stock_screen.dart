import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/product_stock_provider.dart';
import '../../../widgets/cards/custom_card.dart';
import '../../../widgets/buttons/square_button.dart';
import '../../../colors/my_colors.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black12,
                ),
              ),
            ),
            child: const Text(
              'Stock',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 2),
          Consumer<ProductStockProvider>(
            builder: (context, productStockProvider, child) => Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    bottom: MediaQuery.of(context).size.height * 10.5 / 100),
                child: GridView.builder(
                  itemCount: productStockProvider.stock.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 220,
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) => CustomCard(
                    image: const AssetImage('images/bakery&snacks.png'),
                    title: productStockProvider.stock[index].product.name,
                    subtitle: productStockProvider.stock[index].product.um,
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SquareButton(
                          content: Icon(
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
                              productStockProvider.stock[index].quantity
                                  .toString(),
                              maxLines: 1,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        const SquareButton(
                          content: Icon(
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
          )
        ],
      ),
    );
  }
}
