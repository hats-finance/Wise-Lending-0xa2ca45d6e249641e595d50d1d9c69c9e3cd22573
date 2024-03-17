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


- **"Potential Risk of Bad Debt Accumulation in Oracle Hub Due to Inaccurate Asset Price Reporting during Market Crash"

  The issue highlights a vulnerability in the oracle feed/hub, where it reports an inaccurate price during a crash. Chainlink feeds use underlying aggregators, which have a predefined price range, causing the oracle to continue reporting the minimum price (minPrice)


**Link**: [Issue #1](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/1)


- **"Occasional Reverting of Oracle Getter Functions Due to Overflow Issue in TickMath and FullMath Libraries"

  The user, @0xfuje, reports an issue with Oracle getter functions in the 'TickMath' and 'FullMath' libraries occasionally reverting, particularly where a value exceeding 256 bits causes an overflow. This issue stems from a potential mis


**Link**: [Issue #3](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/3)


- **"Residual aToken Stuck in AaveHub Contract due to Lower Actual Withdraw Amount"

  Title: Possible Residual aTokens Stuck in AaveHub Due to Withdrawal Function 

Summary: 
In the AaveHub and AaveHelper contracts, the `withdrawExactAmount` and `_wrapWithdrawExactAmount` functions respectively, allow


**Link**: [Issue #7](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/7)


- **"Issue with Liquidation Logic: Unnecessary Risk for Liquidators Due to Current Drawing Method From Collateral Pools"

  Issue: Identified Liquidation Logic Flaw that May Impact Liquidators and Pool Users

@nirohgo highlighted a problem with the liquidation logic which devalues the process for liquidators and pool users. The issue arises when pure collateral suffices


**Link**: [Issue #15](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/15)


- **"Validation Missing for Returned ETH Price in WiseOracleHub.getTokensPriceInUSD Function"

  The 'WiseOracleHub.getTokensPriceInUSD' function in the Wise Lending project is designed to return the USD value of a token by fetching a token/ETH value from a chainlink pricefeed, then extracting the ETH USD price,


**Link**: [Issue #29](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/29)


- **"Off-by-One Error in Token Deposit Check in MainHelper.sol"

  Title: Miscalculation in Token Deposit Limit in MainHelper.sol

Summary:
The user @bahurum identified an issue in the 'MainHelper.sol' file in the Wise Foundation lending audit repository. Specifically, the check on limits for the


**Link**: [Issue #39](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/39)


- **"Incorrect 'ONE_YEAR' Constant Calculation in WiseLendingDeclaration.sol Causing Deviation in Factor Values"

  Issue: Incorrect Calculation of 'ONE_YEAR' in 'WiseLendingDeclaration.sol' Causing Precision Deviation

Summary: The user @0xRizwan has reported an issue within the file 'WiseLendingDeclaration.sol', where


**Link**: [Issue #41](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/41)


- **"Deposit Vulnerability in Unminted NFTs Locking 'enterFarm' Functionality"

  Github issue: Unauthorized Deposits on Unminted NFTs

Summary: The issue revolves around a NFT lending platform's vulnerability that allows anyone to deposit on Non-Fungible Tokens (NFTs) that have not been minted yet


**Link**: [Issue #42](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/42)


- **"WiseOracleHub.getTokensPriceFromUSD Fails to Implement TWAP, Allowing Usage of Price Despite Differences in ALLOWED_DIFFERENCE"

  Title: "Issue with Skipping TWAP Computation in WiseOracleHub.getTokensPriceFromUSD() Function in Wise Lending Protocol"

Summary: User Tri-pathi noted a problem with a Wise Lending Protocol function, WiseOracleHub.getTokensPrice


**Link**: [Issue #47](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/47)


- **"Potential Security Vulnerability in WiseCore._coreBorrowTokens due to Misplaced _curveSecurityChecks()"

  The issue is related to the potential manipulation of curve LP tokens price due to a vulnerability in the order of function calls in the WiseCore protocol. The user @bahurum pointed out that in the `_coreBorrowTokens()` function, `_prepare


**Link**: [Issue #48](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/48)


- **"Issue with Withdrawal of Blacklisted, Uncollateralized PoolTokens with OpenBorrowPosition in WiseSecurity.checksWithdraw Function"

  The issue revolves around the 'WiseSecurity.checksWithdraw' function, as it blocks the withdrawal of pool tokens that are uncollateralized, blacklisted, and have an OpenBorrowPosition. The main concern is the locking of uncoll


**Link**: [Issue #51](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/51)



## Conclusion

Hats.finance, the host of the 11-day audit competition for Wise Lending, found several low-severity issues that might potentially put users' funds against unnecessary risk. The issues identified such as possibilities of bad debt accumulation in Oracle Hub, risk-prone liquidation logic, occasional reverting of Oracle Getter functions, among others were taken into consideration. Despite the issues, Hats.finance also underlined the implemented proactive security mechanisms and commitment to a decentralized Web3 security infrastructure, aligning with their mission to secure users’ assets. About $16,700 was divided among the 11 participants

## Disclaimer


This report does not assert that the audited contracts are completely secure. Continuous review and comprehensive testing are advised before deploying critical smart contracts./n/n
The Wise Lending audit competition illustrates the collaborative effort in identifying and rectifying potential vulnerabilities, enhancing the overall security and functionality of the platform.