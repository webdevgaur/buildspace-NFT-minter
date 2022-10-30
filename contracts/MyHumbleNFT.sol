// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract MyHumbleNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;


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

    string json;

    event NFTMintComplete(address from, uint256 tokenId);

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

    function tokensMinted() public view returns(uint256) {
        return _tokenIdCounter.current();
    }

    function mintThisBitch(string memory baseSvg) public {
        uint256 newItemId = _tokenIdCounter.current();

        string memory first = pickRandomFirstWord(newItemId);
        string memory second = pickRandomSecondWord(newItemId);
        string memory third = pickRandomThirdWord(newItemId);
        string memory combinedWord = string(abi.encodePacked(first,second,third));

        string memory finalSVG = string(abi.encodePacked(baseSvg, combinedWord, "</text></svg>"));

        json = Base64.encode(
            abi.encodePacked(
                '{"name":"', combinedWord, '",',
                '"description":"A ', third, ' who is ', first, ' ', second, '.",',
                '"image":"data:image/svg+xml;base64,', Base64.encode(bytes(finalSVG)), '"}'
            )
        );

        string memory finalTokenURI = string(abi.encodePacked('data:application/json;base64,',json));

        console.log('\n-------------------------------');
        console.log(finalTokenURI);
        console.log('-------------------------------\n');

        _safeMint(msg.sender, newItemId);
        // Doing this using the method below causes significantly higher gas consumption
        _setTokenURI(newItemId, finalTokenURI);
        console.log('An NFT with the ID of %s has been minted to %s', newItemId, msg.sender);
        _tokenIdCounter.increment();
        emit NFTMintComplete(msg.sender, newItemId);
    }

}