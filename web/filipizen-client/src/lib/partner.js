import { Service } from "rsi-react-web-components";
import { getModules } from "../modules";

export const getPartnerFromLocation = (location) => {
  return new Promise((resolve, reject) => {
    const pathname = location.pathname;
    const matches = pathname.match("/partner/(.*)_(.*)/services");
    if (!matches || matches.length < 3) {
      reject("Invalid path");
    }

    let groupName = matches[1];
    let partnerName = matches[2];

    const svc = Service.lookup("CloudPartnerService", "partner");
    svc.invoke("findByGroupAndName", 
      { groupname: groupName, name: partnerName },
      (err, partner) => {
        if (!err) {
            if (partner.isonline !== "0") {
                resolve(partner);
            } else {
                reject("Partner is offline.");
            }
        } else {
          reject(`Partner ${partnerName} does not exist. ${err}`);
        }
      }
    );
  });
};

export const getPartnerServiceFromLocation = (location) => {
  return new Promise((resolve, reject) => {
    const pathname = location.pathname;
    const matches = pathname.match("/partner/(.*)_(.*)/(.*)/(.*)");
    if (!matches || matches.length < 5) {
      reject("Invalid path");
    }

    let groupName = matches[1];
    let partnerName = matches[2];
    let moduleName = matches[3];
    let serviceName = matches[4];

    const svc = Service.lookup("CloudPartnerService", "partner");
    svc.invoke("findByGroupAndName", 
      { groupname: groupName, name: partnerName },
      (err, partner) => {
        if (!err) {
            if (partner.isonline !== "0") {
              let redirectUrl;
              
              const module = getModules(partner).find(mod => mod.name === moduleName);
              const service = module ? module.services.find(svc => svc.name === serviceName) : null;

              if (!module || !service) {
                redirectUrl = `/partner/${partner.group.name}_${partner.name}/services`;
                resolve({redirectUrl});
                return;
              }
              
              resolve({partner, module, service});
            } else {
                reject("Partner is offline.");
            }
        } else {
          reject(`Partner ${partnerName} does not exist. ${err}`);
        }
      }
    );
  });
};
