package com.shinhan.travelTogether.coupon;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CouponService {
	
	@Autowired
	CouponDAO couponDao;
	
	public List<UserCouponDTO> selectAllUserCoupon(int userId){
		return couponDao.selectAllUserCoupon(userId);
	}
	
	public List<AdminCouponDTO> selectAllAdminCoupon() {
		return couponDao.selectAllAdminCoupon();
	}
	
	public List<AdminCouponDTO> selectAdminCouponByOption(int option) {
		return couponDao.selectAdminCouponByOption(option);
	} 
	
	public int insertAdminCoupon(AdminCouponDTO adminCouponDto) {
		return couponDao.insertAdminCoupon(adminCouponDto);
	}
	
	public int deleteAdminCoupon(int coupon_id) {
		return couponDao.deleteAdminCoupon(coupon_id);
	}
	
	public int updateAdminCoupon(AdminCouponDTO adminCouponDto) {
		return couponDao.updateAdminCoupon(adminCouponDto);
	}
}
