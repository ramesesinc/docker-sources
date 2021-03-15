// import loadable from "@loadable/component";

import HomeScreen from "./app/HomeScreen";
import PartnerListScreen from "./app/PartnerListScreen";
import PartnerScreen from "./app/PartnerScreen";
import PartnerServiceScreen from "./app/PartnerServiceScreen";
import PaymentSuccess from "./app/PaymentSuccess";
import PaymentError from "./app/PaymentError";
import NotFoundScreen from "./app/NotFoundScreen";
import { Monitor } from "filipizen-monitoring";

// const HomeScreen = loadable(() => import("./app/HomeScreen"))
// const PartnerListScreen = loadable(() => import("./app/PartnerListScreen"))
// const PartnerScreen = loadable(() => import("./app/PartnerScreen"))
// const PartnerServiceScreen = loadable(() => import("./app/PartnerServiceScreen"))
// const PaymentSuccess = loadable(() => import("./app/PaymentSuccess"))
// const PaymentError = loadable(() => import("./app/PaymentError"))
// const NotFoundScreen = loadable(() => import("./app/NotFoundScreen"))

export default [
  {
    name: "home",
    exact: true,
    path: "/",
    component: HomeScreen,
  },
  {
    name: "partners",
    path: "/partners",
    component: PartnerListScreen,
  },
  {
    name: "services",
    path: "/partner/:partnerId/services",
    component: PartnerScreen,
  },
  {
    name: "service",
    path: "/partner/:partnerId/:module/:service",
    component: PartnerServiceScreen,
  },
  {
    name: "success",
    path: "/payment/success",
    component: PaymentSuccess,
  },
  {
    name: "error",
    path: "/payment/error",
    component: PaymentError,
  },
  {
    name: "systools",
    exact: true,
    path: "/admin/systool",
    component: HomeScreen,
  },
  {
    name: "epayment-monitoring",
    exact: true,
    path: "/admin/monitor/epayment",
    component: Monitor,
  },
  {
    name: "404",
    path: "*",
    component: NotFoundScreen,
  },
];
