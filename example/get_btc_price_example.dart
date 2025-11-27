import 'package:coinbase_cloud_advanced_trade_client/coinbase_cloud_advanced_trade_client.dart';

// This is a simple example of how to use the public products API to get the
// price of a product.
//
// To run this example, you don't need any credentials.
//
// https://docs.cdp.coinbase.com/advanced-trade/docs/welcome/
//
// This example will get the price of BTC-USD and print it to the console.
void main() async {
  // Get the latest market data for BTC-USD.
  final Ticker? ticker = await getMarketTrades(productId: 'BTC-USD');

  // Print the price to the console.
  if (ticker != null) {
    if (ticker.trades case final trades? when trades.isNotEmpty) {
      print('The latest trade price of BTC-USD is: 	${trades.first.price}');
    } else {
      print('No recent trades found for BTC-USD.');
    }
    print('The best bid price for BTC-USD is: ${ticker.bestBid}');
    print('The best ask price for BTC-USD is: ${ticker.bestAsk}');
  } else {
    print('Failed to get the ticker for BTC-USD.');
  }
}
