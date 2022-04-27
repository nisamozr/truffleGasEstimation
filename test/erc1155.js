const erc1155 = artifacts.require("PolygonNFT1155V2");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("erc1155", function (/* accounts */) {
  it("should assert true", async function () {
    await erc1155.deployed();
    return assert.isTrue(true);
  });
  it("mint nft", async function () {
    const contract = await erc1155.deployed();
    const to_address = "0xA5604b0f23307a661f62e4C3767973ea8AaE00F8"
    const _uri = "https://ethereum.stackexchange.com/questions/94658/estimate-gas-cost-for-a-function-call-in-solidity-on-chain"
    const tokenIds = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10,11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
    const amount = [2000, 200, 4, 4, 4, 4, 4, 4, 4, 4,2000, 200, 4, 4, 4, 4, 4, 4, 4, 4]
    const gasEstimate = await contract.mint.estimateGas(to_address, _uri, tokenIds, amount);
    const tx = await contract.mint(to_address, _uri, tokenIds, amount, {
      gas: gasEstimate
    });
    assert(tx);
    console.log(gasEstimate);
  });
});
