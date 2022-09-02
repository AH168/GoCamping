package gocamping.entity;

import java.time.LocalDate;

public class Campingsite {
	
	private int campsiteid;//營地編號
	private String name;//營區名稱
	private String address;//營區地址
	private String hight;//營區海拔
	private String officialholiday;//固定公休日
	private String photourl;//營區費用
	private String category;//營區分類(北部、中部、南部)
	private String county;
	private	String township;
	
	
	public Campingsite() {}

	public Campingsite(int campsiteid, String name, String address, String hight, String officialholiday,
			String photourl, String category, String county, String township) {
		super();
		this.setCampsiteid(campsiteid);
		this.setName(name);
		this.setAddress(address);
		this.setHight(hight);
		this.setOfficialholiday(officialholiday);
		this.setPhotourl(photourl);
		this.setCategory(category);
		this.setCounty(county);
		this.setTownship(township);
	}

	public int getCampsiteid() {
		return campsiteid;
	}

	public void setCampsiteid(int campsiteid) {
		this.campsiteid = campsiteid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getHight() {
		return hight;
	}

	public void setHight(String hight) {
		this.hight = hight;
	}

	public String getOfficialholiday() {
		return officialholiday;
	}

	public void setOfficialholiday(String officialholiday) {
		this.officialholiday = officialholiday;
	}

	public String getPhotourl() {
		return photourl;
	}

	public void setPhotourl(String photourl) {
		this.photourl = photourl;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getCounty() {
		return county;
	}

	public void setCounty(String county) {
		this.county = county;
	}

	public String getTownship() {
		return township;
	}

	public void setTownship(String township) {
		this.township = township;
	}

	@Override
	public String toString() {
		return getClass().getName()
				+",營地代號:"+ campsiteid 
				+", 營地名稱:" + name 
				+ ", 營區地址:" + address 
				+ ", 海拔:" + hight
				+ ", 公休日:" + officialholiday 
				+ ", 圖片url=" + photourl 
				+ ", 分類:" + category
				+ ", 市:" + county 
				+ ", 縣:" + township + "個";
	}


	
	

}
	