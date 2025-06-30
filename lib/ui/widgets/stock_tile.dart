import 'package:flutter/material.dart';
import '../../model/stock.dart';


class StockTile extends StatefulWidget {
  final Stock stock;
  const StockTile({super.key, required this.stock});

  @override
  State<StockTile> createState() => _StockTileState();
}

class _StockTileState extends State<StockTile> {

  @override
  Widget build(BuildContext context) {
    final color = widget.stock.hasIncreased
        ? Colors.green
        : widget.stock.hasDecreased
        ? Colors.red
        : Colors.black;

    return ListTile(
      leading: widget.stock.isAnomalous
          ? const Icon(Icons.warning, color: Colors.orange)
          : null,
      title: Text(widget.stock.ticker),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "\$${widget.stock.price.toStringAsFixed(2)}",
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
