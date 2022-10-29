const { ethers } = require("hardhat")

const main = async () => {
    baseSVGForMint = `<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='red' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>`;
    const nftContractFactory = await hre.ethers.getContractFactory('MyHumbleNFT');
    const nftContract = await nftContractFactory.deploy();
    await nftContract.deployed();
    console.log('Contract deployed to:', nftContract.address);

    let txn = await nftContract.mintThisBitch(baseSVGForMint);
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