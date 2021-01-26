import React from "react";
import { BrowserRouter as Router, Route, Switch } from "react-router-dom";
import routes from "./routes";
import "./App.css";

function App() {
  return (
    <Router>
      <Switch>
        {routes.map((route) => (
          <Route key={route.name} {...route} />
        ))}
      </Switch>
    </Router>
  );
}

export default App;
