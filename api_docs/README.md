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

Sample script (CURL):
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

Sample program (.NET):
```console
using System;
using System.IO;
using System.Net;
using System.Text;
using System.Collections.Generic;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace dotnet
{
    class Program
    {
        static dynamic rpc_execute(string model, string method, object[] args, Dictionary<string,object> opts) {
            string url="https://staging-backend.tessaract.io/json_rpc_pub";
            var req=(HttpWebRequest)WebRequest.Create(url);
            req.ContentType="application/json";
            req.Method="POST";
            object[] parms={model,method,args,opts};
            var req_data=new Dictionary<string,object>();
            req_data["id"]=DateTimeOffset.Now.ToUnixTimeSeconds();
            req_data["method"]="execute";
            req_data["params"]=parms;
            string payload=JsonSerializer.Serialize(req_data);
            var payload_bytes=Encoding.ASCII.GetBytes(payload);
            var stream=req.GetRequestStream();
            stream.Write(payload_bytes,0,payload_bytes.Length);
            var resp=(HttpWebResponse)req.GetResponse();
            var reader=new StreamReader(resp.GetResponseStream());
            string result=reader.ReadToEnd();
            var resp_data=JsonSerializer.Deserialize<Dictionary<string,object>>(result);
            var error=resp_data["error"];
            if (error!=null) {
                throw new Exception("Error: "+error);
            }
            return resp_data["result"];
        }

        static void Main()
        {
            string[] args={"test.user@tessaract.io","test.password"};
            var opts=new Dictionary<string,object>();
            dynamic resp=rpc_execute("login","login",args,opts);
            Console.WriteLine(resp);
        }
    }
}
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

Sample program (.NET):
```console
using System;
using System.IO;
using System.Net;
using System.Text;
using System.Collections.Generic;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace dotnet
{
    class Program
    {
        static string rpc_url="https://staging-backend.tessaract.io/json_rpc";
        static string user_id="15914";
        static string company_id="114";
        static string token="dGVzc19zdGFnaW5nIDE1OTE0|1606649697|14025346adda420c834086ff09d4c27724d1f5b5";

        static dynamic rpc_execute(string model, string method, object[] args, Dictionary<string,object> opts) {
            var req=(HttpWebRequest)WebRequest.Create(rpc_url);
            req.ContentType="application/json";
            req.Method="POST";
            var cookies=new Dictionary<string,object>();
            cookies["user_id"]=user_id;
            cookies["company_id"]=company_id;
            cookies["token"]=token;
            object[] parms={model,method,args,opts,cookies};
            var req_data=new Dictionary<string,object>();
            req_data["id"]=DateTimeOffset.Now.ToUnixTimeSeconds();
            req_data["method"]="execute";
            req_data["params"]=parms;
            string payload=JsonSerializer.Serialize(req_data);
            var payload_bytes=Encoding.ASCII.GetBytes(payload);
            var stream=req.GetRequestStream();
            stream.Write(payload_bytes,0,payload_bytes.Length);
            var resp=(HttpWebResponse)req.GetResponse();
            var reader=new StreamReader(resp.GetResponseStream());
            string result=reader.ReadToEnd();
            var resp_data=JsonSerializer.Deserialize<Dictionary<string,object>>(result);
            var error=resp_data["error"];
            if (error!=null) {
                throw new Exception("Error: "+error);
            }
            return resp_data["result"];
        }

        static void Main()
        {
            string[] cond={};
            string[] fields={"first_name","last_name","email"};
            object[] args={cond,fields};
            var opts=new Dictionary<string,object>();
            dynamic resp=rpc_execute("aln.client","search_read_path",args,opts);
            Console.WriteLine(resp);
        }
    }
}
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
```console
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

Sample program (.NET):
```console
using System;
using System.IO;
using System.Net;
using System.Text;
using System.Collections.Generic;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace dotnet
{
    class Program
    {
        static string rpc_url="https://staging-backend.tessaract.io/json_rpc";
        static string user_id="15914";
        static string company_id="114";
        static string token="dGVzc19zdGFnaW5nIDE1OTE0|1606649697|14025346adda420c834086ff09d4c27724d1f5b5";

        static dynamic rpc_execute(string model, string method, object[] args, Dictionary<string,object> opts) {
            var req=(HttpWebRequest)WebRequest.Create(rpc_url);
            req.ContentType="application/json";
            req.Method="POST";
            var cookies=new Dictionary<string,object>();
            cookies["user_id"]=user_id;
            cookies["company_id"]=company_id;
            cookies["token"]=token;
            object[] parms={model,method,args,opts,cookies};
            var req_data=new Dictionary<string,object>();
            req_data["id"]=DateTimeOffset.Now.ToUnixTimeSeconds();
            req_data["method"]="execute";
            req_data["params"]=parms;
            string payload=JsonSerializer.Serialize(req_data);
            var payload_bytes=Encoding.ASCII.GetBytes(payload);
            var stream=req.GetRequestStream();
            stream.Write(payload_bytes,0,payload_bytes.Length);
            var resp=(HttpWebResponse)req.GetResponse();
            var reader=new StreamReader(resp.GetResponseStream());
            string result=reader.ReadToEnd();
            var resp_data=JsonSerializer.Deserialize<Dictionary<string,object>>(result);
            var error=resp_data["error"];
            if (error!=null) {
                throw new Exception("Error: "+error);
            }
            return resp_data["result"];
        }

        static void Main()
        {
            string[] cond={"client_id","=","197258"};
            string[] fields={"number","date","client_id.full_name","job_type_id.name","facts"};
            object[] args={cond,fields};
            var opts=new Dictionary<string,object>();
            dynamic resp=rpc_execute("aln.job","search_read_path",args,opts);
            Console.WriteLine(resp);
        }
    }
}
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

