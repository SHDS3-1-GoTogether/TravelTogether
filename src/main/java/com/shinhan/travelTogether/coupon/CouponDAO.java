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
	
	// ����� ���� ���� ����Ʈ ��ȸ
	public List<UserCouponDTO> selectAllUserCoupon(int userId){
		List<UserCouponDTO> couponlist = sqlSession.selectList(namespace+"selectAllUserCoupon", userId);
		logger.info("<selectAllUserCoupon> "+couponlist.size()+"�� ���� ��ȸ");
		return couponlist;
	}
	
	public List<AdminCouponDTO> selectAllAdminCoupon() {
		List<AdminCouponDTO> couponlist = sqlSession.selectList(namespace+"selectAllAdminCoupon");
		logger.info("<selectAllAdminCoupon> "+couponlist.size()+"�� ���� ��ȸ");
		return couponlist;
	}
	
	public List<AdminCouponDTO> selectAdminCouponByOption(int option) {
		List<AdminCouponDTO> couponlist = sqlSession.selectList(namespace+"selectAdminCouponByOption", option);
		logger.info("<selectAdminCouponByOption> "+couponlist.size()+"�� ���� ��ȸ");
		return couponlist;
	}
	
	public int insertAdminCoupon(AdminCouponDTO adminCouponDto) {
		int result = sqlSession.insert(namespace+"insertAdminCoupon", adminCouponDto);
		logger.info(result==1 ? "** ������� ���� **" : "** ������� ���� **");
		return result;
	}
	
	public int deleteAdminCoupon(int coupon_id) {
		int result = sqlSession.delete(namespace+"deleteAdminCoupon", coupon_id);
		logger.info(result==1 ? "** �������� ���� **" : "** �������� ���� **");
		return result;
	}
}
