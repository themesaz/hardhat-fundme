

const { ethers, getNamedAccounts, network } = require("hardhat");
const { developmentChains } = require("../../helper-hardhat-config");

developmentChains.includes(network.name) ? describe.skip :
    describe("FundMe",async function(){
        let fundMe;
        let deployer;
        const sendValue = ethers.utils.parseEther("1");

        beforeEache(async function(){
            deployer = (await getNamedAccounts()).deployer;
            fundme = await ethers.getContract("FundMe",deployer);
        });
    });