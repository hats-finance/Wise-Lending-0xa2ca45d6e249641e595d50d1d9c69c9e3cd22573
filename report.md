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


- **"Potential for Incorrect Oracle Feed Pricing During a Crash Leading to Accumulation of Bad Debt"**

  The issue concerns the Oracle feed/hub inaccurately reporting prices during a significant price drop. Chainlink feeds use underlying aggregators that prevent the price from going outside a predefined price range (minPrice). In the event of a substantial price drop, the


  **Link**: [Issue #1](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/1)


- **"Oracle Getter Functions Reversion due to Overflow Issue in TickMath and FullMath Libraries"**

  The issue raises a problem with Oracle getter functions that occasionally revert. This problem is traced to vulnerable functions in `OracleLibrary` or `FullMath` / `TickMath`.

In the `TickMath` and `FullMath` libraries, there is


  **Link**: [Issue #3](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/3)


- **"Potential Issue of Residual aTokens Stuck in AaveHub Contract due to Insufficient Withdrawals"**

  The issue revolves around the 'withdrawExactAmount' function in the AaveHub contract, which is designed to withdraw a specified amount of the deposited ERC20 aToken from WiseLending. The withdrawals happen via another function in the AaveHelper contract


  **Link**: [Issue #7](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/7)


- **"Liquidation Logic Improvement: Draw from Pure Collateral First to Reduce Risk to Liquidators and Pool Users"**

  The issue relates to the liquidation logic used to source collateral funds to repay the liquidator. The process currently works by calculating a required percentage of the total collateral, which includes pure collateral and lending shares collateral, to cover the liquidator payment. However


  **Link**: [Issue #15](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/15)


- **"Necessity of Validating ETH Price Returned from getETHPriceInUSD in WiseOracleHub"**

  The WiseOracleHub.getTokensPriceInUSD function in the hats-finance/Wise-Lending repo is designed to fetch the USD value of a token by first getting the token/ETH value from a Chainlink pricefeed, and then extracting the ETH


  **Link**: [Issue #29](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/29)


- **"Off-by-One Error in Token Deposit Check in MainHelper.sol"**

  The issue pertains to a token deposit check in the `MainHelper.sol` file. The logic behind checking the number of tokens deposited is flawed. Instead of allowing the deposit of 'MAX_TOTAL_TOKEN_NUMBER' tokens as it should, the system is


  **Link**: [Issue #39](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/39)


- **"Incorrect Definition of ONE_YEAR in WiseLendingDeclaration.sol Causing Deviation in Factor Values"**

  The issue is related to the incorrect representation of 'ONE_YEAR' constant in 'WiseLendingDeclaration.sol', where it is considered as '52 weeks' or '364 days' and not '365 days' as in the calendar year. This


  **Link**: [Issue #41](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/41)


- **"Potential Issue with Uncontrolled Deposits on Unminted NFTs Leading to Lock of 'enterFarm'"**

  The issue is about a vulnerability in the depositing process for non-minted NFTs (Non-Fungible Tokens). Currently, anyone can deposit on NFTs that have not yet been minted. The identifier for the NFT is


  **Link**: [Issue #42](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/42)


- **"Issue with 'WiseOracleHub.getTokensPriceFromUSD()' Skipping TWAP Computation"**

  The issue discussed pertains to the `WiseOracleHub.getTokensPriceFromUSD()` function, which skips TWAP (Time-Weighted Average Price) computation. This seems to allow usage of the price even if the difference is greater than the


  **Link**: [Issue #47](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/47)


- **"Potential Security Breach due to Lack of Reentrancy Check on Curve LP Tokens in WiseCore._coreBorrowTokens()"**

  The issue revolves around the potential manipulation of curve LP tokens price via read-only-reentrancy. The `MainHelper._curveSecurityChecks()` function is supposed to prevent such scenario with all `_lendTokens` and `_borrowTokens` used by the


  **Link**: [Issue #48](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/48)


- **"Issue with WiseSecurity.checksWithdraw Blocking the Withdrawal of Uncollateralized, Blacklisted Pooltokens with Open Borrow Positions"**

  The issue concerns the `WiseSecurity.checksWithdraw` functionality that appears to block the withdrawal of pool tokens that are uncollateralized, blacklisted, and have an OpenBorrowPosition. This could potentially lock user's funds.

The user


  **Link**: [Issue #51](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/51)



## Conclusion

Hats.finance recently concluded an audit competition for Wise Lending—a decentralized liquidity market that allows users to earn variable APY. The competition lasted for 11 days and distributed a maximum reward of $16,700 among 11 participants. The audit competition targeted ten key areas including Babylonian.sol, FeeManager, etc. During the audit, several low severity issues were spotted in different areas such as the potential for incorrect oracle feed pricing, lack of reentrancy checks on Curve LP tokens in WiseCore._coreBorrowTokens(), and incorrect representation of 'ONE_YEAR' constant, among others.

## Disclaimer


This report does not assert that the audited contracts are completely secure. Continuous review and comprehensive testing are advised before deploying critical smart contracts./n/n
The Wise Lending audit competition illustrates the collaborative effort in identifying and rectifying potential vulnerabilities, enhancing the overall security and functionality of the platform.