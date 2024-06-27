package com.shinhan.travelTogether.theme;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service
public class ThemeService {
	@Autowired
	@Qualifier("themeDAO")
	ThemeDAO themeDAO;
	
	public List<ThemeDTO> selectTheme() {
		return themeDAO.selectTheme();
	}
	
	public int insertFundingTheme(FundingThemeDTO theme) {
		return themeDAO.insertFundingTheme(theme);
	}
}
