// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract MyHumbleNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    string baseSvg = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";

    string[] firstWords = [
        "Boldly","Bravely","Brightly","Cheerfully","Deftly","Devotedly","Eagerly","Elegantly","Faithfully",
        "Fortunately","Gleefully","Gracefully","Joylessly","Lazily","Miserably","Morosely","Obnoxiously","Painfully",
        "Poorly","Rudely","Sadly","Selfishly","Terribly","Unhappily","Wearily"
        ];
    string[] secondWords = [
        "Cloudy","Clumsy","Colorful","Combative","Comfortable","Concerned","Condemned","Confused","Cooperative",
        "Fantastic","Fierce","Filthy","Fine","Foolish","Fragile","Frail","Frantic","Friendly",
        "Healthy","Helpful","Helpless","Hilarious","Homeless","Homely","Horrible","Hungry","Hurt",
        "Real","Relieved","Repulsive","Rich","Scary","Selfish","Shiny","Shy","Silly"
        ];
    string[] thirdWords = [
        "Hairdresser","Illustrator","Jailer","Laborer","Magician","Navigator","Operator","Painter","Quarterback",
        "Radiologist","Sailor","Tailor","Umpire","Valet","Waiter","Zookeeper","Actor","Baker",
        "Calligrapher","Dentist","Economist","Farmer","Gardener","Harpist"
        ];
    

    constructor() ERC721 ("GoodBoyz", "GDBZ"){
        console.log('Let there be light!');
    }

    function pickRandomFirstWord(uint256 _tokenId) public view returns(string memory) {
        uint256 rand = random(string(abi.encodePacked("FIRST_WORD_CANDIDATE_FOR_RANDOMNESS", Strings.toString(_tokenId))));
        rand = rand % firstWords.length;
        return firstWords[rand];
    }

    function pickRandomSecondWord(uint256 _tokenId) public view returns(string memory) {
        uint256 rand = random(string(abi.encodePacked("RANDOMNESS_CANDIDATE_FOR_SECOND_WORD", Strings.toString(_tokenId))));
        rand = rand % secondWords.length;
        return secondWords[rand];
    }

    function pickRandomThirdWord(uint256 _tokenId) public view returns(string memory) {
        uint256 rand = random(string(abi.encodePacked("HOW_TO_RANDOMIZE_THIRD_WORD", Strings.toString(_tokenId))));
        rand = rand % thirdWords.length;
        return thirdWords[rand];
    }

    function random(string memory input) internal pure returns(uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    function mintThisBitch() public {
        uint256 newItemId = _tokenIdCounter.current();

        string memory first = pickRandomFirstWord(newItemId);
        string memory second = pickRandomSecondWord(newItemId);
        string memory third = pickRandomThirdWord(newItemId);
        string memory combinedWord = string(abi.encodePacked(first,second,third));

        string memory finalSVG = string(abi.encodePacked(baseSvg, combinedWord, "</text></svg>"));

        string memory json = Base64.encode(
            abi.encodePacked(
                '{"name":"', finalSVG, '",',
                '"description":"A ', third, ' who is', first, ' ', second, '.",',
                '"image":"data:image/svg+xml;base64,', Base64.encode(bytes(finalSVG)), '"}'
            )
        );

        string memory finalTokenURI = string(abi.encodePacked('data:application/json;base64,',json));

        console.log('\n-------------------------------');
        console.log(finalTokenURI);
        console.log('-------------------------------\n');

        _safeMint(msg.sender, newItemId);
        // Doing this using the method below causes significantly higher gas consumption
        // _setTokenURI(newItemId, tokenURI(newItemId));
        console.log('An NFT with the ID of %s has been minted to %s', newItemId, msg.sender);
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