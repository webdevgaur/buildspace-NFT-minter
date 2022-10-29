const { ethers } = require("hardhat")

const main = async () => {
    const nftContractFactory = await hre.ethers.getContractFactory('MyHumbleNFT');
    const nftContract = await nftContractFactory.deploy();
    await nftContract.deployed();
    console.log('Contract deployed to:', nftContract.address);

    const baseSVGForMint = `<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: black; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='yellow' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>`;

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