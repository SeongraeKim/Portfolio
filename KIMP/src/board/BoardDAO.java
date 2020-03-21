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
	
	private Connection getConnection() throws Exception{						// KIM_DB DB연결 getConnection()메서드
		
		Connection con = null;
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/kim_db");
		con = ds.getConnection();
		
		return con;
	}
	
	public void reInsertBoard(BoardDTO dto){									// 답글 작성 reInsertBoard()메서드
		
		int num = 0;
		
		try {
			
			con = getConnection();
			sql = "select max(num) from board"; // 가장 최근에 작성한 글번호 조회
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				
				num = rs.getInt(1) + 1;	// 추가할 답변글의 번호

			}else{
				
				num = 1;
			}
			
			sql = "update board set re_seq = re_seq + 1 where re_ref = ? and re_seq > ?";	// 답글 순서배치
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, dto.getRe_ref());			// 부모글의 그룹번호
			pstmt.setInt(2, dto.getRe_seq());			// 부모글의 글 입력 순서
			
			pstmt.executeUpdate();
			
			sql = "insert into board values(?,?,?,?,?,?,?,?,?,now(),?)";					// 답변글 작성
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getPasswd());
			pstmt.setString(4, dto.getSubject());
			pstmt.setString(5, dto.getContent());
			pstmt.setInt(6,dto.getRe_ref());			// 부모글 그룹번호 re_ref값을 사용
			pstmt.setInt(7, dto.getRe_lev() + 1); 		// 부모글의 re_lev에 + 1한 값을 사용
			pstmt.setInt(8, dto.getRe_seq() + 1);
			pstmt.setInt(9, 0);
			pstmt.setString(10, dto.getIp());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("reInsertBoard() 메서드 내부 오류: " + e);
		} finally { // 자원해제
			if(rs!=null) 	try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null) try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null) 	try{con.close();}catch(Exception err){err.printStackTrace();}
		}
		
	}
	
	public int deleteBoard(int num, String passwd){								// 게시글 삭제 deleteBoard()메서드
		
		int check = 0;
		
		try {
			
			con = getConnection();
			sql = "select passwd from board where num = ?";	// 입력한 비밀번호가 DB에 저장된 값과 일치하는지 조회
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
					
					// 게시글 삭제 후 최신글번호를 num에 저장(Syntax Error 발생)
					sql = "update board set num = max(num)";
					pstmt = con.prepareStatement(sql);
					
					pstmt.executeUpdate();
					
				}else{
					
					check = 0;
				}
			}
			
		} catch (Exception e) {
			// System.out.println("deleteBoard()메서드 내부 오류: " + e);
		} finally { // 자원해제
			if(rs!=null) 	try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null) try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null) 	try{con.close();}catch(Exception err){err.printStackTrace();}
		}
		
		return check;
	}
	
	public int updateBoard(BoardDTO dto){										// 게시글 수정 updateBoard()메서드
		
		int check = 0;
	
		try {
			
			con = getConnection();
			sql = "select passwd from board where num = ?";	// 입력한 비밀번호가 DB에 저장된 값과 일치하는지 조회
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
			System.out.println("updateBoard()메서드 내부 오류: " + e);
		} finally { // 자원해제
			if(rs!=null) 	try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null) try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null) 	try{con.close();}catch(Exception err){err.printStackTrace();}
		}
		
		return check;
	}
	
	public void insertBoard(BoardDTO dto){										// 게시글 작성 insertBoard()메서드
		
		int num = 0; // 추가할 글번호 저장할 변수
		
		try {
			
			con = getConnection();
			sql = "select max(num) from board";	// 가장 최근에 작성한 글번호 조회
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				num = rs.getInt(1) + 1;		// num = 가장 최근에 작성한 글번호 + 1
			}else{
				num = 1;					// 조회결과가 없는경우 1을 num에 저장
			}
			
			sql = "insert into board"
					+ "(num, name, passwd, subject, content, "
					+ "re_ref, re_lev, re_seq, readcount, date, ip) "
					+ "values(?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num); 					// 글번호
			pstmt.setString(2, dto.getName());		// 작성자 이름
			pstmt.setString(3, dto.getPasswd());	// 비밀번호
			pstmt.setString(4, dto.getSubject());	// 글제목
			pstmt.setString(5, dto.getContent());	// 글내용
			pstmt.setInt(6, num);					// num 주글번호 기준 == re_ref 그룹번호
			pstmt.setInt(7, 0);						// 새글의 들여쓰기 정도값 re_lev
			pstmt.setInt(8, 0);						// 글 순서 re_seq
			pstmt.setInt(9, 0);					// 조회수
			pstmt.setTimestamp(10, dto.getDate());	// 글 작성날짜
			pstmt.setString(11, dto.getIp()); 		// 작성자 IP주소
			
			pstmt.executeUpdate();

			
		} catch (Exception e) {
			System.out.println("insertBoard()메서드 내부 오류: " + e);
		} finally { // 자원해제
			if(rs!=null) 	try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null) try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null) 	try{con.close();}catch(Exception err){err.printStackTrace();}
		}
	}
	
	public BoardDTO getBoard(int num){											// 게시글 가져오기 getBoard()메서드
		
		BoardDTO dto = null;
		
		try {
			
			con = getConnection();
			sql = "select * from board where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()){	// 해당 번호의 게시글이 존재하면
				
				dto = new BoardDTO(); // 저장할 객체 생성
				
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
			sql = "update board set readcount = readcount + 1 where num = ?";
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
	
	public List<BoardDTO> getBoardlist(int startRow, int pageSize){				// 게시글 리스트 가져오기 getBoardlist()메서드
		
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
			System.out.println("getBoardlist()메서드 내부 오류: " + e);
		} finally { // 자원해제
			if(rs!=null) 	try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null) try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null) 	try{con.close();}catch(Exception err){err.printStackTrace();}
		}
		
		return boardlist;
	}
	
	public int getBoardCount(){													// 전체 게시글 개수 getBoardCount()메서드
		
		int count = 0;
		
		try {
			
			con = getConnection();
			sql = "select count(*) from board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				count = rs.getInt(1);	// 검색한 글 개수
			}
			
		} catch (Exception e) {
			System.out.println("getBoardCount()메서드 내부 오류: " + e);
		} finally { // 자원해제
			if(rs!=null) 	try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null) try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null) 	try{con.close();}catch(Exception err){err.printStackTrace();}
		}
		
		return count;
	}
}

















