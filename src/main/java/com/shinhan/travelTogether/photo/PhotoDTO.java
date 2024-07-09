package com.shinhan.travelTogether.photo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter @Setter @ToString
public class PhotoDTO {
	private int photo_id;
	private int purpose;
	private String photo_name;
	private Integer funding_id;
	private Integer review_id;
}
