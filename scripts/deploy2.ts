import { ethers } from "hardhat";
import hre from "hardhat";
import { setTimeout } from 'timers/promises';



async function main() {

  
  const CSC = await ethers.deployContract("CSC");
  await CSC.waitForDeployment();
  console.log(`>>>CSC deployed to >>>${CSC.target}`);
  
  console.log("waiting 10 seconds for etherscan to index contract");
  await setTimeout(30000);
  //new line
  console.log();

  await hre.run("verify:verify", {
    address: CSC.target,
    constructorArguments: [],
  });
  process.stdout.write("[SC-Verifyer] ");
  console.log("CSC verified");


}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
