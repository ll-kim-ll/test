package com.wellrising.uds.www.sample.chart.google.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

/**
 * Handles requests for the application home page.
 */
@Service
public class GoogleChartService {
	private static final Logger log = LoggerFactory.getLogger(GoogleChartService.class);

    public Map getMapChartData() {//제이슨 오브젝트를 리턴하는 것
        // getChartData메소드를 호출하면
		List<Map> result = getData();

        //리턴할 json 객체
		Map data = new HashMap<>(); //{}

        //json의 칼럼 객체
        Map col1 = new HashMap<>();
        Map col2 = new HashMap<>();

        //json 배열 객체, 배열에 저장할때는 JSONArray()를 사용
        List title = new ArrayList<>();
        col1.put("label","상품명");
        col1.put("type", "string");
        col2.put("label", "금액");
        col2.put("type", "number");

        //테이블행에 컬럼 추가
        title.add(col1);
        title.add(col2);


        data.put("cols", title);


        List body = new ArrayList<>();
        for (Map tData : result) {

        	Map name = new HashMap<>();
            name.put("v", tData.get("name"));

            Map money = new HashMap<>();
            money.put("v", tData.get("vData"));

            List row = new ArrayList<>();
            row.add(name);
            row.add(money);

            Map cell = new HashMap<>();
            cell.put("c", row);
            body.add(cell);

        }
        data.put("rows", body);

        return data;
    }


    public JSONObject getChartData() {//제이슨 오브젝트를 리턴하는 것
        // getChartData메소드를 호출하면
        //db에서 리스트 받아오고, 받아온걸로 json형식으로 만들어서 리턴을 해주게 된다.
    	List<Map> items = getData();

        //리턴할 json 객체
        JSONObject data = new JSONObject(); //{}

        //json의 칼럼 객체
        JSONObject col1 = new JSONObject();
        JSONObject col2 = new JSONObject();

        //json 배열 객체, 배열에 저장할때는 JSONArray()를 사용
        JSONArray title = new JSONArray();
        col1.put("label","상품명"); //col1에 자료를 저장 ("필드이름","자료형")
        col1.put("type", "string");
        col2.put("label", "금액");
        col2.put("type", "number");

        //테이블행에 컬럼 추가
        title.add(col1);
        title.add(col2);

        //json 객체에 타이틀행 추가
        data.put("cols", title);//제이슨을 넘김
        //이런형식으로 추가가된다. {"cols" : [{"label" : "상품명","type":"string"}
        //,{"label" : "금액", "type" : "number"}]}

        JSONArray body = new JSONArray(); //json 배열을 사용하기 위해 객체를 생성
        for (Map tData : items) { //items에 저장된 값을 Map로 반복문을 돌려서 하나씩 저장한다.

            JSONObject name = new JSONObject(); //json오브젝트 객체를 생성
            name.put("v", tData.get("name")); //name변수에 dto에 저장된 상품의 이름을 v라고 저장한다.

            JSONObject vData = new JSONObject(); //json오브젝트 객체를 생성
            vData.put("v", tData.get("vData")); //name변수에 dto에 저장된 금액을 v라고 저장한다.

            JSONArray row = new JSONArray(); //json 배열 객체 생성 (위에서 저장한 변수를 칼럼에 저장하기위해)
            row.add(name); //name을 row에 저장 (테이블의 행)
            row.add(vData); //name을 row에 저장 (테이블의 행)

            JSONObject cell = new JSONObject();
            cell.put("c", row); //cell 2개를 합쳐서 "c"라는 이름으로 추가
            body.add(cell); //레코드 1개 추가

        }
        data.put("rows", body); //data에 body를 저장하고 이름을 rows라고 한다.

        return data; //이 데이터가 넘어가면 json형식으로 넘어가게되서 json이 만들어지게 된다.
    }

    private List getData() {
		List<Map> result = new ArrayList<Map>();
		Map<String, Object> data1 = new HashMap<String, Object>();
		Map<String, Object> data2 = new HashMap<String, Object>();
		Map<String, Object> data3 = new HashMap<String, Object>();
		Map<String, Object> data4 = new HashMap<String, Object>();
		Map<String, Object> data5 = new HashMap<String, Object>();

		data1.put("name", "Mushrooms");
		data1.put("vData", 5);
		result.add(data1);

		data2.put("name", "Onions");
		data2.put("vData", 6);
		result.add(data2);

		data3.put("name", "Olives");
		data3.put("vData", 7);
		result.add(data3);

		data4.put("name", "Zucchini");
		data4.put("vData", 4);
		result.add(data1);

		data5.put("name", "Pepperoni");
		data5.put("vData", 1);
		result.add(data5);

		return result;
    }
}
