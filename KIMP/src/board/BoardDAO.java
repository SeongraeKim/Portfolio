package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {

	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	
	private Connection getConnection() throws Exception{						// KIM_DB DB���� getConnection()�޼���
		
		Connection con = null;
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/kim_db");
		con = ds.getConnection();
		
		return con;
	}
	
	public void reInsertBoard(BoardDTO dto){									// ��� �ۼ� reInsertBoard()�޼���
		
		int num = 0;
		
		try {
			
			con = getConnection();
			sql = "select max(num) from board"; // ���� �ֱٿ� �ۼ��� �۹�ȣ ��ȸ
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				
				num = rs.getInt(1) + 1;	// �߰��� �亯���� ��ȣ

			}else{
				
				num = 1;
			}
			
			sql = "update board set re_seq = re_seq + 1 where re_ref = ? and re_seq > ?";	// ��� ������ġ
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, dto.getRe_ref());			// �θ���� �׷��ȣ
			pstmt.setInt(2, dto.getRe_seq());			// �θ���� �� �Է� ����
			
			pstmt.executeUpdate();
			
			sql = "insert into board values(?,?,?,?,?,?,?,?,?,now(),?)";					// �亯�� �ۼ�
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getPasswd());
			pstmt.setString(4, dto.getSubject());
			pstmt.setString(5, dto.getContent());
			pstmt.setInt(6,dto.getRe_ref());			// �θ�� �׷��ȣ re_ref���� ���
			pstmt.setInt(7, dto.getRe_lev() + 1); 		// �θ���� re_lev�� + 1�� ���� ���
			pstmt.setInt(8, dto.getRe_seq() + 1);
			pstmt.setInt(9, 0);
			pstmt.setString(10, dto.getIp());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("reInsertBoard() �޼��� ���� ����: " + e);
		} finally { // �ڿ�����
			if(rs!=null) 	try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null) try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null) 	try{con.close();}catch(Exception err){err.printStackTrace();}
		}
		
	}
	
	public int deleteBoard(int num, String passwd){								// �Խñ� ���� deleteBoard()�޼���
		
		int check = 0;
		
		try {
			
			con = getConnection();
			sql = "select passwd from board where num = ?";	// �Է��� ��й�ȣ�� DB�� ����� ���� ��ġ�ϴ��� ��ȸ
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				
				if(passwd.equals(rs.getString("passwd"))){
					
					check = 1;
					
					sql = "delete from board where num = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
										
					pstmt.executeUpdate();
					
					// �Խñ� ���� �� �ֽű۹�ȣ�� num�� ����(Syntax Error �߻�)
					sql = "update board set num = max(num)";
					pstmt = con.prepareStatement(sql);
					
					pstmt.executeUpdate();
					
				}else{
					
					check = 0;
				}
			}
			
		} catch (Exception e) {
			// System.out.println("deleteBoard()�޼��� ���� ����: " + e);
		} finally { // �ڿ�����
			if(rs!=null) 	try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null) try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null) 	try{con.close();}catch(Exception err){err.printStackTrace();}
		}
		
		return check;
	}
	
	public int updateBoard(BoardDTO dto){										// �Խñ� ���� updateBoard()�޼���
		
		int check = 0;
	
		try {
			
			con = getConnection();
			sql = "select passwd from board where num = ?";	// �Է��� ��й�ȣ�� DB�� ����� ���� ��ġ�ϴ��� ��ȸ
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, dto.getNum());
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				
				if(dto.getPasswd().equals(rs.getString("passwd"))){
					
					check = 1;
					sql = "update board set subject = ?, content = ? where num = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, dto.getSubject());
					pstmt.setString(2, dto.getContent());
					pstmt.setInt(3, dto.getNum());
					
					pstmt.executeUpdate();
					
				}else{
					
					check = 0;
				}
			}
			
		} catch (Exception e) {
			System.out.println("updateBoard()�޼��� ���� ����: " + e);
		} finally { // �ڿ�����
			if(rs!=null) 	try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null) try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null) 	try{con.close();}catch(Exception err){err.printStackTrace();}
		}
		
		return check;
	}
	
	public void insertBoard(BoardDTO dto){										// �Խñ� �ۼ� insertBoard()�޼���
		
		int num = 0; // �߰��� �۹�ȣ ������ ����
		
		try {
			
			con = getConnection();
			sql = "select max(num) from board";	// ���� �ֱٿ� �ۼ��� �۹�ȣ ��ȸ
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				num = rs.getInt(1) + 1;		// num = ���� �ֱٿ� �ۼ��� �۹�ȣ + 1
			}else{
				num = 1;					// ��ȸ����� ���°�� 1�� num�� ����
			}
			
			sql = "insert into board"
					+ "(num, name, passwd, subject, content, "
					+ "re_ref, re_lev, re_seq, readcount, date, ip) "
					+ "values(?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num); 					// �۹�ȣ
			pstmt.setString(2, dto.getName());		// �ۼ��� �̸�
			pstmt.setString(3, dto.getPasswd());	// ��й�ȣ
			pstmt.setString(4, dto.getSubject());	// ������
			pstmt.setString(5, dto.getContent());	// �۳���
			pstmt.setInt(6, num);					// num �ֱ۹�ȣ ���� == re_ref �׷��ȣ
			pstmt.setInt(7, 0);						// ������ �鿩���� ������ re_lev
			pstmt.setInt(8, 0);						// �� ���� re_seq
			pstmt.setInt(9, 0);					// ��ȸ��
			pstmt.setTimestamp(10, dto.getDate());	// �� �ۼ���¥
			pstmt.setString(11, dto.getIp()); 		// �ۼ��� IP�ּ�
			
			pstmt.executeUpdate();

			
		} catch (Exception e) {
			System.out.println("insertBoard()�޼��� ���� ����: " + e);
		} finally { // �ڿ�����
			if(rs!=null) 	try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null) try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null) 	try{con.close();}catch(Exception err){err.printStackTrace();}
		}
	}
	
	public BoardDTO getBoard(int num){											// �Խñ� �������� getBoard()�޼���
		
		BoardDTO dto = null;
		
		try {
			
			con = getConnection();
			sql = "select * from board where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()){	// �ش� ��ȣ�� �Խñ��� �����ϸ�
				
				dto = new BoardDTO(); // ������ ��ü ����
				
				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setPasswd(rs.getString("passwd"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setRe_ref(rs.getInt("re_ref"));
				dto.setRe_lev(rs.getInt("re_lev"));
				dto.setRe_seq(rs.getInt("re_seq"));
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
			sql = "update board set readcount = readcount + 1 where num = ?";
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
	
	public List<BoardDTO> getBoardlist(int startRow, int pageSize){				// �Խñ� ����Ʈ �������� getBoardlist()�޼���
		
		List<BoardDTO> boardlist = new ArrayList<BoardDTO>();
		
		try {
			
			con = getConnection();
			sql = "select * from board order by re_ref desc, re_seq asc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				
				BoardDTO dto = new BoardDTO();
				
				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setPasswd(rs.getString("passwd"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setRe_ref(rs.getInt("re_ref"));
				dto.setRe_lev(rs.getInt("re_lev"));
				dto.setRe_seq(rs.getInt("re_seq"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setDate(rs.getTimestamp("date"));
				dto.setIp(rs.getString("ip"));
				
				boardlist.add(dto);
			}
			
		} catch (Exception e) {
			System.out.println("getBoardlist()�޼��� ���� ����: " + e);
		} finally { // �ڿ�����
			if(rs!=null) 	try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null) try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null) 	try{con.close();}catch(Exception err){err.printStackTrace();}
		}
		
		return boardlist;
	}
	
	public int getBoardCount(){													// ��ü �Խñ� ���� getBoardCount()�޼���
		
		int count = 0;
		
		try {
			
			con = getConnection();
			sql = "select count(*) from board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				count = rs.getInt(1);	// �˻��� �� ����
			}
			
		} catch (Exception e) {
			System.out.println("getBoardCount()�޼��� ���� ����: " + e);
		} finally { // �ڿ�����
			if(rs!=null) 	try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null) try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null) 	try{con.close();}catch(Exception err){err.printStackTrace();}
		}
		
		return count;
	}
}

















