# Coinbase Advanced Trade API Endpoints - TODO

Coinbase Rest API Documentation:
https://docs.cdp.coinbase.com/coinbase-app/advanced-trade-apis/rest-api

## Public Endpoints

- [ ] [GET /v3/brokerage/time - Get Server Time](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/public/get-server-time)
- [ ] [GET /v3/brokerage/market/product_book - Get Public Product Book](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/public/get-public-product-book)
- [ ] [GET /v3/brokerage/market/products - List Public Products](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/public/list-public-products)
- [ ] [GET /v3/brokerage/market/products/{product_id} - Get Public Product](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/public/get-public-product)
- [ ] [GET /v3/brokerage/market/products/{product_id}/candles - Get Public Product Candles](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/public/get-public-product-candles)
- [ ] [GET /v3/brokerage/market/products/{product_id}/ticker - Get Public Market Trades](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/public/get-public-market-trades)

## Private Endpoints

### Accounts:

- [x] [GET /v3/brokerage/accounts - List Accounts](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/accounts/list-accounts)
- [x] [GET /v3/brokerage/accounts/:account_id - Get Account](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/accounts/get-account)

### Orders

- [x] [GET /v3/brokerage/orders/historical/{order_id} - Get Order](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/orders/get-order)
- [x] [GET /v3/brokerage/orders/historical/batch - List Orders](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/orders/list-orders)
- [x] [GET /v3/brokerage/orders/historical/fills - List Fills](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/orders/list-fills)
- [x] [POST /v3/brokerage/orders - Create Order](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/orders/create-order)
- [ ] [POST /v3/brokerage/orders/batch_cancel - Cancel Orders](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/orders/cancel-order)
- [ ] [POST /v3/brokerage/orders/preview - Preview Orders](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/orders/preview-orders)
- [ ] [POST /v3/brokerage/orders/edit - Edit Order](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/orders/edit-order)
- [ ] [POST /v3/brokerage/orders/edit_preview - Edit Order Preview](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/orders/edit-order-preview)
- [ ] [POST /v3/brokerage/orders/close_position - Close Position](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/orders/close-position)

### Products

- [ ] [GET /v3/brokerage/best_bid_ask - Get Best Bid/Ask](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/products/get-best-bid-ask)
- [ ] [GET /v3/brokerage/product_book - Get Product Book](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/public/get-public-product-book)
- [x] [GET /v3/brokerage/products - List Products](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/products/list-products)
- [x] [GET /v3/brokerage/products/{product_id} - Get Product](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/products/get-product)
- [ ] [GET /v3/brokerage/products/{product_id}/candles - Get Product Candles](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/products/get-product-candles)
- [x] [GET /v3/brokerage/products/{product_id}/ticker - Get Market Trades](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/products/get-market-trades)

### Fees

- [x] [GET /v3/brokerage/transaction_summary - Get Transactions Summary](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/fees/get-transaction-summary)

### Convert

- [ ] [POST /v3/brokerage/convert/quote - Create Convert Quote](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/convert/create-convert-quote)
- [ ] [POST /v3/brokerage/convert/{trade_id} - Commit Convert Trade](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/convert/commit-convert-trade)
- [ ] [GET /v3/brokerage/convert/{trade_id} - Get Convert Trade](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/convert/get-convert-trade)

### Portfolios

- [x] [GET /v3/brokerage/portfolios - List Portfolios](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/portfolios/list-portfolios)
- [x] [POST /v3/brokerage/portfolios - Create Portfolio](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/portfolios/create-portfolio)
- [x] [POST /v3/brokerage/portfolios/move_funds - Move Portfolio Funds](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/portfolios/move-portfolios-funds)
- [x] [GET /v3/brokerage/portfolios/{portfolio_uuid} - Get Portfolio Breakdown](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/portfolios/get-portfolio-breakdown)
- [x] [DELETE /v3/brokerage/portfolios/{portfolio_uuid} - Delete Portfolio](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/portfolios/delete-portfolio)
- [x] [PUT /v3/brokerage/portfolios/{portfolio_uuid} - Edit Portfolio](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/portfolios/edit-portfolio)

### Payment Methods

- [ ] [GET /v3/brokerage/payment_methods - List Payment Methods](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/payment-methods/list-payment-methods)
- [ ] [GET /v3/brokerage/payment_methods/{payment_method_id} - Get Payment Method](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/payment-methods/get-payment-method)

### Data API

- [x] [GET /v3/brokerage/key_permissions - Get Api Key Permissions](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/data-api/get-api-key-permissions)

## US Derivatives (Futures)

- [ ] [GET /v3/brokerage/cfm/balance_summary - Get Futures Balance Summary](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/futures/get-futures-balance-summary)
- [ ] [GET /v3/brokerage/cfm/positions - List Futures Positions](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/futures/list-futures-positions)
- [ ] [GET /v3/brokerage/cfm/positions/{product_id} - Get Futures Position](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/futures/get-futures-position)
- [ ] [POST /v3/brokerage/cfm/sweeps/schedule - Schedule Futures Sweep](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/futures/schedule-futures-sweep)
- [ ] [GET /v3/brokerage/cfm/sweeps - List Futures Sweeps](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/futures/list-futures-sweeps)
- [ ] [DELETE /v3/brokerage/cfm/sweeps - Cancel Pending Futures Sweep](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/futures/cancel-pending-futures-sweep)
- [ ] [GET /v3/brokerage/cfm/intraday/margin_setting - Get Intraday Margin Setting](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/futures/get-intraday-margin-setting)
- [ ] [POST /v3/brokerage/cfm/intraday/margin_setting - Set Intraday Margin Setting](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/futures/set-intraday-margin-settings)
- [ ] [GET /v3/brokerage/cfm/intraday/current_margin_window - Get Current Margin Window](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/futures/get-current-margin-window)

## International Derivatives (Futures)

- [ ] [GET /v3/brokerage/intx/portfolio/{portfolio_uuid} - Get Perpetuals Portfolio Summary](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/perpetuals/get-perpetuals-portfolio-summary)
- [ ] [GET /v3/brokerage/intx/positions/{portfolio_uuid} - List Perpetuals Positions](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/perpetuals/list-perpetuals-positions)
- [ ] [GET /v3/brokerage/intx/positions/{portfolio_uuid}/{symbol} - Get Perpetuals Position](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/perpetuals/get-perpetuals-position)
- [ ] [GET /v3/brokerage/intx/balances/{portfolio_uuid} - Get Perpetuals Portfolio Balances](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/perpetuals/get-portfolio-balances)
- [ ] [POST /v3/brokerage/intx/multi_asset_collateral - Opt-In Multi Asset Collateral](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/perpetuals/opt-in-or-out)
- [ ] [POST /v3/brokerage/intx/allocate - Allocate Portfolio](https://docs.cdp.coinbase.com/api-reference/advanced-trade-api/rest-api/perpetuals/allocate-portfolio)
