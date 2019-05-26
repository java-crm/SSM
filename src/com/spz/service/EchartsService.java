package com.spz.service;

import java.util.List;

import com.spz.entity.Echarts;
import com.spz.entity.Student;

public interface EchartsService {
	/**
	 * ��ѯ��¼�߽�����ǰ����ȥ�����û��ķ���ѧ������
	 * @param student ��������������������ѯʦ¼���ѧ������ѯʦ�ѽɷѷ����ѧ����������ѯʦ�����ѧ��δ�ɹ���ѧ������
	 * @return
	 */
	List<Echarts> selectEcharts(Student student);
	
	/**
	 * ͨ��u_idȥ�õ���¼������ѯʦ����������ѯʦ
	 * @param u_id
	 * @return
	 */
	Integer selectRolesEcharts(Integer u_id);
}
