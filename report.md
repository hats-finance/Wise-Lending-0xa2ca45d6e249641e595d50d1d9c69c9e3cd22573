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


- **Inaccurate Oracle Feed Reports during Crash Leading to Bad Debt Accumulation**

  The issue details a vulnerability in Chainlink's Oracle feed that could cause the system to report incorrect asset prices during a severe crash. This could enable users to borrow assets at inflated prices, resulting in significant accumulation of bad debt. The problem arises from Chainlink's use of built-in aggregators, which can prevent the price from going out of a predefined price range. The user recommended comparing minPrice and maxPrice of underlying aggregators against Chainlink's returned answer in order to prevent this issue.


  **Link**: [Issue #1](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/1)


- **Oracle Getter Functions Revert Due to Incorrect Overflow Handling in Libraries**

  Oracle getter functions can occasionally revert due to a misrepresentation in the underlying `TickMath` and `FullMath` libraries. These libraries handle cases when values overflow 256 bits erroneously, getting their conception from the Uniswap v3 repositories. When such an overflow occurs, instead of executing as originally intended, the execution reverts, preventing the accurate result. To remedy this issue, enveloping all `TickMath`, `FullMath`, and `OracleLibrary` functions in an unchecked block is


  **Link**: [Issue #3](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/3)


- **Potential Stuck Residual aToken in AaveHub Contract Due to Withdrawal Issue**

  The issue highlights a problem with the `AaveHub.withdrawExactAmount` function, where a withdrawal of deposited ERC20 aToken from `WiseLending` could result in residual tokens stuck in the `AaveHub` contract if the actual amount returned is less than the required amount. This issue also extends to `_wrapWithdrawExactShares` and `_wrapBorrowExactAmount` functions. A suggested fix involves transferring residual tokens to the owner or re-depositing them in `W


  **Link**: [Issue #7](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/7)


- **Issue with Liquidation Logic Leading to Unnecessary Pool Shares Allocation**

  The issue pertains to the liquidation logic in a blockchain application. The current process calculates the required collateral percentage from two different sources to cover the liquidator payment. However, if the pure collateral is sufficient but the lending share collateral isn't, the liquidator might face a risk. The post also highlights an attack scenario and gives a recommendation to first draw from the pure collateral. The issue description follows an in-depth conversation about possible solutions and their possible repercussions.


  **Link**: [Issue #15](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/15)


- **WiseOracleHub.getTokensPriceInUSD Function Doesn't Validate Ethereum Price Data**

  The issue focuses on the lack of validation checks on the returned ETH price from the `getETHPriceInUSD` function. This function is used in the `WiseOracleHub.getTokensPriceInUSD` to adjust the token USD price. Similarly, `WiseOracleHub.getTokensPriceFromUSD` directly uses the returned price from `getETHPriceInUSD` without validation. This opens up the possibility of utilizing an invalid ETH price, which could disrupt the protocol's accounting by returning an


  **Link**: [Issue #29](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/29)


- **Issue with Token Deposit Check in MainHelper.sol - Exceeds Maximum Limit by One**

  The issue lies in the 'MainHelper.sol' where the check on the number of tokens deposited is off by one, enabling an allowance for the deposit of 'MAX_TOTAL_TOKEN_NUMBER + 1' tokens instead of 'MAX_TOTAL_TOKEN_NUMBER' tokens. A recommended fix is altering '>' to '>=' in userTokenData length check.


  **Link**: [Issue #39](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/39)


- **Incorrect Calculation Due to ONE_YEAR value in WiseLendingDeclaration Contract**

  In the WiseLendingDeclaration.sol, ONE_YEAR constant is defined as 52 weeks equating to 364 days. An inaccurate representation of ONE_YEAR leads to observable discrepancies in calculated constants like PRECISION_FACTOR_YEAR and RESTRICTION_FACTOR that are extensively used in other contracts. The recommended fix is to define ONE_YEAR as 365 days which would bring accurate results in calculations.


  **Link**: [Issue #41](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/41)


- **Potential for Unauthorized Deposits on Unminted NFTs Affecting 'EnterFarm' Function**

  The issue pertains to a vulnerability that allows deposits on Non-Fungible Tokens (NFTs) that have yet to be minted. This is possible by reserving NFTs for specific users through calling 'reservePositionForUser'. An attacker can then lock 'enterFarm' for these users or any new users by depositing on future NFTs. This can cause 'enterFarm' to revert and lead to potential calculation errors as the code might not anticipate the deposited amount on the


  **Link**: [Issue #42](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/42)


- **Issue with TWAP Computation Skipped in WiseOracleHub.getTokensPriceFromUSD Function**

  The issue pertains to the 'WiseOracleHub.getTokensPriceFromUSD()' functionality of a lending platform, which doesn't conduct a time-weighted average price (TWAP) computation allowing for use of price even if it differs radically from the 'ALLOWED_DIFFERENCE'. This bypassing undermines the purpose of having two price oracles, triggering erratic incentive computation. As remedies, it's suggested to add a TWAP check on 'getTokensPriceFromUSD()' or create a wrapper around the


  **Link**: [Issue #47](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/47)


- **Issue with Curve LP Tokens Price Manipulation in `_curveSecurityChecks()` Function**

  The issue lies in the `MainHelper._curveSecurityChecks()` function where a security check for curve lp tokens price manipulation doesn't include `_poolToken` in the `borrowTokens` array. This can result in a potential attack, where the curve pool's `virtual_price` can be manipulated, enabling borrowing of more lp tokens than permitted, which benefits an attacker. The issue can be mitigated by adding `_poolToken` to the `borrowTokens` array before it is passed to `_curve


  **Link**: [Issue #48](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/48)


- **WiseSecurity.checksWithdraw Blocks Withdrawal of Uncollateralized Blacklisted Pooltokens**

  The issue is with `WiseSecurity.checksWithdraw` function that blocks the withdrawal of uncollateralized, blacklisted pool tokens with open borrow positions. The user has suggested that blacklisted, uncollateralized tokens should be withdrawable, even if there is an OpenBorrowPosition. Currently, withdrawal can revert with `OpenBorrowPosition()`, causing user funds to be locked, especially if pool tokens are blacklisted. This behaviour may be problematic for users unable to front-run the


  **Link**: [Issue #51](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/51)



## Conclusion

The audit competition on the security infrastructure of Hats.finance's autonomous protocol, Wise Lending, revealed a number of low-severity issues. Problems identified included inaccuracies in Oracle Feed reports during crashes, occasional reversion of Oracle getter functions due to incorrect overflow handling, potential stuck residual aToken in AaveHub Contract, issues with liquidation logic, and lack of validation checks in WiseOracleHub.getTokensPriceInUSD function. Other problems were identified with token deposits checks, inconsistent calculation due to improper definition of ONE_YEAR, potential for unauthorized deposits on unminted NFTs, issues with time-weighted average price computation, curve LP tokens' price manipulation, and blockage of withdrawal of uncollateralized blacklisted pool tokens. Although none of these problems were deemed critical, each issue presented potential vulnerabilities to the functionality and security of the platform

## Disclaimer


This report does not assert that the audited contracts are completely secure. Continuous review and comprehensive testing are advised before deploying critical smart contracts./n/n
The Wise Lending audit competition illustrates the collaborative effort in identifying and rectifying potential vulnerabilities, enhancing the overall security and functionality of the platform.