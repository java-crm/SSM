package com.spz.service;

import com.spz.entity.Userchecks;

public interface UserchecksService {
	/**
	 * ��ѯ�û��Ƿ��Ѵ�
	 * @param u_id
	 * @return
	 */
	Userchecks selectUserchecks(Integer u_id);
	/**
	 * �޸��û����״̬�����°಻���Զ�ִ�д򿨲������ǣ����°�ʱ���޸�״̬Ϊ����°�ʱ�䣩
	 * us_isCancel�޸�Ϊ��֮�� ����ͳһ�ĵ��°�ʱ��һ��򿨣���ҪԱ���ֶ��򿨣����Ƴ���¼ʱ�ж��û��Ƿ�ǩ�ˣ�
	 * @param userchecks
	 * @return
	 */
	Integer updateUserchecks(Userchecks userchecks);
	
	/**
	 * ÿ�����һ��Ա��ͬʱ��ǩ�������һ����Ա����ǩ������
	 * @param userchecks
	 * @return
	 */
	Integer insertUserchecks(Userchecks userchecks);
	
	
	
	/*������*/
	/**
	 * ���ݽ�ɫ��ѯȫ����ѯʦ��������ѯʦ��Ա��ǩ����
	 * @return
	 */
	String selectUserCheckAll(Userchecks userchecks);
	/**
	 * ����ǩ��or����ǩ��
	 * @param userchecks
	 * @return
	 */
	Integer updateUserchecksPL(Userchecks userchecks);
	
	/**
	 * �ӽ�ɫ���ѯԱ��id=10 or id=9��������ѯʦ��������ѯʦ 
	 * @return
	 */
	String selectUsersByYuanGong();
}
