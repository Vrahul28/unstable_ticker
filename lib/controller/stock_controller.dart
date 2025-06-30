import 'package:get/get.dart';

import '../model/stock.dart';
import '../seervice/websocket_service.dart';


class StockController extends GetxController {
  final WebSocketService _webSocketService = WebSocketService();

  var stocks = <String, Stock>{}.obs;
  var connectionStatus = "Connecting".obs;

  @override
  void onInit() {
    super.onInit();
    _webSocketService.stream.listen(
      _handleData,
      onDone: () => connectionStatus.value = 'Disconnected',
      onError: (_) => connectionStatus.value = 'Error',
    );
    _webSocketService.connect();
  }

  void _handleData(List<Map<String, dynamic>> data) {
    connectionStatus.value = 'Connected';

    for (var item in data) {
      try {
        final ticker = item['ticker'];
        final price = double.parse(item['price']);

        final existing = stocks[ticker];
        bool isAnomalous = false;

        if (existing != null && price < existing.price * 0.2) {
          isAnomalous = true;
        }

        if (isAnomalous) {
          stocks[ticker] = Stock(
            ticker: ticker,
            price: existing!.price,
            lastPrice: existing.price,
            isAnomalous: true,
          );
        } else {
          if (existing != null) {
            existing.updatePrice(price);
            existing.isAnomalous = false;
            stocks[ticker] = existing;
          } else {
            stocks[ticker] = Stock(ticker: ticker, price: price);
          }
        }
      } catch (_) {
        continue;
      }
    }
  }

  @override
  void onClose() {
    _webSocketService.dispose();
    super.onClose();
  }
}
