package vehicle.facts;

import java.util.*;
import java.rmi.server.*;

public class VehicleApplication {
	
	int appyear;
	Date appdate;
	String apptype;
	String vehicletype;
	String objid;
	String controlno;
	Date lastfranchisedatepaid;

	def fixDate( def dt ) {
		if( dt instanceof String ) {
			def df = new java.text.SimpleDateFormat( "yyyy-MM-dd");
			dt = df.parse( dt );
		}
		return dt;
	}

	public VehicleApplication() {
	}		

	public VehicleApplication( def m ) {
		controlno = m.franchise.controlno;
		apptype = m.apptype;
		objid = m.objid;
		vehicletype  = m.franchise.vehicletype.objid;
		if( m.appyear ) appyear = m.appyear;
		if( m.year ) appyear = m.year;
		if( m.appdate ) {
			appdate = fixDate( m.appdate );
		}	
		if(m.lastfranchisedatepaid) {
			lastfranchisedatepaid = fixDate( m.lastfranchisedatepaid );
		}
	}

	public void setAppdate( def dt ) {
		appdate = fixDate( dt );		
	}

}