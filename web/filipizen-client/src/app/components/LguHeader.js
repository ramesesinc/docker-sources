import React from "react";
import { Link } from "react-router-dom";
import { Panel } from "rsi-react-web-components";

const styles = {
  container: {
    background: "#2c3e50",
    padding: "4px 50px",
  },
  title: {
    color: "#ddd",
    paddingLeft: 5,
  }
};

const LguHeader = ({partner, Logo}) => {
  return (
        <Panel style={styles.container}>
          <Link to={{
            pathname: `/partner/${partner.name}/services`, 
            state: {partner: partner}
          }}>
            <Panel row>
              <div>{Logo}</div>
            </Panel>
          </Link>
        </Panel>
  );
};


export default LguHeader;
