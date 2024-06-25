package com.shinhan.travelTogether.photo;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("photoDAO")
public class PhotoDAO {

	@Autowired
	SqlSession sqlSession;
	String namespace = "com.shinhan.travelTogether.photo.";
	
	public int insertPhoto(PhotoDTO photo) {
		int result = sqlSession.insert(namespace + "insertPhoto", photo);
		return result;
	}
	
	public List<String> selectUserPhoto(int funding_id) {
		return sqlSession.selectList(namespace + "selectUserPhoto", funding_id);
	}
	
	public List<HashMap<Integer, String>> selectMainPhoto() {
		return sqlSession.selectList(namespace + "selectMainPhoto");
	}
	
}
