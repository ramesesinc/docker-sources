import React from "react";
import { Link } from "react-router-dom";
import "./Header.css";

import FilipizenIcon from "./FilipizenIcon";

const Header = () => {
  return (
    <div className="Header">
      <Link to="/partners">
        <FilipizenIcon />
      </Link>
    </div>
  );
};

export default Header;
