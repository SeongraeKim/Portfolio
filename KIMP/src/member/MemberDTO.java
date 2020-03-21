package member;

import java.sql.Timestamp;

public class MemberDTO {

	private String id;
	private String passwd;
	private String name;
	private String postcode;
	private String address;
	private String address2;
	private String tel;
	private String email;
	private Timestamp reg_date;
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPostcode() {
		return postcode;
	}
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	
/*	@Override
	public String toString() {
		
		return "[ id=" + id + ", passwd=" + passwd + ", name=" + name + ", postcode=" + postcode 
							+ ", address=" + address + ", address2=" + address2
							+ ", tel=" + tel + ", email=" + email + ", reg_date=" + reg_date;
	}*/

	
}
