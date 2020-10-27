# Tessaract.io Backend API

The backend API functions are accessed via this URL:

    https://$(SUBDOMAIN).tessaract.io/json_rpc

The subdomain depends on the client company.

The requests and responses use the JSON format and follow the JSON-RPC spec:

    https://www.jsonrpc.org/specification

## API functions

### 1. User login

Sample request:

```json
{
    "id": 1603770625657,
    "method": "execute",
    "params": [
        "login",
        "login",
        ["test.user@tessaract.io","test.password"],
        {},
        {}
    ]
}
```

Sample response:

```json
{
    "dt": 4713,
    "error": null,
    "id": 1603770625657,
    "result": {
        "company_code": "IRASTEST",
        "company_id": 114,
        "login": "test.user@tessaract.io",
        "next": {
            "type": "url",
            "url": "/action?name=aln_board"
        },
        "token": "dGVzc19zdGFnaW5nIDE1OTE0|1603777694|87606450ede170e3e72c3f4c2d1682f444bccd04",
        "user_id": 15914
    }
}
```

[Sample script](login.sh)

Note:
The login function is using /json_rpc_pub and not /json_rpc because of firewall IP address whitelisting.
    
## 2. Get client list

Sample request:

```json
{
  "id": 1603770625657,
  "method": "execute",
  "params": [
      "aln.client",
      "search_read_path",
      [
        [],
        ["first_name","last_name","email"]
      ],
      {},
      {
        "user_id": 15914,
        "company_id": 114,
        "token": "dGVzc19zdGFnaW5nIDE1OTE0|1603776858|c2f5cc3b8697845fa8cebd4949f46d8e8ce9aab6"
      }
  ]
}
```

Sample response:

```json
{
    "dt": 382,
    "error": null,
    "id": 1603770625657,
    "result": [
        {
            "email": "john@doe.com",
            "first_name": "John",
            "id": 197258,
            "last_name": "Doe"
        },
        {
            "email": "alice@smith.com",
            "first_name": "Alice",
            "id": 197257,
            "last_name": "Smith"
        }
    ]
}
```

Sample script:

```console
curl --header "Content-Type: application/json" \
  --request POST \
  --data '{
      "id": 1603770625657,
      "method": "execute",
      "params": [
          "aln.client",
          "search_read",
          [
            [],
            ["first_name","last_name","email"]
          ],
          {},
          {
            "user_id": 15912,
            "company_id": 114,
            "token": "dGVzc19zdGFnaW5nIDE1OTEy|1603772113|925796284137cbde797c2afc9b7013e0ded113f5"
          }
      ]
  }' \
  https://staging-backend.tessaract.io/json_rpc
```

### 3. Get cases for a specific client

### 4. Get case details

### 5. Create new case
