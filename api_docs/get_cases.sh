#!/bin/sh
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
