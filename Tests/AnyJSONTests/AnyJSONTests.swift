import XCTest
@testable import AnyJSON

final class AnyJSONTests: XCTestCase {
    func testJSON1() throws {
        let data = json1.data(using: .utf8)
        let value = try JSONDecoder().decode(AnyJSON.self, from: data!)
        
        XCTAssertTrue(value.sites.id.intValue == 1)
        XCTAssertTrue(value.sites.name.stringValue == "菜鸟教程")
        XCTAssertTrue(value["sites"]["name"].stringValue == "菜鸟教程")
        XCTAssertNil(value.sites.address[0].province.value)
    }
    
    func testJSON2() throws {
        let data = json2.data(using: .utf8)
        let value = try JSONDecoder().decode(AnyJSON.self, from: data!)
        
        XCTAssertTrue(value.resultcode.intValue == 200)
        XCTAssertTrue(value.result.sk.wind_direction.stringValue == "西南风")
    }
}





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



let json2 = """
{
    "resultcode": "200",
    "reason": "successed!",
    "result": {
        "sk": {
            "temp": "24",
            "wind_direction": "西南风",
            "wind_strength": "2级",
            "humidity": "51%",
            "time": "10:11"
        },
        "today": {
            "temperature": "16℃~27℃",
            "weather": "阴转多云",
            "weather_id": {
                "fa": "02",
                "fb": "01"
            },
            "wind": "西南风3-4 级",
            "week": "星期四",
            "city": "滨州",
            "date_y": "2015年06月04日",
            "dressing_index": "舒适",
            "dressing_advice": "建议着长袖T恤、衬衫加单裤等服装。年老体弱者宜着针织长袖衬衫、马甲和长裤。",
            "uv_index": "最弱",
            "comfort_index": "",
            "wash_index": "较适宜",
            "travel_index": "",
            "exercise_index": "较适宜",
            "drying_index": ""
        },
        "future": [{
            "temperature": "16℃~27℃",
            "weather": "阴转多云",
            "weather_id": {
                "fa": "02",
                "fb": "01"
            },
            "wind": "西南风3-4 级",
            "week": "星期四",
            "date": "20150604"
        }, {
            "temperature": "20℃~32℃",
            "weather": "多云转晴",
            "weather_id": {
                "fa": "01",
                "fb": "00"
            },
            "wind": "西风3-4 级",
            "week": "星期五",
            "date": "20150605"
        }]
    },
    "error_code": 0
}
"""
