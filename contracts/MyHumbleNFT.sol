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
        _setTokenURI(newItemId, "data:application/json;base64,eyJuYW1lIjoiU21vbCBDYXQiLCJkZXNjcmlwdGlvbiI6IlRoaXMgY2F0IGlzIHNvIHNtb2wgaXQncyBjcmF6eS4gSXQgbWlnaHQgYmUgYSBzb2Z0IHRveSEiLCJpbWFnZSI6Imh0dHBzOi8vaS5pbWd1ci5jb20vZEdqRlBSZS5qcGVnIn0");
        console.log('An NFT with the ID of %s has been minted to %s', newItemId, msg.sender);
        _tokenId.increment();
    }


}