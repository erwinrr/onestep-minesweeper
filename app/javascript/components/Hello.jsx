import React from "react";
import ReactDOM  from "react-dom/client";

function Hello(){
  return (
    <div>Hola Ray Ray</div>
  )
}

const hello = ReactDOM.createRoot(document.getElementById('hello-component'));
hello.render(<Hello/>);