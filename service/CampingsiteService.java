package gocamping.service;
import java.util.List;

import gocamping.entity.Campingsite;
import gocamping.entity.CampingsiteType;
import gocamping.exception.GCException;

public class CampingsiteService {
	private CampingsiteDAO dao = new CampingsiteDAO();
	
	public List<Campingsite> getAllCampingsite()throws GCException{
		List<Campingsite> list = dao.selectAllCampingsite();
		return list;
	}
	
	public List<CampingsiteType> getAllCampingsitetype() throws GCException{
		List<CampingsiteType> list = dao.selectAllCampingsitetype();		
		return list;
	}
	
	
}
