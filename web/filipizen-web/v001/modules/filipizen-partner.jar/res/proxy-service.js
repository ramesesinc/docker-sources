var ProxyService = new function() {

	this.lookup = function( orgcode, serviceName, connection ) {
		if(orgcode!=null) {
			return Service.lookup( orgcode + ":" + serviceName );
		}			
		else {
			return Service.lookup( serviceName, connection );
		}		
	}

}