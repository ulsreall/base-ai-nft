// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract AINFTImplementation is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;
    
    struct NFTData {
        bytes32 promptHash;
        bytes32 imageHash;
        address creator;
        uint64 farcasterId;
    }
    
    mapping(uint256 => NFTData) public nftData;
    address public factory;

    constructor() ERRC721("AI NFT Impl", "AINFTI") {
        factory = msg.sender;
    }

    function initialize(string calldata name, string calldata symbol) external {
        require(msg.sender == factory, "Only factory");
        _name = name;
        _symbol = symbol;
    }

    function mintAIArt(bytes32 promptHash, bytes32 imageHash, uint64 farcasterId) external {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        
        _mint(msg.sender, tokenId);
        
        nftData[tokenId] = NFTData(
            promptHash,
            imageHash,
            msg.sender,
            farcasterId
        );
    }
}