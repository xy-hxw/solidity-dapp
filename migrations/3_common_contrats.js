const Math = artifacts.require("Math");
const Adoption = artifacts.require("Adoption");
const MovieBallot = artifacts.require("MovieBallot");

const SafeMath = artifacts.require("SafeMath");
const Owned = artifacts.require("Owned");
const Controlled = artifacts.require("Controlled");
const HdToken = artifacts.require("HdToken");


module.exports = function(deployer) {
  deployer.deploy(Math);
  deployer.deploy(Adoption);
  deployer.deploy(MovieBallot);

  deployer.deploy(SafeMath);
  deployer.deploy(Owned);
  deployer.deploy(Controlled);
  deployer.deploy(HdToken);

};