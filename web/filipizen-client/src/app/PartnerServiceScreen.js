import React, { useState, useEffect} from "react";
import { useLocation, useHistory } from "react-router-dom";
import LguMasterTemplate from "./templates/LguMasterTemplate";
import { getPartnerServiceFromLocation } from "../lib/partner";
import * as modules from "../modules";

const getServiceModule = (service) => {
  return modules.getServiceModule(service);
};

const getPartnerServiceInfo = (location) => {
  if (location && location.state) {
    return location.state;
  } 
  return {};
}

const PartnerServiceScreen = (props) => {
  const location = useLocation();
  const history = useHistory();
  
  const {
    partner: initialPartner, 
    service: initialService, 
    ...rest
  } = getPartnerServiceInfo(location);

  const [partner, setPartner] = useState(initialPartner);
  const [service, setService] = useState(initialService);

  useEffect(() => {
    if (!initialPartner) {
      getPartnerServiceFromLocation(location).then(data => {
        if (data.redirectUrl) {
          history.replace(data.redirectUrl);
        } else {
          setPartner(data.partner);
          setService(data.service);
        }
      }).catch(err => history.replace('/partners'));
    }
  }, [history, initialPartner, location]);

  if (!partner || !service) {
    return null;
  }

  const ServiceModule =  getServiceModule(service);

  return (
    <LguMasterTemplate partner={partner}>
      <ServiceModule {...props} partner={partner} service={service} {...rest}>
        {(module) => {
          const ServiceComponent = module[service.component];
          return <ServiceComponent {...props} partner={partner} service={service} {...rest}/>
        }} 
      </ServiceModule>
      
    </LguMasterTemplate>
  );
};

export default PartnerServiceScreen;
