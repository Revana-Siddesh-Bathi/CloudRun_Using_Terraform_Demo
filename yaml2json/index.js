const fs = require("fs");
const express = require("express");
const bodyParser = require("body-parser");
const formidable = require("express-formidable");
const yaml = require("js-yaml");

const app = express();

const port = process.env.PORT || 8080;

// middleware to serve files from public folder
app.use(express.static("public"));

// middleware to parse data coming from request body
app.use(bodyParser.json());

// middelware to handle form data
app.use(formidable());

/**
 * POST
 * Accepts yaml file in request
 * Returns json as string
 */
app.post("/convert", async (req, res) => {
  const { path } = req.files.file;
  const yamlFileContent = fs.readFileSync(path, "utf8");
  const jsonFile = yaml.load(yamlFileContent);
  res.send(jsonFile);
});

// Starting web application
app.listen(port, () => {
  console.log("Listening on port", port);
});