Sample program:
```console
using System;
using System.IO;
using System.Net;
using System.Text;
using System.Collections.Generic;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace dotnet
{
    class Program
    {
        static string rpc_url="https://staging-backend.tessaract.io/json_rpc";
        static string user_id="15914";
        static string company_id="114";
        static string token="dGVzc19zdGFnaW5nIDE1OTE0|1606649697|14025346adda420c834086ff09d4c27724d1f5b5";

        static dynamic rpc_execute(string model, string method, object[] args, Dictionary<string,object> opts) {
            var req=(HttpWebRequest)WebRequest.Create(rpc_url);
            req.ContentType="application/json";
            req.Method="POST";
            var cookies=new Dictionary<string,object>();
            cookies["user_id"]=user_id;
            cookies["company_id"]=company_id;
            cookies["token"]=token;
            object[] parms={model,method,args,opts,cookies};
            var req_data=new Dictionary<string,object>();
            req_data["id"]=DateTimeOffset.Now.ToUnixTimeSeconds();
            req_data["method"]="execute";
            req_data["params"]=parms;
            string payload=JsonSerializer.Serialize(req_data);
            var payload_bytes=Encoding.ASCII.GetBytes(payload);
            var stream=req.GetRequestStream();
            stream.Write(payload_bytes,0,payload_bytes.Length);
            var resp=(HttpWebResponse)req.GetResponse();
            var reader=new StreamReader(resp.GetResponseStream());
            string result=reader.ReadToEnd();
            var resp_data=JsonSerializer.Deserialize<Dictionary<string,object>>(result);
            var error=resp_data["error"];
            if (error!=null) {
                throw new Exception("Error: "+error);
            }
            return resp_data["result"];
        }

        static void Main()
        {
            string[] ids={"262209"};
            string[] fields={"number","date","client_id.full_name","job_type_id.name","facts","documents.title"};
            object[] args={ids,fields};
            var opts=new Dictionary<string,object>();
            dynamic resp=rpc_execute("aln.job","read_path",args,opts);
            Console.WriteLine(resp);
        }
    }
}
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

Sample program (.NET):
```console
using System;
using System.IO;
using System.Net;
using System.Text;
using System.Collections.Generic;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace dotnet
{
    class Program
    {
        static string rpc_url="https://staging-backend.tessaract.io/json_rpc";
        static string user_id="15914";
        static string company_id="114";
        static string token="dGVzc19zdGFnaW5nIDE1OTE0|1606649697|14025346adda420c834086ff09d4c27724d1f5b5";

        static dynamic rpc_execute(string model, string method, object[] args, Dictionary<string,object> opts) {
            var req=(HttpWebRequest)WebRequest.Create(rpc_url);
            req.ContentType="application/json";
            req.Method="POST";
            var cookies=new Dictionary<string,object>();
            cookies["user_id"]=user_id;
            cookies["company_id"]=company_id;
            cookies["token"]=token;
            object[] parms={model,method,args,opts,cookies};
            var req_data=new Dictionary<string,object>();
            req_data["id"]=DateTimeOffset.Now.ToUnixTimeSeconds();
            req_data["method"]="execute";
            req_data["params"]=parms;
            string payload=JsonSerializer.Serialize(req_data);
            var payload_bytes=Encoding.ASCII.GetBytes(payload);
            var stream=req.GetRequestStream();
            stream.Write(payload_bytes,0,payload_bytes.Length);
            var resp=(HttpWebResponse)req.GetResponse();
            var reader=new StreamReader(resp.GetResponseStream());
            string result=reader.ReadToEnd();
            var resp_data=JsonSerializer.Deserialize<Dictionary<string,object>>(result);
            var error=resp_data["error"];
            if (error!=null) {
                throw new Exception("Error: "+error);
            }
            return resp_data["result"];
        }

        static void Main()
        {
            var vals=new Dictionary<string,object>();
            vals["client_id"]="197257";
            vals["job_type_id"]="2927";
            vals["facts"]="This is a test case";
            object[] args={vals};
            var opts=new Dictionary<string,object>();
            dynamic resp=rpc_execute("aln.job","create",args,opts);
            Console.WriteLine(resp);
        }
    }
}
```

### 6. Update existing cases

Sample request:
```json
{
  "id": 1603770625657,
  "method": "execute",
  "params": [
      "aln.job",
      "write",
      [
        [262211],
        {
            "facts": "This is an updated test case"
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

### 7. Get case list with pagination

Sample request:
```json
{
  "id": 1603770625657,
  "method": "execute",
  "params": [
      "aln.job",
      "search_read_path",
      [
        [],
        ["number"]
      ],
      {
        "offset": 0,
        "limit": 20,
        "count": true
      },
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
    "result": 
    [
        [
            {
                "number": "C-0012",
                "id": 266787
            },
            ...
        ],
        1000
    ]
}
```

### 8. Search cases by number

Sample request:
```json
{
  "id": 1603770625657,
  "method": "execute",
  "params": [
      "aln.job",
      "search_read_path",
      [
        [[["number","like","0012"]],
        ["number"]
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
    "result": 
    [
            {
                "number": "C-0012",
                "id": 266787
            },
            ...
    ]
}
```
