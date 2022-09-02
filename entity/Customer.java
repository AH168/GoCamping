package gocamping.entity;
import java.time.LocalDate;
//import java.util.Date;
import java.time.Period;
import java.time.format.DateTimeParseException;

import gocamping.exception.GCDataInvalidException;

public class Customer {
	private String id; 
	private String password; 
	private String name; 
	private char gender; 
	private String email; 
	
	private LocalDate birthday; 
	
	private String address="";
	private String phone=new String(""); 
	private boolean subscribed;
	
	public Customer() {}
	
	public Customer(String id, String password, String name) {
		this.setId(id);
		this.setPassword(password);
		this.setName(name);
	}
	
	public Customer(String id, String password, String name, 
			char gender, String email, String birthday) {
		this(id, password, name);		
		this.setGender(gender);
		this.setEmail(email);
		this.setBirthday(birthday);
	}

	private static final String idFirstCharSequence="ABCDEFGHJKLMNPQRSTUVXYWZIO";
	private static final String idPattern = "[A-Za-z][1289]\\d{8}";
	public static boolean checkROCId(String id) { 			
		if(id!=null && id.matches(idPattern)) {
			id = id.toUpperCase();			
					
			final char c1 = id.charAt(0);			
			
			int n1=0;
			if(c1>='A' && c1<='H') { 
				n1=c1-'A'+10;
			}else if(c1>='J' && c1<='N') {
				n1=c1-'J' + 18;
			}else if(c1>='P' && c1<='V') {
				n1=c1-'P' + 23;
			}else{ 
				switch(c1) {
					case 'X':
						n1 = 30;break;
					case 'Y':
						n1 = 31;break;
					case 'W':
						n1 = 32;break;
					case 'Z':
						n1 = 33;break;
					case 'I':
						n1 = 34;break;
					case 'O':
						n1 = 35;break;	
					default:
						return false;
				}
			}
			
				
			
			int sum = n1/10 + n1%10*9;			
			
			for(int i=8,j=1;i>0;i--,j++) {
				int n = id.charAt(j)-'0';
				
				sum += n*i; 
						
			}

			sum += (id.charAt(9)-'0') * 1; 
			return sum%10 == 0;
		}		
		return false;		
	}
	
	
	public String getId() {
		return this.id;
	}	
	
	public void setId(String id){		
		if(checkROCId(id)) {
			this.id = id.toUpperCase();
		}else {
			
			throw new GCDataInvalidException("身分證號不正確: " + id);
		}
	}
	
	
 	public String getPassword() {
		return this.password;
	}
	
 	public static final int MIN_PASSWORD_LENGTH = 6;
 	public static final int MAX_PASSWORD_LENGTH = 20;
	public void setPassword(String password) {
		if(password!=null && 
					password.length()>=MIN_PASSWORD_LENGTH && 
					password.length()<=MAX_PASSWORD_LENGTH) {
			this.password = password;
		}else {
			
			String msg = String.format("密碼必須%d~%d個字元，但您輸入的是 %s\n", 
					MIN_PASSWORD_LENGTH, MAX_PASSWORD_LENGTH, password);
			throw new GCDataInvalidException(msg);
		}
	}
	
	
	
	public String getName() {
		return name;
	}

 	public static final int MIN_NAME_LENGTH = 2;
 	public static final int MAX_NAME_LENGTH = 20;
	public void setName(String name) {
		if(name!=null && 
				(name=name.trim()).length()>=2 && 
				 name.length()<=20) {
			this.name = name;
		}else{
			
			String msg = String.format("客戶姓名必須%d~%d個字元，但您輸入的是:%s\n", 
					MIN_NAME_LENGTH, MAX_NAME_LENGTH, name);
			throw new GCDataInvalidException(msg);
		}
	}


	public char getGender() {		
		return gender;
	}

	public static final char MALE='M';
	public static final char FEMALE='F';
	public static final char UNKNOWN='U';
	public void setGender(char gender) {
		if(gender==MALE || gender==FEMALE || gender==UNKNOWN) {
			this.gender = gender;
		}else {
			throw new GCDataInvalidException("客戶性別資料輸入錯誤: " + gender);
		}
	}


	public LocalDate getBirthday() {
		return birthday;
	}
	
	public static final int MIN_AGE=12; 
	public void setBirthday(LocalDate birthday) {
		if(birthday==null) {
			
			throw new IllegalArgumentException("客戶生日不得為null");
		}
		
		
		Period period = Period.between(birthday, LocalDate.now());
		int age = period.getYears();
		if(age>=MIN_AGE) {
			this.birthday = birthday;
		}else {
			
			String msg = String.format("客戶生日必須年滿%d歲:%s", MIN_AGE, birthday);
			throw new GCDataInvalidException(msg);
		}
	}
	

	public void setBirthday(int year, int month, int day){
	
		try {
			LocalDate date = LocalDate.of(year, month, day); 
			
			this.setBirthday(date);
		}catch(java.time.DateTimeException e) {
			throw new GCDataInvalidException("客戶生日日期資料不正確: " + e.getMessage());
		}
	}
	
	
	public void setBirthday(String dateStr) {
		if(dateStr==null) this.setBirthday((LocalDate)null);
		
	
		try {
			LocalDate date = LocalDate.parse(dateStr);
			
			
			this.setBirthday(date);
		}catch(DateTimeParseException e) {
			throw new GCDataInvalidException("客戶生日日期格式應符合yyyy-MM-dd(如:2001-03-05)，但你輸入的是:" + dateStr);
		}
	}
		
	
	public String getAddress() {
		return address;
	}
	
	public String getEmail() {
		return email;
	}

	private static final String EMAIL_PATTERN = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$";
	public void setEmail(String email) {
		if(email!=null && email.matches(EMAIL_PATTERN)) {
			this.email = email;
		}else {
			throw new GCDataInvalidException("email格式不正確:" + email);
		}
	}

	public void setAddress(String address) {
		if(address==null) address="";		
		this.address = address.trim();
	}


	public String getPhone() {		
		return phone;
	}

	public void setPhone(String phone) {
		if(phone==null) phone="";		
		this.phone = phone;
	}	


	public boolean isSubscribed() {
		return subscribed;
	}

	public void setSubscribed(boolean subscribed) {
		this.subscribed = subscribed;
	}
	

	 public int getAge() {
		 return getAge(this.birthday);
	 }
	
	 
	 private int getAge(LocalDate birthday) {
		if(birthday!=null) { 
			Period period = Period.between(birthday, LocalDate.now());

			int age = period.getYears();
		
			return age;
		}else{ 
			throw new GCDataInvalidException("客戶生日為null，無法計算年齡");
			
		}
	}

	@Override
	public String toString() {
		return this.getClass().getName() 
			+ "\n  id="+id + ",密碼="+password + ",姓名=" + name 
			+ "\n, 性別=" + gender + ",email=" + email 
			+ "\n, 生日=" + birthday + ", 年齡=" + (birthday!=null?getAge() + "歲":"無法計算年齡") 
			+ "\n, 地址=" + address 
			+ "\n, 電話=" + phone + ", 訂閱電子報=" + subscribed;
	}	
	Integer i ;
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result 
				+ ((id == null) ? 0 : id.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (!(obj instanceof Customer))
			return false;
		Customer other = (Customer) obj;
		if (this.id == null) {
			if (other.id != null)
				return false;
		}else if (!id.equals(other.id))
			return false;
		return true;
	}	 

}