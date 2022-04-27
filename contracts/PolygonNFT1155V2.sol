// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/metatx/ERC2771Context.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";


contract PolygonNFT1155V2 is ERC1155, ERC2771Context, Ownable  {

    string public name;
    string public symbol;

    //TODO: change the forwarder address while deploying to mainnet - 0x86C80a8aa58e0A4fa09A69624c31Ab2a6CAD56b8
    constructor(string memory _name, string memory _symbol) ERC1155("") ERC2771Context(0x9399BB24DBB5C4b782C70c2969F58716Ebbd6a3b) {
        name = _name;
        symbol = _symbol;
    }

    event BatchMintERC1155(uint256[] mintedIds);

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    using Counters for Counters.Counter;
    using Strings for uint256;
    Counters.Counter private _tokenIds;

    mapping(uint256 => string) public tokenURI;

    //This should be overriden in this contract since both context.sol and ERC2771Context.sol have the same function name and params.
    function _msgSender() internal view override(ERC2771Context, Context) returns (address sender) {
        sender = ERC2771Context._msgSender();
    }

        //This should be overriden in this contract since both context.sol and ERC2771Context.sol have the same function name and params.
    function _msgData() internal view virtual override(ERC2771Context, Context) returns (bytes calldata) {
        return ERC2771Context._msgData();
    }

    function mint(
        address user,
        string memory _uri,
        uint256[] memory tokenIds,
        uint256[] memory amount
    ) public

    {
        require(tokenIds.length == amount.length, "Improper input");
        //require(tokenIds.length <= 20, "Only 20 input allowed!");

        uint256[] memory mintedIds = new uint256[](tokenIds.length);
        uint256 j = 0;
        for(uint256 i = tokenIds[0]; i <= tokenIds[tokenIds.length - 1]; i++) {
            _tokenIds.increment();

            uint256 newItemId = _tokenIds.current();
            _mint(user, newItemId, amount[j], "");
            mintedIds[j] = newItemId;
            j++;
            setURI(newItemId, string(abi.encodePacked(_uri, '/', i.toString())));
        }

        emit BatchMintERC1155(mintedIds);
    }

    function setURI(uint256 _id, string memory _uri) internal {
        tokenURI[_id] = _uri;
    }

    function uri(uint256 _id) public view override returns (string memory) {
        return tokenURI[_id];
    }

}