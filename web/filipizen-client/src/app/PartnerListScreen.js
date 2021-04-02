import React, { useState } from "react";
import { Link as RouterLink } from "react-router-dom";
import {
  Title,
  Link,
  List,
  Spacer,
  LinearProgress,
  groupBy,
  Service,
  getNotification,
  Subtitle,
} from "rsi-react-web-components";
import FilipizenMasterTemplate from "./templates/FilipizenMasterTemplate";
import "./PartnerListScreen.css";

const svc = Service.lookup("CloudPartnerService", "partner");
const notification = getNotification();


const PartnerListScreen = (props) => {
  const [loading, setLoading] = useState(true);
  const [partners, setPartners] = useState([]);

  const updatePartnerStatus = (channel, status) => {
    const idx = partners.findIndex((partner) => partner.id === channel);
    if (idx >= 0) {
      const partner = partners[idx];
      if (partner.isonline !== status) {
        partner.isonline = status;
        const updatedPartners = [...partners];
        updatedPartners[idx] = partner;
        setPartners(updatedPartners);
      }
    }
  };

  notification.register("activate", (channel) => {
    updatePartnerStatus(channel, "1");
  });

  notification.register("deactivate", function (channel) {
    updatePartnerStatus(channel, "0");
  });

  React.useEffect(() => {
    setLoading(true);
    svc.invoke("getActivePartners", null, (err, list) => {
      if (!err) {
        setPartners(list);
      } else {
        console.log("Error loading partners ", err)
      }
      setLoading(false);
    })
  }, []);

  return (
    <FilipizenMasterTemplate>
      <div className="PartnerList">
        {loading && 
          <LinearProgress />
        }
        {!loading && 
          <React.Fragment>
            <Spacer height={20} />
            <Title>Select a Partner Agency</Title>
            <PartnerList partners={partners} />
          </React.Fragment>
        }
      </div>
    </FilipizenMasterTemplate>
  );
};

const PartnerLgu = ({ partners }) => {
  const partnerGroup = partners[0].group;
  return (
    <div className="PartnerGroup">
      <Subtitle>{partnerGroup.title}</Subtitle>
      <List items={partners}>
        {({ item: partner }) => (
            <div  key={partner.id}  style={{paddingBottom: 2}}>
              <Link style={partner.isonline !== "0" ? {} : {color: "#aaa"}}
                component={RouterLink}
                to={{
                  pathname: `/partner/${partnerGroup.objid}_${partner.name}/services`,
                  state: { partner },
                }}
                caption={`${partner.title} (${partner.id})`}
              />
            </div>
        )}
      </List>
    </div>
  );
};

const PartnerList = (props) => {
  const { partners } = props;
  const cluster = groupBy(partners, "clusterid");
  return (
    <div className="PartnerList_group">
      {Object.keys(cluster).map((clusterKey) => {
        if (!/test/i.test(clusterKey)) {
          return <PartnerLgu key={clusterKey} partners={cluster[clusterKey]} />
        }
        return null;
      })}
    </div>
  );
};


export default PartnerListScreen;
