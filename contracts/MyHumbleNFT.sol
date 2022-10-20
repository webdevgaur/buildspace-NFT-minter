// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MyHumbleNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;
    constructor() ERC721 ("GoodBoyz", "GDBZ"){
        console.log('Let there be light!');
    }

    function mintThisBitch() public {
        uint256 newItemId = _tokenIdCounter.current();
        _safeMint(msg.sender, newItemId);
        // _setTokenURI(newItemId, "data:application/json;base64,eyJuYW1lIjoiU21vbCBDYXQiLCJkZXNjcmlwdGlvbiI6IlRoaXMgY2F0IGlzIHNvIHNtb2wgaXQncyBjcmF6eS4gSXQgbWlnaHQgYmUgYSBzb2Z0IHRveSEiLCJpbWFnZSI6Imh0dHBzOi8vaS5pbWd1ci5jb20vZEdqRlBSZS5qcGVnIn0");
        // console.log('An NFT with the ID of %s has been minted to %s', newItemId, msg.sender);
        _tokenIdCounter.increment();
    }

    function tokenURI(uint256 _tokenId) public view override returns(string memory) {
        require(_exists(_tokenId));
        return string(
            abi.encodePacked(
                "data:application/json;base64",
                "eyJuYW1lIjoiRXBpY0xvcmRIYW1idXJnZXIiLCJkZXNjcmlwdGlvbiI6IlZlcnkgbmljZSBORlQiLCJpbWFnZSI6ImRhdGE6aW1hZ2Uvc3ZnK3htbDtiYXNlNjQsUEhOMlp5QjRiV3h1Y3owaWFIUjBjRG92TDNkM2R5NTNNeTV2Y21jdk1qQXdNQzl6ZG1jaUlIQnlaWE5sY25abFFYTndaV04wVW1GMGFXODlJbmhOYVc1WlRXbHVJRzFsWlhRaUlIWnBaWGRDYjNnOUlqQWdNQ0F6TlRBZ016VXdJajRLSUNBZ0lEeHpkSGxzWlQ0dVltRnpaU0I3SUdacGJHdzZJSGRvYVhSbE95Qm1iMjUwTFdaaGJXbHNlVG9nYzJWeWFXWTdJR1p2Ym5RdGMybDZaVG9nTVRSd2VEc2dmVHd2YzNSNWJHVStDaUFnSUNBOGNtVmpkQ0IzYVdSMGFEMGlNVEF3SlNJZ2FHVnBaMmgwUFNJeE1EQWxJaUJtYVd4c1BTSmliR0ZqYXlJZ0x6NEtJQ0FnSUR4MFpYaDBJSGc5SWpVd0pTSWdlVDBpTlRBbElpQmpiR0Z6Y3owaVltRnpaU0lnWkc5dGFXNWhiblF0WW1GelpXeHBibVU5SW0xcFpHUnNaU0lnZEdWNGRDMWhibU5vYjNJOUltMXBaR1JzWlNJK1JYQnBZMHh2Y21SSVlXMWlkWEpuWlhJOEwzUmxlSFErQ2p3dmMzWm5QZz09In0="
            )
            );
    }
}