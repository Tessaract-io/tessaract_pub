# Backend API

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
        ["test_login","test_password"],
        {},
        {}
    ]
}
```

Sample response:

```json
{
   "result":{
      "token":"dGVzc19zdGFnaW5nIDE1OTEy|1603772113|925796284137cbde797c2afc9b7013e0ded113f5",
      "next":{
         "type":"url",
         "url":"/action?name=aln_board"
      },
      "company_id":114,
      "user_id":15912,
      "login":"test_login",
      "company_code":"IRASTEST"
   },
   "error":null,
   "dt":199,
   "id":1603770625657
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
          "login",
          "login",
          ["test_login","test_password"],
          {},
          {}
      ]
  }' \
  https://staging-backend.tessaract.io/json_rpc_pub
```

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
}
```

Sample response:

```json
{
   "result":[
      {
         "email":"test@test.com",
         "last_name":"Smith",
         "id":197256,
         "first_name":"Alice"
      },
      {
         "email":"john@doe.com",
         "last_name":"Doe",
         "id":197255,
         "first_name":"John"
      }
   ],
   "error":null,
   "dt":40,
   "id":1603770625657
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
