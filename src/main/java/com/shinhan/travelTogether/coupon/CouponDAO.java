package com.shinhan.travelTogether.coupon;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CouponDAO {
	@Autowired
	SqlSession sqlSession;
	
	Logger logger = LoggerFactory.getLogger(CouponDAO.class);
	String namespace = "com.shinhan.travelTogether.coupon.";
	
	// 사용자 보유 쿠폰 리스트 조회
	public List<UserCouponDTO> selectAllUserCoupon(int userId){
		List<UserCouponDTO> couponlist = sqlSession.selectList(namespace+"selectAllUserCoupon", userId);
		logger.info("<selectAllUserCoupon> "+couponlist.size()+"건 쿠폰 조회");
		return couponlist;
	}
	
	public List<AdminCouponDTO> selectAllAdminCoupon() {
		List<AdminCouponDTO> couponlist = sqlSession.selectList(namespace+"selectAllAdminCoupon");
		logger.info("<selectAllAdminCoupon> "+couponlist.size()+"건 쿠폰 조회");
		return couponlist;
	}
	
	public List<AdminCouponDTO> selectAdminCouponByOption(int option) {
		List<AdminCouponDTO> couponlist = sqlSession.selectList(namespace+"selectAdminCouponByOption", option);
		logger.info("<selectAdminCouponByOption> "+couponlist.size()+"건 쿠폰 조회");
		return couponlist;
	}
	
	public int insertAdminCoupon(AdminCouponDTO adminCouponDto) {
		int result = sqlSession.insert(namespace+"insertAdminCoupon", adminCouponDto);
		logger.info(result==1 ? "** 쿠폰등록 성공 **" : "** 쿠폰등록 실패 **");
		return result;
	}
	
	public int deleteAdminCoupon(int coupon_id) {
		int result = sqlSession.delete(namespace+"deleteAdminCoupon", coupon_id);
		logger.info(result==1 ? "** 쿠폰삭제 성공 **" : "** 쿠폰삭제 실패 **");
		return result;
	}
}
