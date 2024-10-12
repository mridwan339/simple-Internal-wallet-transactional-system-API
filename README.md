# Step for Start
- bundle install
- rails db:setup
for initialize / install and migration database and seed

- rails s
for start the server

# Login Accounts
- email : jhony@example.net || password : password
- email : udin@example.net || password : password
- email : bean@example.net || password : password 

# [API Docs] Internal Wallet Transactional System API Documentation
- Import apidocs.json file in root folder to Insomnia App

## Prerequisites

=== Minimum Requirement ===
- Ruby Version ruby 3.0.0p0 and Rails 7.1.4 Version
- Database : PostgreSQL 16
============||=============

- Ensure you have Insomnia installed. If not, download it from [Insomnia's official website](https://insomnia.rest/download)

## Steps to Import `apidocs.json`

1. **Open Insomnia REST API App**
   - Launch Insomnia from your applications menu.

2. **Import the `apidocs.json` File**
   - In Insomnia, click on the top-left menu (three horizontal lines).
   - Select **Import/Export**.
   - Click **Import Data** > **From File**.
   - Navigate to the root folder where the `apidocs.json` file is located.
   - Select `apidocs.json` to import.

3. **Confirm the Import**
   - After selecting the file, Insomnia will prompt you to confirm the import.
   - Click **Confirm** to proceed. The imported API collection will now be visible in your Insomnia workspace.

This README provides an overview and documentation of the available API endpoints for the **Internal Wallet Transactional System**. The APIs are designed to manage wallet transactions and access stock price data.

## Base URL

The base URL for all API requests is:

```
http://127.0.0.1:3000
```

## Authentication

### 1. Login

- **Endpoint**: `POST /api/v1/sessions`
- **Description**: Authenticates a user
- **Request Body**:
  ```json
  {
    "email": "jhony@example.net",
    "password": "password"
  }
  ```

### 2. Logout

- **Endpoint**: `DELETE /api/v1/sessions/1`
- **Description**: Logs out the user by invalidating the current session token.
- **Authentication**: Bearer token required.

## Wallet Management

### 1. Get Wallet Information

- **Endpoint**: `GET /api/v1/wallets/1`
- **Description**: Retrieves information about the wallet.

### 2. Credit Wallet

- **Endpoint**: `POST /api/v1/wallets/1/credit`
- **Description**: Credits a specified amount to the wallet.
- **Request Body**:
  ```json
  {
    "amount": 500
  }
  ```

### 3. Debit Wallet

- **Endpoint**: `POST /api/v1/wallets/1/debit`
- **Description**: Debits a specified amount from the wallet.
- **Request Body**:
  ```json
  {
    "amount": 500
  }
  ```

### 4. Transfer Wallet

- **Endpoint**: `POST /api/v1/wallets/1/transfer`
- **Description**: Transfers a specified amount to another wallet.
- **Request Body**:
  ```json
  {
    "target_wallet_id": 2,
    "amount": 500
  }
  ```

### 5. Get Wallet Transaction Information

- **Endpoint**: `GET /api/v1/wallets/1/transactions`
- **Description**: Retrieves the transaction history for the wallet.

## Stock Price Management

### 1. Get Price

- **Endpoint**: `GET /api/v1/stock_prices/price`
- **Description**: Retrieves the latest price of a specific stock.
- **Parameters**:
  - `symbol` (required): The symbol of the stock (e.g., `ZOMA.NS`).

### 2. Get Prices

- **Endpoint**: `GET /api/v1/stock_prices/prices`
- **Description**: Retrieves the latest prices for multiple stocks.
- **Parameters**:
  - `symbols` (required): A comma-separated list of stock symbols (e.g., `ZOMA.NS,GODRCONS.NS`).

### 3. Get All Prices

- **Endpoint**: `GET /api/v1/stock_prices/price_all`
- **Description**: Retrieves the latest prices for all available stocks.

## Headers

All requests must include the following headers:

- `Content-Type`: `application/json`
- `User-Agent`: `insomnia/10.0.0`

## Notes

- Replace `{base_url}` with the actual base URL (`http://127.0.0.1:3000`) when making requests.
- Some endpoints require bearer token authentication, which can be obtained using the Login API.
