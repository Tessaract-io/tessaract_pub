#!/bin/sh
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