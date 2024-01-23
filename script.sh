#!/bin/bash
cd ../../../../blockchain-smart-contracts/
npx hardhat run scripts/deploy.ts --network sepolia 2>&1
