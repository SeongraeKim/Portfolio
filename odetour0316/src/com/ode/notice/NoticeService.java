package com.ode.notice;

import java.util.List;

public class NoticeService {

	NoticeDAO noticeDAO=new NoticeDAO();
	
	public void addNotice(NoticeVO noticeVO){
		
		noticeDAO.newinsertNotice(noticeVO);		
	}

	public List<NoticeVO> listNotice(int startrow) {
		
		List Noticelist=noticeDAO.selectNotice(startrow);		
		return Noticelist;
	}


	public NoticeVO viewNotice(int idx) {
			
		return noticeDAO.viewNotice(idx);		
	}


	public void deleteNotice(int idx) {
		
		noticeDAO.deleteNotice(idx);		
	}


	public int getlistCount() {
		
		return noticeDAO.getlistCount();
	}

	public int updateCount(int idx) {
		
		return noticeDAO.updateReadCount(idx);
	}

}
