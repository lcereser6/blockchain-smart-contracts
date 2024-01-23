import { ethers } from "hardhat";
import hre from "hardhat";
import { setTimeout } from 'timers/promises';



async function main() {

  console.log();
  const CSC = await ethers.deployContract("CSC");
  await CSC.waitForDeployment();
  process.stdout.write("[SC-Deployer] ");
  console.log(`>>>CSC deployed to >>>${CSC.target}`);

  const BankSC = await ethers.deployContract("BankSC");
  await BankSC.waitForDeployment();
  process.stdout.write("[SC-Deployer] ");
  console.log(`>>>BankSC deployed to >>>${BankSC.target}`);
  
  const AddressAuth = await ethers.deployContract("AddressAuth");
  await AddressAuth.waitForDeployment();
  process.stdout.write("[SC-Deployer] ");
  console.log(`>>>AddressAuth deployed to >>>${AddressAuth.target}`);

  const DH1 = await ethers.deployContract("DH1");
  await DH1.waitForDeployment();
  process.stdout.write("[SC-Deployer] ");
  console.log(`>>>DH1 deployed to >>>${DH1.target}`);

  const DH2 = await ethers.deployContract("DH2");
  await DH2.waitForDeployment();
  process.stdout.write("[SC-Deployer] ");
  console.log(`>>>DH2 deployed to >>>${DH2.target}`);

  const DH3 = await ethers.deployContract("DH3");
  await DH3.waitForDeployment();
  process.stdout.write("[SC-Deployer] ");
  console.log(`>>>DH3 deployed to >>>${DH3.target}`);




  
  
  console.log("waiting 10 seconds for etherscan to index contract");
  await setTimeout(20000);
  //new line
  console.log();


  await hre.run("verify:verify", {
    address: CSC.target,
    constructorArguments: [],
  });
  process.stdout.write("[SC-Verifyer] ");
  console.log("CSC verified");

  console.log();

  await hre.run("verify:verify", {
    address: BankSC.target,
    constructorArguments: [],
  });
  process.stdout.write("[SC-Verifyer] ");
  console.log("BankSC verified");
  console.log();

  await hre.run("verify:verify", {
    address: AddressAuth.target,
    constructorArguments: [],
  });
  process.stdout.write("[SC-Verifyer] ");
  console.log("AddressAuth verified");
  console.log();

  await hre.run("verify:verify", {
    address: DH1.target,
    constructorArguments: [],
  });
  process.stdout.write("[SC-Verifyer] ");
  console.log("DH1 verified");
  console.log();

  await hre.run("verify:verify", {
    address: DH2.target,
    constructorArguments: [],
  });
  process.stdout.write("[SC-Verifyer] ");
  console.log("DH2 verified");
  console.log();

  await hre.run("verify:verify", {
    address: DH3.target,
    constructorArguments: [],
  });
  process.stdout.write("[SC-Verifyer] ");
  console.log("DH3 verified");
  console.log();

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
