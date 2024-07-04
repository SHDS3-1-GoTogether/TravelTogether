package com.shinhan.travelTogether.theme;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter @Setter @ToString
public class FundingThemeDTO {
	private int funding_theme_id;
	private int funding_id;
	private int theme_id;
}
