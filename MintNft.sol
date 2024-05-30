// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MintNft is ERC721Enumerable, Ownable {
    mapping(uint => string) metadataUri;

    constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol) Ownable(msg.sender) {}

    function mintNft(string memory _metadataUri) public payable {
        require(msg.value >= 0.01 ether, "Not enough ETH");


        uint tokenId = totalSupply() + 1;

        _mint(msg.sender, tokenId);

        metadataUri[tokenId] = _metadataUri;

        uint tradeFee = msg.value/10; //수수료 10%

        payable(0x4B0897b0513fdC7C541B6d9D7E929C4e5364D2dB).transfer(tradeFee); //얘한테 10퍼
        payable(owner()).transfer(msg.value - tradeFee); // 나한테 90퍼

    }

    function tokenURI(uint _tokenId) public view override returns (string memory) {
        return metadataUri[_tokenId];
    }


}