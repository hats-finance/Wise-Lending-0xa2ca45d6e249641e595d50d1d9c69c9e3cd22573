# **Wise Lending Audit Competition on Hats.finance** 


# **Introduction to Hats.finance**


Hats.finance builds autonomous security infrastructure for integration with major DeFi protocols to secure users' assets. 
It aims to be the decentralized choice for Web3 security, offering proactive security mechanisms like decentralized audit competitions and bug bounties. 
The protocol facilitates audit competitions to quickly secure smart contracts by having auditors compete, thereby reducing auditing costs and accelerating submissions. 
This aligns with their mission of fostering a robust, secure, and scalable Web3 ecosystem through decentralized security solutions​.

## Wise Lending Overview

Decentralized liquidity market that allows users to supply crypto assets and start earning a variable APY from borrowers

## Competition Details


- Type: A public audit competition hosted by Wise Lending
- Duration: 11 days
- Maximum Reward: $16,700
- Total Payout: $16,700 distributed among 11 participants.

## **Scope of Audit**

## Project overview

Wise Lending is a decentralized liquidity market that allows users to supply crypto assets and start earning a variable APY from borrowers. Lend APY is best-in-class because of integrated yield sources. 

To date, yield aggregators have not been able to eclipse the TVL of simple lend platforms like Aave, and we believe this is because lenders don't have the flixibility they have on Aave to borrow against their deposits. But we also believe that simple lend platforms would see much higher TVLs if the APY offered to lenders was closer to what is offered on decentralized yield platforms. Pendle has emerged recently as the premire yield source for dependable decentralized single-asset yield farming, and we interfaced certain Pendle pools (and other sources like Lido stETH) into Wise Lending, so that borrowers can arbitrage our variable borrow rates with these yield opportunities, without leaving our platform. This creates a constant high demand for borrowing, which raises our APY for lenders to industry competitive levels. 

Wise Lending offers the best of both worlds to its users: Best-in-class APY for lenders, of any platform that offers the flexibility to borrow against deposits, and best-in-class arbitrage opportunities for borrowers, who can apply leverage to the existing best yield sources available.

## Audit competition scope

- Babylonian.sol
- FeeManager
- MainHelper.sol
- OwnableMaster.sol
- PoolManager.sol
- PositionNFTs.sol
- WiseCore.sol
- WiseLending.sol
- WiseLendingDeclaration.sol
- WiseLowLevelHelper.sol

Breakdown by folder:
```
.
├── DerivativeOracles
│   ├── CustomOracleSetup.sol
│   ├── PendleChildLpOracle.sol
│   ├── PendleLpOracle.sol
│   ├── PtOracleDerivative.sol
│   └── PtOraclePure.sol
├── FeeManager
│   ├── DeclarationsFeeManager.sol
│   ├── FeeManager.sol
│   ├── FeeManagerEvents.sol
│   └── FeeManagerHelper.sol
├── PowerFarms
│   ├── PendlePowerFarm
│   │   ├── PendlePowerFarm.sol
│   │   ├── PendlePowerFarmDeclarations.sol
│   │   ├── PendlePowerFarmLeverageLogic.sol
│   │   ├── PendlePowerFarmMathLogic.sol
│   │   └── PendlePowerManager.sol
│   ├── PendlePowerFarmController
│   │   ├── PendlePowerFarmController.sol
│   │   ├── PendlePowerFarmControllerBase.sol
│   │   ├── PendlePowerFarmControllerHelper.sol
│   │   ├── PendlePowerFarmTokenFactory.sol
│   │   └── PendlePowerFarmToken.sol
│   └── PowerFarmNFTs
│       ├── MinterReserver.sol
│       └── PowerFarmNFTs.sol
├── TransferHub
│   ├── ApprovalHelper.sol
│   ├── CallOptionalReturn.sol
│   ├── SendValueHelper.sol
│   ├── TransferHelper.sol
│   └── WrapperHelper.sol
├── WiseOracleHub
│   ├── Declarations.sol
│   ├── OracleHelper.sol
│   └── WiseOracleHub.sol
├── WiseSecurity
│   ├── WiseSecurity.sol
│   ├── WiseSecurityDeclarations.sol
│   └── WiseSecurityHelper.sol
└── WrapperHub
    ├── AaveEvents.sol
    ├── AaveHelper.sol
    ├── AaveHub.sol
    └── Declarations.sol
```

