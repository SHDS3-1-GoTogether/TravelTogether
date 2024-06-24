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
	int photo_id;
	int purpose;
	String photo_name;
	Integer funding_id;
	Integer review_id;
}
