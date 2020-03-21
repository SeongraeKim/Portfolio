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
	
	private Connection getConnection() throws Exception{						// KIM_DB DB���� getConnection()�޼���
		
		Connection con = null;
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/kim_db");
		con = ds.getConnection();
		
		return con;
	}
	
	public void updateMember(MemberDTO dto){									// ȸ������ updateMember()�޼���
		
		try {
			
			if(dto.getPasswd() == null){	// ��й�ȣ�� �Է����� ���� ���
				
				con = getConnection();
				sql = "update member set postcode = ?, address = ?, address2 = ? where id = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, dto.getPostcode());
				pstmt.setString(2, dto.getAddress());
				pstmt.setString(3, dto.getAddress2());
				pstmt.setString(4, dto.getId());
				
				pstmt.executeUpdate();
				
			}else{							// ������ ��й�ȣ�� �Է��� ���
				
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
			System.out.println("updateMember() �޼��� ���� ����: " + e);
		}finally { // �ڿ�����
			if(pstmt!=null) try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null) 	try{con.close();}catch(Exception err){err.printStackTrace();}
		}// finally END
	}// updateMember()�޼��� END
	
	public MemberDTO myInfo(String id){											//  �� ���� ��ȸ myInfo()�޼���
		
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
			System.out.println("myInfo()�޼��� ���� ����: " + e);
		} finally { // �ڿ�����
			if(rs!=null) 	try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null) try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null) 	try{con.close();}catch(Exception err){err.printStackTrace();}
		}// finally END
		
		return dto;
	}// myInfo()�޼��� END
	
	public ArrayList listMembers(){												// DB�� ����� ȸ������ ��ȸ listMembers()�޼���
		
		// MemberDTO��ü���� �����ų ArrayList�迭 ����
		ArrayList<MemberDTO> list = new ArrayList<MemberDTO>();
		
		try {
			
			con = getConnection();
			sql = "select * from member order by reg_date desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				
				// ȸ�������� ������ ������ ����
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
			System.out.println("listMembers()�޼��� ���� ����: " + e);
		} finally { // �ڿ�����
			if(rs!=null) 	try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null) try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null) 	try{con.close();}catch(Exception err){err.printStackTrace();}
		}// finally END
		
		return list;	// ȸ������Ʈ ��ȯ
	}// listMembers()�޼��� END
	
	
	public int userCheck(String id, String passwd){								// �α��� ó�� userCheck()�޼���
		
		int check = -1;		//  1	-> ���̵� ��ġ, ��й�ȣ ��ġ
							//  0	-> ���̵� ��ġ, ��й�ȣ ����ġ
							// -1	-> ���̵� ����ġ
		
		try {
			
			con = getConnection();
			sql = "select * from member where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()){	// id�� �����ϸ�
				if(passwd.equals(rs.getString("passwd"))){	// ��й�ȣ ��ġ
					
					check = 1;
					
				}else{										// ��й�ȣ ����ġ
					
					check = 0;
				}
				
			}else{											// id�� �������� ������
				
				check = -1;
			}
			
		} catch (Exception e) {
			System.out.println("userCheck()�޼��� ���� ����: " + e);
		} finally { // �ڿ�����
			if(rs!=null) 	try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null) try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null) 	try{con.close();}catch(Exception err){err.printStackTrace();}
		}// finally END
		
		return check;
		
	}// userCheck()�޼��� END
	
	public int idCheck(String id){												// id�ߺ�Ȯ�� idCheck()�޼���
		
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
			System.out.println("idCheck()�޼��� ���� ����: " + e);
		} finally { // �ڿ�����
			if(rs!=null) 	try{rs.close();}catch(Exception err){err.printStackTrace();}
			if(pstmt!=null) try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null) 	try{con.close();}catch(Exception err){err.printStackTrace();}
		}// finally END
		
		return check;
		
	}// idCheck()�޼��� END
	
	public void insertMember(MemberDTO dto){									// ȸ������ �� ȸ������ �߰� insertMember()�޼���
		
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
			System.out.println("insertMember()�޼��� ���� ����: " + e);
		} finally { // �ڿ�����
			if(pstmt!=null) try{pstmt.close();}catch(Exception err){err.printStackTrace();}
			if(con!=null) 	try{con.close();}catch(Exception err){err.printStackTrace();}
		}// finally END
		
	}// insertMember()�޼��� END
	
}// MemberDAO END














