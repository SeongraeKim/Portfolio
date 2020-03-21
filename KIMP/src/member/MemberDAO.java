package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {

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
	
	public void updateMember(MemberDTO dto){									// 회원수정 updateMember()메서드
		
		try {
			
			if(dto.getPasswd() == null){	// 비밀번호를 입력하지 않은 경우
				
				con = getConnection();
				sql = "update member set postcode = ?, address = ?, address2 = ? where id = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, dto.getPostcode());
				pstmt.setString(2, dto.getAddress());
				pstmt.setString(3, dto.getAddress2());
				pstmt.setString(4, dto.getId());
				
				pstmt.executeUpdate();
				
			}else{							// 변경할 비밀번호를 입력한 경우
				
				con = getConnection();
				sql = "update member set passwd = ?, postcode = ?, address = ?, address2 = ? where id = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, dto.getPasswd());
				pstmt.setString(2, dto.getPostcode());
				pstmt.setString(3, dto.getAddress());
				pstmt.setString(4, dto.getAddress2());
				pstmt.setString(5, dto.getId());
				
				pstmt.executeUpdate();
			}
						
		} catch (Exception e) {
			System.out.println("updateMember() 메서드 내부 오류: " + e);
		}finally { // 자원해제
			if(pstmt!=null) try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null) 	try{con.close();}catch(Exception err){err.printStackTrace();}
		}// finally END
	}// updateMember()메서드 END
	
	public MemberDTO myInfo(String id){											//  내 정보 조회 myInfo()메서드
		
		MemberDTO dto = new MemberDTO();
		
		try {
			
			con = getConnection();
			sql = "select * from member where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			while(rs.next()){				
				
				dto.setId(id);
				dto.setPasswd(rs.getString("passwd"));
				dto.setName(rs.getString("name"));
				dto.setPostcode(rs.getString("postcode"));
				dto.setAddress(rs.getString("address"));
				dto.setAddress2(rs.getString("address2"));
				dto.setTel(rs.getString("tel"));
				dto.setEmail(rs.getString("email"));
				dto.setReg_date(rs.getTimestamp("reg_date"));
				
			}		
			
		} catch (Exception e) {
			System.out.println("myInfo()메서드 내부 오류: " + e);
		} finally { // 자원해제
			if(rs!=null) 	try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null) try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null) 	try{con.close();}catch(Exception err){err.printStackTrace();}
		}// finally END
		
		return dto;
	}// myInfo()메서드 END
	
	public ArrayList listMembers(){												// DB에 저장된 회원정보 조회 listMembers()메서드
		
		// MemberDTO객체들을 저장시킬 ArrayList배열 생성
		ArrayList<MemberDTO> list = new ArrayList<MemberDTO>();
		
		try {
			
			con = getConnection();
			sql = "select * from member order by reg_date desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				
				// 회원정보를 꺼내서 변수에 저장
				String id = rs.getString("id");
				String passwd = rs.getString("passwd");
				String name = rs.getString("name");
				String postcode = rs.getString("postcode");
				String address = rs.getString("address");
				String address2 = rs.getString("address2");
				String tel = rs.getString("tel");
				String email = rs.getString("email");
				Timestamp reg_date = rs.getTimestamp("reg_date");
				
				MemberDTO dto = new MemberDTO();
				dto.setId(id);
				dto.setPasswd(passwd);
				dto.setName(name);
				dto.setPostcode(postcode);
				dto.setAddress(address);
				dto.setAddress2(address2);
				dto.setTel(tel);
				dto.setEmail(email);
				dto.setReg_date(reg_date);

				list.add(dto);
			}
			
		} catch (Exception e) {
			System.out.println("listMembers()메서드 내부 오류: " + e);
		} finally { // 자원해제
			if(rs!=null) 	try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null) try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null) 	try{con.close();}catch(Exception err){err.printStackTrace();}
		}// finally END
		
		return list;	// 회원리스트 반환
	}// listMembers()메서드 END
	
	
	public int userCheck(String id, String passwd){								// 로그인 처리 userCheck()메서드
		
		int check = -1;		//  1	-> 아이디 일치, 비밀번호 일치
							//  0	-> 아이디 일치, 비밀번호 불일치
							// -1	-> 아이디 불일치
		
		try {
			
			con = getConnection();
			sql = "select * from member where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()){	// id가 존재하면
				if(passwd.equals(rs.getString("passwd"))){	// 비밀번호 일치
					
					check = 1;
					
				}else{										// 비밀번호 불일치
					
					check = 0;
				}
				
			}else{											// id가 존재하지 않으면
				
				check = -1;
			}
			
		} catch (Exception e) {
			System.out.println("userCheck()메서드 내부 오류: " + e);
		} finally { // 자원해제
			if(rs!=null) 	try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null) try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null) 	try{con.close();}catch(Exception err){err.printStackTrace();}
		}// finally END
		
		return check;
		
	}// userCheck()메서드 END
	
	public int idCheck(String id){												// id중복확인 idCheck()메서드
		
		int check = 0;
		
		try {
			
			con = getConnection();
			sql = "select * from member where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				
				check = 1;

			}else{
				
				check = 0;
			}
			
		} catch (Exception e) {
			System.out.println("idCheck()메서드 내부 오류: " + e);
		} finally { // 자원해제
			if(rs!=null) 	try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null) try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null) 	try{con.close();}catch(Exception err){err.printStackTrace();}
		}// finally END
		
		return check;
		
	}// idCheck()메서드 END
	
	public void insertMember(MemberDTO dto){									// 회원가입 시 회원정보 추가 insertMember()메서드
		
		try {
			
			con = getConnection();
			sql = "insert into member(id, passwd, name, postcode, address, address2, tel, email, reg_date)"
					+" values(?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPasswd());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getPostcode());
			pstmt.setString(5, dto.getAddress());
			pstmt.setString(6, dto.getAddress2());
			pstmt.setString(7, dto.getTel());
			pstmt.setString(8, dto.getEmail());
			pstmt.setTimestamp(9, dto.getReg_date());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("insertMember()메서드 내부 오류: " + e);
		} finally { // 자원해제
			if(pstmt!=null) try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null) 	try{con.close();}catch(Exception err){err.printStackTrace();}
		}// finally END
		
	}// insertMember()메서드 END
	
}// MemberDAO END