## Low severity issues


- **Oracle Feed Misreporting during a Crash** - **Summary:** This medium-severity issue relates to potential inaccuracies in Oracle feed/hub during a price collapse. Due to Chainlink feeds' built-in mechanism that prevents prices going outside of a
**Link**: [Issue #1](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/1)


- **Potential Overflows and Revert with Oracle Method Calls** - **Summary:** @0xfuje reveals a medium severity issue where Oracle getter functions in 'PendleTokenCustomOracle.sol' and 'WiseOracleHub.sol' occasionally revert due
**Link**: [Issue #3](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/3)


- **Residual aTokens stuck in AaveHub on withdrawal** - **Summary:** This issue, flagged as medium severity, pertains to the AaveHub's withdrawal functionality. It focuses on the scenario when the `AAVE.withdraw` function
**Link**: [Issue #7](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/7)


- **Inefficient Liquidation Logic Causing Unnecessary Risk** - **Summary:** This issue, reported by @nirohgo, is of medium severity and revolved around the inefficient liquidation logic resulting in an unnecessary risk for the user. Specifically
**Link**: [Issue #15](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/15)


- **Title: Validation Issues on Returned ETH Prices Impacting Accounting Protocol** - **Summary:** This Medium severity issue relates to the `WiseOracleHub.getTokensPriceInUSD` and `OracleHelper.getETHPriceInUSD` functions, which fetch
**Link**: [Issue #29](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/29)


- **Title: Miscounting Maximum Token Deposit in MainHelper Contract**  
**Summary:** User @bahurum reported an issue with medium severity relating to a miscalculation in the MainHelper.sol contract. Instead of allowing only MAX_TOTAL_TOKEN
**Link**: [Issue #39](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/39)


- **Incorrect Definition of 'ONE_YEAR' in WiseLendingDeclaration.sol Contract** - **Summary:** This medium severity issue, submitted by @0xRizwan, highlights an error in the WiseLendingDeclaration.sol contract, where the `ONE
**Link**: [Issue #41](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/41)


- **Possible Attackers exploiting NFT deposit loophole** - **Summary:** A medium severity issue has been discovered where anyone can deposit on yet-to-be-minted NFTs, possibly locking the enterFarm function for new users with an elaborate attack scenario
**Link**: [Issue #42](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/42)


- **Bypassing TWAP Check in WiseOracleHub.getTokensPriceFromUSD Function** - **Summary:** A user points out a medium severity issue where the function `WiseOracleHub.getTokensPriceFromUSD()` skips the Time-Weighted
**Link**: [Issue #47](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/47)


- **Possible Security Flaw in WiseCore Borrow Tokens Method** - **Summary:** A high severity issue has been flagged in the WiseCore._coreBorrowTokens() function. It is suggested that the 'curve pool' virtual price can be manipulated,
**Link**: [Issue #48](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/48)


- **User Funds Erroneously Locked** - **Summary:** Tri-pathi flagged an issue in the `WiseSecurity.checksWithdraw` function of Wise Lending's contract, marking it with high severity. The user claims that the withdrawal of un
**Link**: [Issue #51](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/51)



## Conclusion

The audit report describes a public audit competition held by Wise Lending that lasted 11 days and had a total payout of $16,700 distributed among 11 participants. Wise Lending, a decentralized liquidity market allowing users to supply crypto assets in exchange for a variable APY, conducted this audit competition to find potential vulnerabilities in its platform. The auditors went through specific files like 'Babylonian.sol,' 'FeeManager,' 'WiseLending.sol,' etc. They found multiple issues ranging from medium to high severity. These issues ranged from oracle feed misreporting during price collapses to

## Disclaimer


This report does not assert that the audited contracts are completely secure. Continuous review and comprehensive testing are advised before deploying critical smart contracts./n/n
The Wise Lending audit competition illustrates the collaborative effort in identifying and rectifying potential vulnerabilities, enhancing the overall security and functionality of the platform.