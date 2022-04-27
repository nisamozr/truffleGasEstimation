
const PolygonNFT1155V2 = artifacts.require("PolygonNFT1155V2");

module.exports = function (deployer) {
  deployer.deploy(PolygonNFT1155V2, "Cope studio", "COP");
};
