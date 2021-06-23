import React from "react";
import { Image } from "rsi-react-web-components";
import LguHeader from "../components/LguHeader";
import FilipizenIcon from "../components/FilipizenIcon";
import FilipizenMasterTemplate from "./FilipizenMasterTemplate";
import "rsi-react-web-components/dist/index.css";

const getLguLogo = (partner) => {
  return (
      <Image style={{height: "40px"}} src={`/assets/${partner.id}.png`} height="30px" />
  );
};

const LguMasterTemplate = ({ children, ...rest }) => {
  return (
    <FilipizenMasterTemplate logo={FilipizenIcon}>
      <LguHeader Logo={getLguLogo(rest.partner)} {...rest} />
      {children}
    </FilipizenMasterTemplate>
  );
};

export default LguMasterTemplate;
