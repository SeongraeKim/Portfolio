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

	private Connection getConnection() throws Exception{						// KIM_DB DB연결 메서드
		
		Connection con = null;
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/kim_db");
		con = ds.getConnection();
		
		return con;
	}
	
	public int deleteGBoard(int num, String passwd){							// 갤러리 게시글 삭제 deleteGBoard()메서드
		
		int check = 0;
		
		try {
			
			con = getConnection();
			sql = "select passwd from gboard where num = ?";	// 입력한 비밀번호가 DB에 저장된 값과 일치하는지 조회
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
					
					// 게시글 삭제 후 최신글번호를 num에 저장(Syntax Error 발생)
					sql = "update gboard set num = max(num)";
					pstmt = con.prepareStatement(sql);
					
					pstmt.executeUpdate();
					
				}else{
					
					check = 0;
				}
			}
			
		} catch (Exception e) {
			// System.out.println("deleteGBoard()메서드 내부 오류: " + e);
		} finally { // 자원해제
			if(rs!=null) 	try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null) try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null) 	try{con.close();}catch(Exception err){err.printStackTrace();}
		}
		
		return check;
	}
	
	public int updateGBoard(GBoardDTO dto){										// 갤러리 게시글 수정 updateGBoard()메서드
		
		int check = 0;
	
		try {
			
			con = getConnection();
			sql = "select passwd from gboard where num = ?";	// 입력한 비밀번호가 DB에 저장된 값과 일치하는지 조회
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
			System.out.println("updateGBoard()메서드 내부 오류: " + e);
		} finally { // 자원해제
			if(rs!=null) 	try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null) try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null) 	try{con.close();}catch(Exception err){err.printStackTrace();}
		}
		
		return check;
	}
	
	public void insertGBoard(GBoardDTO dto){										// 갤러리 게시글 작성 insertGBoard()메서드
		
		int num = 0; // 추가할 글번호 저장할 변수
		
		try {
			
			con = getConnection();
			sql = "select max(num) from gboard";	// 가장 최근에 작성한 글번호 조회
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				num = rs.getInt(1) + 1;			// num = 가장 최근에 작성한 글번호 + 1
			}else{
				num = 1;						// 조회결과가 없는경우 1을 num에 저장
			}
			
			sql = "insert into gboard"
					+ "(num, name, passwd, subject, content, file, readcount, date, ip) "
					+ "values(?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num); 					// 글번호
			pstmt.setString(2, dto.getName());		// 작성자 이름
			pstmt.setString(3, dto.getPasswd());	// 비밀번호
			pstmt.setString(4, dto.getSubject());	// 글제목
			pstmt.setString(5, dto.getContent());	// 글내용
			pstmt.setString(6, dto.getFile());		// 업로드할 파일명
			pstmt.setInt(7, 0);						// 조회수
			pstmt.setTimestamp(8, dto.getDate());	// 글 작성날짜
			pstmt.setString(9, dto.getIp()); 		// 작성자 IP주소
			
			pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("insertGBoard()메서드 내부 오류: " + e);
		} finally { // 자원해제
			if(rs!=null) 	try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null) try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null) 	try{con.close();}catch(Exception err){err.printStackTrace();}
		}
	}
	
	public GBoardDTO getGBoard(int num){											// 갤러리 게시글 가져오기 getGBoard()메서드
		
		GBoardDTO dto = null;
		
		try {
			
			con = getConnection();
			sql = "select * from gboard where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()){	// 해당 번호의 게시글이 존재하면
				
				dto = new GBoardDTO(); // 저장할 객체 생성
				
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
			System.out.println("getBoard() 메서드 내부 오류: " + e);
		} finally { // 자원해제
			if(rs!=null) 	try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null) try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null) 	try{con.close();}catch(Exception err){err.printStackTrace();}
		}
		
		return dto;
	}
	
	public void updateReadCount(int num){										// 조회수 증가 updateReadCount()메서드
		
		try {
			
			con = getConnection();
			sql = "update gboard set readcount = readcount + 1 where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("updateReadCount()메서드 내부 오류: " + e);
		} finally { // 자원해제
			if(pstmt!=null) try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null) 	try{con.close();}catch(Exception err){err.printStackTrace();}
		}
	}
	
	public List<GBoardDTO> getGBoardlist(int startRow, int pageSize){				// 갤러리 리스트 가져오기 getGBoardlist()메서드
		
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
			System.out.println("getGBoardlist()메서드 내부 오류: " + e);
		} finally { // 자원해제
			if(rs!=null) 	try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null) try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null) 	try{con.close();}catch(Exception err){err.printStackTrace();}
		}
		
		return gboardlist;
	}
	
	public int getGBoardCount(){													// 갤러리 게시글 개수 조회 getGBoardCount()메서드
		
		int count = 0;
		
		try {
			
			con = getConnection();
			sql = "select count(*) from gboard";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				count = rs.getInt(1);	// 검색한 글 개수
			}
			
		} catch (Exception e) {
			System.out.println("getGBoardCount()메서드 내부 오류: " + e);
		} finally { // 자원해제
			if(rs!=null) 	try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null) try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null) 	try{con.close();}catch(Exception err){err.printStackTrace();}
		}
		
		return count;
	}
}
