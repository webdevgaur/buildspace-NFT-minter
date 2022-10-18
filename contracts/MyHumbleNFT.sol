// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MyHumbleNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenId;
    constructor() ERC721 ("GoodBoyz", "GDBZ"){
        console.log('Let there be light!');
    }

    function mintThisBitch() public {
        uint256 newItemId = _tokenId.current();
        _safeMint(msg.sender, newItemId);
        _setTokenURI(newItemId, "data:application/json;base64,eyJuYW1lIjoiaW1hZ2UgZXhwZXJpbWVudCIsImRlc2NyaXB0aW9uIjoiVHJ5aW5nIHRvIGhvc3QgYW4gaW1hZ2UgZnJvbSBpbWFndXIgdGhpcyB0aW1lIGluc3RlYWQgb2YgSVBGUyIsImltYWdlIjoiaHR0cHM6Ly9pLmltZ3VyLmNvbS9qNUdTYVpiLnBuZyJ9");
        console.log('An NFT with the ID of %s has been minted to %s', newItemId, msg.sender);
        _tokenId.increment();
    }


}