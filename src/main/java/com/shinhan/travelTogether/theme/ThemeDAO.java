package com.shinhan.travelTogether.theme;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shinhan.travelTogether.photo.PhotoDTO;

@Repository("themeDAO")
public class ThemeDAO {

	@Autowired
	SqlSession sqlSession;
	String namespace = "com.shinhan.travelTogether.theme.";
	
	public int insertFundingTheme(FundingThemeDTO theme) {
		int result = sqlSession.insert(namespace + "insertFundingTheme", theme);
		return result;
	}
	
	public List<ThemeDTO>  selectTheme() {
		return sqlSession.selectList(namespace + "selectTheme");
	}

	
}
