package com.spz.dao;

import java.util.List;

import com.spz.entity.Netfollows;

public interface NetfollowsMapper {
	
	/**
	 * �鿴����
	 * @param net
	 * @return
	 */
		List<Netfollows> selectNet(Netfollows net);
		/**
		 * �鿴��������
		 * @param net
		 * @return
		 */
		Integer selectNetcount(Netfollows net);
}
