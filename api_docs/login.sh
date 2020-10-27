#!/bin/sh
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
