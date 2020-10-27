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

```console
curl --header "Content-Type: application/json" \
  --request POST \
  --data '{
      "id": 1603770625657,
      "method": "execute",
      "params": [
          "login",
          "login",
          ["test.user@tessaract.io","test.password"],
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
  }' \
  https://staging-backend.tessaract.io/json_rpc
```

### 3. Get cases for a specific client

Sample request:
```json
{
  "id": 1603770625657,
  "method": "execute",
  "params": [
      "aln.job",
      "search_read_path",
      [
        [["client_id","=","197258"]],
        ["number","date","client_id.full_name","job_type_id.name","facts"]
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

Sample Response:
```json
{
    "error": null,
    "id": 1603770625657,
    "result": [
        {
            "client_id": {
                "full_name": "John Doe",
                "id": 197258
            },
            "date": "2020-10-27",
            "facts": "Test2",
            "id": 262209,
            "job_type_id": {
                "id": 2927,
                "name": "Divorce"
            },
            "number": "C-0002"
        },
        {
            "client_id": {
                "full_name": "John Doe",
                "id": 197258
            },
            "date": "2020-10-27",
            "facts": "Test1",
            "id": 262208,
            "job_type_id": {
                "id": 2927,
                "name": "Divorce"
            },
            "number": "C-0001"
        }
    ]
}
```

Sample Script:
```json
curl --header "Content-Type: application/json" \
  --request POST \
  --data '{
      "id": 1603770625657,
      "method": "execute",
      "params": [
          "aln.job",
          "search_read_path",
          [
            [["client_id","=","197258"]],
            ["number","date","client_id.full_name","job_type_id.name","facts"]
          ],
          {},
          {
            "user_id": 15914,
            "company_id": 114,
            "token": "dGVzc19zdGFnaW5nIDE1OTE0|1603776858|c2f5cc3b8697845fa8cebd4949f46d8e8ce9aab6"
          }
      ]
  }' \
  https://staging-backend.tessaract.io/json_rpc
```

### 4. Get case details

Sample request:
```json
{
  "id": 1603770625657,
  "method": "execute",
  "params": [
      "aln.job",
      "read_path",
      [
        ["262209"],
        ["number","date","client_id.full_name","job_type_id.name","facts","documents.title"]
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
    "error": null,
    "id": 1603770625657,
    "result": [
        {
            "client_id": {
                "full_name": "John Doe",
                "id": 197258
            },
            "date": "2020-10-27",
            "documents": [
                {
                    "id": 5610123,
                    "title": "Test document"
                }
            ],
            "facts": "Test2",
            "id": 262209,
            "job_type_id": {
                "id": 2927,
                "name": "Divorce"
            },
            "number": "C-0002"
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
          "aln.job",
          "read_path",
          [
            ["262209"],
            ["number","date","client_id.full_name","job_type_id.name","facts","documents.title"]
          ],
          {},
          {
            "user_id": 15914,
            "company_id": 114,
            "token": "dGVzc19zdGFnaW5nIDE1OTE0|1603776858|c2f5cc3b8697845fa8cebd4949f46d8e8ce9aab6"
          }
      ]
  }' \
  https://staging-backend.tessaract.io/json_rpc
```

### 5. Create new case

Sample request:
```json
{
  "id": 1603770625657,
  "method": "execute",
  "params": [
      "aln.job",
      "create",
      [
        {
            "client_id": 197257,
            "job_type_id": 2927,
            "facts": "This is a test case"
        }
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
    "error": null,
    "id": 1603770625657,
    "result": 262211
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
          "aln.job",
          "create",
          [
            {
                "client_id": 197257,
                "job_type_id": 2927,
                "facts": "This is a test case"
            }
          ],
          {},
          {
            "user_id": 15914,
            "company_id": 114,
            "token": "dGVzc19zdGFnaW5nIDE1OTE0|1603776858|c2f5cc3b8697845fa8cebd4949f46d8e8ce9aab6"
          }
      ]
  }' \
  https://staging-backend.tessaract.io/json_rpc
```
