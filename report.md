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


- **Oracle Feed Inaccuracy during Asset Price Crash**

**Summary:** The issue reported concerns Oracle feed's inaccuracy which results in an overinflation of the asset's price during a significant price drop. The underlying Chainlink aggregators have a minimum price
**Link**: [Issue #1](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/1)


- **Potential Overflow Issue with Oracle Getter Functions**

**Summary:** The issue revolves around an occasional reversion of Oracle getter functions. When an overflow occurs while executing `TickMath` and `FullMath` libraries, the execution is terminated and the correct result
**Link**: [Issue #3](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/3)


- **Title:** Potential for Residual aToken Stuck in AaveHub Contract

**Summary:** A user has found an issue with the `AaveHub.withdrawExactAmount` function in the WiseLending contract. This could result in stuck
**Link**: [Issue #7](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/7)


- **Issue with Liquidation Logic Causing Economic Loss**-

**Summary:** The user @nirohgo details an issue in the liquidation logic. Specifically, the problem occurs when the pure collateral is sufficient to cover a payment, but the lending
**Link**: [Issue #15](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/15)


- **Issue: Unvalidated ETH Price Could Lead to Inaccurate Accounting**

**Summary:** There's a potential issue noted in the `WiseOracleHub.getTokensPriceInUSD` function of the Wise Lending Platform where the ETH price returned from
**Link**: [Issue #29](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/29)


- **Off-by-one error in token deposit limit**

**Summary:** The issue is related to an off-by-one error in the `MainHelper.sol` code of the Lending Audit contract. The current check allows for `MAX_TOTAL_TOKEN_NUMBER +
**Link**: [Issue #39](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/39)


- **Inaccuracy in ONE_YEAR Definition Affects Precision Calculations**

**Summary:** This issue discusses a perceived inaccuracy in the `WiseLendingDeclaration.sol` smart contract, where a year is defined as "52 weeks" or "364 days
**Link**: [Issue #41](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/41)


- **Title:** Unauthorized Deposits on Unminted NFTs 

**Summary:** The GitHub issue discusses that people can make deposits on non-existent NFTs as NFT ID is generated by adding one to the lastId. Moreover, specific N
**Link**: [Issue #42](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/42)


- **Issue Title:** Medium Risk: Unregulated Use of Prices > ALLOWED_DIFFERENCE in WiseOracleHub.getTokensPriceFromUSD

**Summary:**
A user discovered that the function 'WiseOracleHub.getTokensPriceFromUSD' skips Time
**Link**: [Issue #47](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/47)


- **Potential Security Flaw in Curve LP Token Price Check**

**Summary:** The issue, highlighted by @bahurum, involves the check for Curve LP tokens' price manipulation within the `MainHelper._curveSecurityChecks()` function. The function `_
**Link**: [Issue #48](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/48)


- **Problem with Withdrawal Checks in WiseSecurity Contract**

**Summary:** The GitHub issue addresses a problematic scenario involving the WiseSecurity contract in the Wise Foundation lending audit. The `checksWithdraw` function in the code supposedly inhibits pool token withdrawal if
**Link**: [Issue #51](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/51)



## Conclusion

The audit report on Wise Lending from the public audit competition by Hats.finance exposed multiple low-severity issues. These included Oracle Feed Inaccuracy during Asset Price Crash, a possible overflow problem in Oracle getter functions, and a potential issue with residual aToken getting stuck in the AaveHub Contract. Moreover, threads concentrated on inaccuracies with token deposit limits, a minor inaccuracy in the definition of a year in calculations, issues related to unauthorized deposits on unminted NFTs, and unregulated use of prices. Further risks identified revolve around the faulty withdrawal check system in the WiseSecurity

## Disclaimer


This report does not assert that the audited contracts are completely secure. Continuous review and comprehensive testing are advised before deploying critical smart contracts./n/n
The Wise Lending audit competition illustrates the collaborative effort in identifying and rectifying potential vulnerabilities, enhancing the overall security and functionality of the platform.