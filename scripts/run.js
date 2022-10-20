const { ethers } = require("hardhat")

const main = async () => {
    const nftContractFactory = await hre.ethers.getContractFactory('MyHumbleNFT');
    const nftContract = await nftContractFactory.deploy();
    await nftContract.deployed();
    console.log('Contract deployed to:', nftContract.address);

    let txn = await nftContract.mintThisBitch();
    await txn.wait();

    txn = await nftContract.mintThisBitch();
    await txn.wait();
    
    txn = await nftContract.mintThisBitch();
    await txn.wait();
}

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    } catch (error) {
        console.log('Contract deployment failed due to error:', error);
        process.exit(1);
    }
}

runMain();