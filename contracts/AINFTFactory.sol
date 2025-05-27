// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/proxy/Clones.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract AINFTFactory is Ownable {
    using Clones for address;
    address public implementation;
    address[] public allCollections;
    
    event CollectionCreated(address indexed creator, address collection);
    
    constructor() {
        implementation = address(new AINFTImplementation());
    }
    
    function createCollection(string calldata name, string calldata symbol) external {
        address clone = implementation.clone();
        AINFTImplementation(clone).initialize(name, symbol);
        allCollections.push(clone);
        emit CollectionCreated(msg.sender, clone);
    }
}