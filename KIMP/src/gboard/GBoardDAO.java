package gboard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import board.BoardDTO;

public class GBoardDAO {
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";

	private Connection getConnection() throws Exception{						// KIM_DB DB���� �޼���
		
		Connection con = null;
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/kim_db");
		con = ds.getConnection();
		
		return con;
	}
	
	public int deleteGBoard(int num, String passwd){							// ������ �Խñ� ���� deleteGBoard()�޼���
		
		int check = 0;
		
		try {
			
			con = getConnection();
			sql = "select passwd from gboard where num = ?";	// �Է��� ��й�ȣ�� DB�� ����� ���� ��ġ�ϴ��� ��ȸ
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				
				if(passwd.equals(rs.getString("passwd"))){
					
					check = 1;
					sql = "delete from gboard where num = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
										
					pstmt.executeUpdate();
					
					// �Խñ� ���� �� �ֽű۹�ȣ�� num�� ����(Syntax Error �߻�)
					sql = "update gboard set num = max(num)";
					pstmt = con.prepareStatement(sql);
					
					pstmt.executeUpdate();
					
				}else{
					
					check = 0;
				}
			}
			
		} catch (Exception e) {
			// System.out.println("deleteGBoard()�޼��� ���� ����: " + e);
		} finally { // �ڿ�����
			if(rs!=null) 	try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null) try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null) 	try{con.close();}catch(Exception err){err.printStackTrace();}
		}
		
		return check;
	}
	
	public int updateGBoard(GBoardDTO dto){										// ������ �Խñ� ���� updateGBoard()�޼���
		
		int check = 0;
	
		try {
			
			con = getConnection();
			sql = "select passwd from gboard where num = ?";	// �Է��� ��й�ȣ�� DB�� ����� ���� ��ġ�ϴ��� ��ȸ
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, dto.getNum());
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				
				if(dto.getPasswd().equals(rs.getString("passwd"))){
					
					check = 1;
					
					sql = "update gboard set subject = ?, file = ?, content = ? where num = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, dto.getSubject());
					pstmt.setString(2, dto.getFile());
					pstmt.setString(3, dto.getContent());
					pstmt.setInt(4, dto.getNum());
					
					pstmt.executeUpdate();
					
				}else{
					
					check = 0;
				}
			}
		} catch (Exception e) {
			System.out.println("updateGBoard()�޼��� ���� ����: " + e);
		} finally { // �ڿ�����
			if(rs!=null) 	try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null) try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null) 	try{con.close();}catch(Exception err){err.printStackTrace();}
		}
		
		return check;
	}
	
	public void insertGBoard(GBoardDTO dto){										// ������ �Խñ� �ۼ� insertGBoard()�޼���
		
		int num = 0; // �߰��� �۹�ȣ ������ ����
		
		try {
			
			con = getConnection();
			sql = "select max(num) from gboard";	// ���� �ֱٿ� �ۼ��� �۹�ȣ ��ȸ
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				num = rs.getInt(1) + 1;			// num = ���� �ֱٿ� �ۼ��� �۹�ȣ + 1
			}else{
				num = 1;						// ��ȸ����� ���°�� 1�� num�� ����
			}
			
			sql = "insert into gboard"
					+ "(num, name, passwd, subject, content, file, readcount, date, ip) "
					+ "values(?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num); 					// �۹�ȣ
			pstmt.setString(2, dto.getName());		// �ۼ��� �̸�
			pstmt.setString(3, dto.getPasswd());	// ��й�ȣ
			pstmt.setString(4, dto.getSubject());	// ������
			pstmt.setString(5, dto.getContent());	// �۳���
			pstmt.setString(6, dto.getFile());		// ���ε��� ���ϸ�
			pstmt.setInt(7, 0);						// ��ȸ��
			pstmt.setTimestamp(8, dto.getDate());	// �� �ۼ���¥
			pstmt.setString(9, dto.getIp()); 		// �ۼ��� IP�ּ�
			
			pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("insertGBoard()�޼��� ���� ����: " + e);
		} finally { // �ڿ�����
			if(rs!=null) 	try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null) try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null) 	try{con.close();}catch(Exception err){err.printStackTrace();}
		}
	}
	
	public GBoardDTO getGBoard(int num){											// ������ �Խñ� �������� getGBoard()�޼���
		
		GBoardDTO dto = null;
		
		try {
			
			con = getConnection();
			sql = "select * from gboard where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()){	// �ش� ��ȣ�� �Խñ��� �����ϸ�
				
				dto = new GBoardDTO(); // ������ ��ü ����
				
				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setPasswd(rs.getString("passwd"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setFile(rs.getString("file"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setDate(rs.getTimestamp("date"));
				dto.setIp(rs.getString("ip"));
			}
			
		} catch (Exception e) {
			System.out.println("getBoard() �޼��� ���� ����: " + e);
		} finally { // �ڿ�����
			if(rs!=null) 	try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null) try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null) 	try{con.close();}catch(Exception err){err.printStackTrace();}
		}
		
		return dto;
	}
	
	public void updateReadCount(int num){										// ��ȸ�� ���� updateReadCount()�޼���
		
		try {
			
			con = getConnection();
			sql = "update gboard set readcount = readcount + 1 where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("updateReadCount()�޼��� ���� ����: " + e);
		} finally { // �ڿ�����
			if(pstmt!=null) try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null) 	try{con.close();}catch(Exception err){err.printStackTrace();}
		}
	}
	
	public List<GBoardDTO> getGBoardlist(int startRow, int pageSize){				// ������ ����Ʈ �������� getGBoardlist()�޼���
		
		List<GBoardDTO> gboardlist = new ArrayList<GBoardDTO>();
		
		try {
			
			con = getConnection();
			sql = "select * from gboard order by num desc limit ?, ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				
				GBoardDTO dto = new GBoardDTO();
				
				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setPasswd(rs.getString("passwd"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setFile(rs.getString("file"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setDate(rs.getTimestamp("date"));
				dto.setIp(rs.getString("ip"));
				
				gboardlist.add(dto);
			}
			
		} catch (Exception e) {
			System.out.println("getGBoardlist()�޼��� ���� ����: " + e);
		} finally { // �ڿ�����
			if(rs!=null) 	try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null) try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null) 	try{con.close();}catch(Exception err){err.printStackTrace();}
		}
		
		return gboardlist;
	}
	
	public int getGBoardCount(){													// ������ �Խñ� ���� ��ȸ getGBoardCount()�޼���
		
		int count = 0;
		
		try {
			
			con = getConnection();
			sql = "select count(*) from gboard";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				count = rs.getInt(1);	// �˻��� �� ����
			}
			
		} catch (Exception e) {
			System.out.println("getGBoardCount()�޼��� ���� ����: " + e);
		} finally { // �ڿ�����
			if(rs!=null) 	try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null) try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null) 	try{con.close();}catch(Exception err){err.printStackTrace();}
		}
		
		return count;
	}
}
