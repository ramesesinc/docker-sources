import React from "react";
import { Link } from "react-router-dom";
import { Panel } from "rsi-react-web-components";

const styles = {
  container: {
    background: "#2c3e50",
    padding: "4px 50px",
    display: "flex",
    flexDirection: "row",
    alignItems: "center",
  },
  title: {
    color: "#ddd",
    paddingLeft: 5,
    fontSize: '16pt',
    fontWeight: "bold",
    textDecoration: "none",
  }
};

const LguHeader = ({partner, Logo}) => {
  return (
        <Panel style={styles.container}>
          <Link to={{
            pathname: `/partner/${partner.name}/services`, 
            state: {partner: partner}
          }}>
            <div>{Logo}</div>
          </Link>
          <div style={styles.title}>{partner.title.toUpperCase()}</div>
        </Panel>
  );
};


export default LguHeader;
