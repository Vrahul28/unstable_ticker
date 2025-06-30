class Stock {
  final String ticker;
  double price;
  double lastPrice;
  bool isAnomalous;

  Stock({
    required this.ticker,
    required this.price,
    this.lastPrice = 0.0,
    this.isAnomalous = false,
  });

  void updatePrice(double newPrice) {
    lastPrice = price;
    price = newPrice;
  }

  bool get hasIncreased => lastPrice != null && price > lastPrice!;
  bool get hasDecreased => lastPrice != null && price < lastPrice!;
}