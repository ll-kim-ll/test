package com.wellrising.uds.www.sample.tiles;

import java.util.ArrayList;
import java.util.List;

import org.apache.tiles.Attribute;
import org.apache.tiles.AttributeContext;
import org.apache.tiles.preparer.ViewPreparer;
import org.apache.tiles.request.Request;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;

import com.wellrising.uds.www.HomeController;

/**
 * Handles requests for the application home page.
 */
/*@Component  자동으로 첫 글자 소문자로 변경함. */
@Component("menuPreparer")
public class TilesMenuPreparer implements ViewPreparer {
	private static final Logger log = LoggerFactory.getLogger(TilesMenuPreparer.class);

	@Override
	public void execute(Request tilesContext, AttributeContext attributeContext){
		// TODO Auto-generated method stub
        List<TilesMenuItemVo> menus = new ArrayList<TilesMenuItemVo>();
        try {
			menus.add(new TilesMenuItemVo("관리메뉴1", "link1"));
			menus.add(new TilesMenuItemVo("관리메뉴2", "link2"));
			menus.add(new TilesMenuItemVo("관리메뉴3", "link3"));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        /*putAttribute 메서드의 첫 번째 파라미터는 전달할 데이터의 이름이고 두 번째 파라미터는 설정할 데이터
        의 값을 가진 Attribute 객체가 된다. 세 번째 파라미터의 값은 AttributeContext에 추가한 데이터를 전파할지
        의 여부를 설정하는데 이 값이 true로 지정함으로써 JSP에서 설정한 데이터를 사용할 수 있게 된다.
     	*/
        attributeContext.putAttribute("menuList", new Attribute(menus), true);
	}
}
