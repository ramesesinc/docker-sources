import loadable from "@loadable/component";

import "rsi-react-web-components/dist/index.css";
import "filipizen-bpls/dist/index.css";
import "filipizen-monitoring/dist/index.css";

// Module and Server registration
const modules = [
  {
    name: "bpls",
    lib: "filipizen-bpls",
    title: "Business",
    services: [
      {
        module: "bpls",
        name: "businessbilling",
        title: "Business Online Billing",
        component: "BplsBillingWebController",
      },
      {
        module: "bpls",
        name: "renewbusiness",
        title: "Renew Business Application",
        component: "RenewBusinessWebController",
      },
    ],
  },
  {
    name: "rptis",
    lib: "filipizen-rptis",
    title: "Real Property",
    services: [
      {
        module: "rptis",
        name: "rptbilling",
        title: "Realty Tax Online Billing",
        component: "RptBillingWebController",
      },
      {
        module: "rptis",
        name: "rpttaxclearance",
        title: "Online Realty Tax Clearance",
        component: "RealtyTaxClearanceWebController",
      },
    ],
  },
  {
    name: "waterworks",
    lib: "filipizen-waterworks",
    title: "Waterworks",
    services: [
      {
        module: "waterworks",
        name: "waterworksbilling",
        title: "Waterworks Billing",
        component: "WaterworksBillingWebController",
      },
    ],
  },
  {
    name: "obo",
    lib: "filipizen-obo",
    title: "Building and Construction",
    services: [
      {
        module: "obo",
        name: "bldgpermit",
        title: "Building Permit Application",
        component: "BuildingPermitWebController",
      },
      {
        module: "obo",
        name: "occupancypermit",
        title: "Occupancy Permit Application",
        component: "OccupancyPermitWebController",
      },
      {
        module: "obo",
        name: "registerprofessionals",
        title: "Register Professional",
        component: "ProfessionalWebController",
      },
      {
        module: "obo",
        name: "updateprofessional",
        title: "Update Professional",
        component: "UpdateProfessionalWebController",
      },
      {
        module: "obo",
        name: "apptracking",
        title: "Application Tracking",
        component: "AppTrackingWebController",
      },
      {
        module: "obo",
        name: "obobilling",
        title: "Building Permit Online Billing",
        component: "OboBillingWebController",
      },
      {
        module: "obo",
        name: "ptrbilling",
        title: "Pay PTR (Professional Tax Receipt)",
        component: "PtrBillingWebController",
      },
    ],
  },
  // {
  //   name: "skills",
  //   lib: "filipizen-skillsregistry",
  //   title: "Skills Registry",
  //   services: [
  //     { module: "skills", name: 'searchskills', title: "Search Skills", component: "SearchSkillsWebController", },
  //   ]
  // },
  // {
  //   name: "boracay",
  //   title: "Boracay",
  //   services: [
  //     { name: 'terminalticket', title: "Terminal Tickets", component: "TerminalTicketWebController" },
  //   ]
  // },
];

export const getModules = (partner) => {
  const pattern = partner.includeservices;
  if (!pattern) return [];

  const regex = new RegExp(`(${pattern})`, "i");
  const excludeRegex = partner.excludeservices
    ? new RegExp(`(${partner.excludeservices})`, "i")
    : null;

  const partnerModules = [...modules];
  partnerModules.forEach((module) => {
    const partnerServices = module.services.filter(
      (service) =>
        regex.test(service.name) &&
        (!excludeRegex || !excludeRegex.test(service.name))
    );
    module.services = partnerServices;
  });

  return partnerModules.filter((module) => module.services.length > 0);
};

const serviceModules = {};

export const getServiceModule = (service) => {
  let ServiceModule = serviceModules[service.module];
  if (typeof ServiceModule === "undefined") {
    if (service.module === "bpls") {
      ServiceModule = loadable.lib(() => import("filipizen-bpls"));
    } else if (service.module === "rptis") {
      ServiceModule = loadable.lib(() => import("filipizen-rptis"));
    } else if (service.module === "waterworks") {
      ServiceModule = loadable.lib(() => import("filipizen-waterworks"));
    } else if (service.module === "obo") {
      ServiceModule = loadable.lib(() => import("filipizen-obo"));
    }
    else if (service.module === "skills") {
      ServiceModule = loadable.lib(() => import("filipizen-skillsregistry"));
    }
    serviceModules[service.module] = ServiceModule;
  }
  return ServiceModule;
};
