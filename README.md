# AnyJSON

1. 使用

``` Swift
let json1 = """
{
  "sites": {
    "id": "1",
    "name": "菜鸟教程",
    "url": "www.runoob.com",
    "lang": {"en": "false", "zn": "true"},
    "address": [
      {"city": "beijing", "province": "null"},
      {"city": "chengdu", "province": "sichuan"}
    ]
  }
}
"""

let data = json1.data(using: .utf8)
let value = try JSONDecoder().decode(AnyJSON.self, from: data!)

print(value.sites.id.intValue)
output: 1

print(value.sites.name.stringValue)
output: 菜鸟教程
```

