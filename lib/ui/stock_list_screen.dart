import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unstable_ticker/ui/widgets/stock_tile.dart';
import '../controller/stock_controller.dart';



class StockListScreen extends StatelessWidget {
  final controller = Get.put(StockController());

  StockListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Unstable Ticker", style: TextStyle(color: Colors.white,fontSize: 20)),
        backgroundColor: Colors.black,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: Obx(() => Text(
            controller.connectionStatus.value,
            style: const TextStyle(color: Colors.white70),
          )),
        ),
      ),
      body: Obx(() {
        final stocks = controller.stocks.values.toList();
        return ListView.builder(
          itemCount: stocks.length,
          itemBuilder: (context, index) {
            return StockTile(stock: stocks[index]);
          },
        );
      }),
    );
  }
}
