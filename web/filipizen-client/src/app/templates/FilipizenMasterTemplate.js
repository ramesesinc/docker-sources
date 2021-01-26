import React from "react";
import MasterTemplate from "./MasterTemplate";
import FilipizenIcon from "../components/FilipizenIcon";
import "rsi-react-web-components/dist/index.css";

import Header from "../components/Header";
import Footer from "../components/Footer";

const FilipizenMasterTemplate = ({ children, ...rest }) => {
  const showHeader = rest.showHeader === undefined ? true : rest.showHeader;
  return (
    <MasterTemplate logo={FilipizenIcon}>
      {showHeader && <Header />}
        {children}
      <Footer />
    </MasterTemplate>
  );
};

export default FilipizenMasterTemplate;
