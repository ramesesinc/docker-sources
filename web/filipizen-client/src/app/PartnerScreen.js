import React, { useState, useEffect } from "react";
import { 
  Page, 
  Title, 
  Panel, 
  List, 
  Link, 
  Spacer, 
  Subtitle, 
} from "rsi-react-web-components";

import LguMasterTemplate from "./templates/LguMasterTemplate";
import FilipizenMasterTemplate from "./templates/FilipizenMasterTemplate";
import { getModules } from "../modules";
import { getPartnerFromLocation } from "../lib/partner";

const PartnerServiceList = (props) => {
  const { modules, onSelect } = props;
  return (
    <React.Fragment>
      <Panel style={styles.screen}>
        {modules.map((module, idx) => {
          return (
            <Panel key={`${module.name}${idx}`} style={styles.moduleContainer}>
              <Subtitle>{module.title}</Subtitle>
              <List items={module.services} style={styles.list}>
                {({ item: service }) => (
                  <Link key={service.name} component="button" onClick={() => onSelect(module, service)}>
                    {service.title}
                  </Link>
                )}
              </List>
            </Panel>
          );
        })}
      </Panel>
    </React.Fragment>
  );
};


const PartnerScreen = ({
  location, 
  history
}) => {
  const [partner, setPartner] = useState();
  const [modules, setModules] = useState([]);

  useEffect(() => {
    let partner = location.state ? location.state.partner : null;
    if (partner) {
      setPartner(partner);
      setModules(getModules(partner));
    } else {
      getPartnerFromLocation(location)
        .then(partner => {
          setPartner(partner);
          setModules(getModules(partner));
        }).catch(err => history.push("/partners"));
    }
  }, [location, history]);

  const onSelectService = (module, service) => {
    history.push({
      pathname: `/partner/${partner.group.name}_${partner.name}/${module.name}/${service.name}`,
      state: { partner, module, service, },
    });
  };

  if (!partner) {
    return (
      <FilipizenMasterTemplate />
    );
  }

  return (
    <LguMasterTemplate partner={partner} location={location} history={history}>
      <Page>
        <Spacer height={20}/>
        {modules.length > 0 && 
          <React.Fragment>
            <Title>Select Transaction</Title>
            <Spacer height={20} />
            <PartnerServiceList modules={modules} onSelect={onSelectService} />
          </React.Fragment>
        }
        {modules.length === 0 && 
          <div style={styles.maintenanceContainer}>
            <div style={styles.maintenanceInfo}>
              <label style={styles.maintenanceTitle}>Website under maintenance</label>
              <p>
                This website is currently undergoing a scheduled maintenance.
                Will return shortly. Our apologies for the inconvenience.
              </p>
            </div>
            <img style={styles.maintenanceImage} src="/assets/filipizen.png" alt="Under Maintenance" />
          </div>
        }
      </Page>
    </LguMasterTemplate>
  );
};

const styles = {
  screen: {
    width: "100%",
    display: "flex",
    flexWrap: "wrap",
    justifyContent: "flex-start",
    alignItems: "wrap",
  },
  list: {
    display: "flex",
    flexDirection: "column",
    alignItems: "flex-start",
  },
  moduleContainer: {
    width: 300, 
  },
  maintenanceContainer: {
    display: "flex",
    marginTop: 20,
  },
  maintenanceInfo: {
  },
  maintenanceImage: {
    width: 350,
  },
  maintenanceTitle: {
    fontSize: "3rem",
    fontWeight: 800,
  }
}



export default PartnerScreen;
