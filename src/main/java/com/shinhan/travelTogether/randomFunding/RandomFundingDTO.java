package com.shinhan.travelTogether.randomFunding;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class RandomFundingDTO {

	private String departure;

	private String arrival;

	private Integer priceLow;

	private Integer priceHigh;

	private List<String> themes;
}
