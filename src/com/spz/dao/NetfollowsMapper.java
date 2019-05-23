package com.spz.dao;

import java.util.List;

import com.spz.entity.Netfollows;

public interface NetfollowsMapper {
	
	/**
	 * 查看跟踪
	 * @param net
	 * @return
	 */
		List<Netfollows> selectNet(Netfollows net);
		/**
		 * 查看跟踪总数
		 * @param net
		 * @return
		 */
		Integer selectNetcount(Netfollows net);
}
