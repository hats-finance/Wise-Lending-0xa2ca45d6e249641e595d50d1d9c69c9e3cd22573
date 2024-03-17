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


- **Inaccurate Price Reporting In Oracle Feed During Crash May Lead To Accumulation of Bad Debt**

  The issue describes a vulnerability with Oracle feed/ hub that may report inaccurate asset prices during a market crash, allowing users to borrow against an inflated price and accumulate significant bad debt. This is due to Chainlink aggregators' built-in mechanism that retains minimum price reporting even if the asset's market price falls below that. Recommendations include comparing `minPrice` and `maxPrice` of underlying aggregators against Chainlink's returned `answer` and reverting the call if boundaries are exceeded.


  **Link**: [Issue #1](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/1)


- **Overflow Issue with Oracle Getter Functions in Libraries**

  The issue highlights occasional reversion of Oracle getter functions, impacting contracts like `PendleTokenCustomOracle.sol` and `WiseOracleHub.sol`. This is caused by an overflow handling error in the `TickMath` and `FullMath` libraries, originally from Uniswap V3, that fail to handle values exceeding 256 bits. The suggestion is to wrap all `TickMath`, `Fullmath`, and `OracleLibrary` functions in an unchecked block, referencing the official Uniswap 0.8 branch as it utilizes these blocks for all functions.


  **Link**: [Issue #3](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/3)


- **AaveHub Withdraw Function Error Leading to Residual aTokens Stuck in Contract**

  The issue involves the `AaveHub.withdrawExactAmount` function, which is utilized to withdraw ERC20 aToken from `WiseLending`. The inability of `AAVE.withdraw` function to always withdraw the required amount could leave residual aTokens stuck in the `AaveHub` contract. The suggested fix involves transferring these tokens to the position owner or redepositing them in `WiseLending`.


  **Link**: [Issue #7](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/7)


- **Issue with Liquidation Logic: Pure Collateral vs Lending Shares Collateral in Repayment Process**

  A GitHub issue discusses a problem with the liquidation logic used to source collateral funds to repay the liquidator in a lending protocol. If pure collateral is sufficient to cover the payment, while the lending shares portion cannot be covered by the pool, the liquidator might receive only part of their payment, increasing risk for them and potentially discouraging liquidations. An improvement suggested involves changing the liquidation logic to draw the payment from the pure collateral first, and then from the lending shares.


  **Link**: [Issue #15](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/15)


- **WiseOracleHub.getTokensPriceInUSD Requires Additional ETH Price Validation Check**

  The issue is related to the 'WiseOracleHub.getTokensPriceInUSD' function in the Wise Lending protocol, which doesn't validate the freshness of the Ethereum price data fetched from Chainlink's data feed. This could result in incorrect token pricing, impacting the protocol's accounting. The 'getETHPriceInUSD' function is also found to use the fetched price without validation. The recommended fix is to update the function to verify the returned price feed data accuracy.


  **Link**: [Issue #29](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/29)


- **Issue with Token Deposit Check in MainHelper.sol Allowing Extra Token**

  The issue is about a discrepancy in the 'MainHelper.sol' check on the number of tokens deposited. Instead of permitting `MAX_TOTAL_TOKEN_NUMBER` tokens, it allows for `MAX_TOTAL_TOKEN_NUMBER + 1` tokens. The recommendation is to correct this issue by adjusting the equality in the check to be `>= MAX_TOTAL_TOKEN_NUMBER`.


  **Link**: [Issue #39](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/39)


- **Wrong 'ONE_YEAR' Constant Calculation in WiseLendingDeclaration.sol Causes Precision Error**

  The issue highlights a discrepancy in the 'WiseLendingDeclaration.sol', where 'ONE_YEAR' is defined as 52 weeks or 364 days. This incorrect definition affects the calculation of 'PRECISION_FACTOR_YEAR' and 'RESTRICTION_FACTOR', leading to inaccurate results in various functions. The user recommends defining 'ONE_YEAR' as 365 days instead, to eliminate this discrepancy.


  **Link**: [Issue #41](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/41)


- **Potential Vulnerability: Unminted NFT Deposits May Lock New Users from Entering Farm**

  The issue concerns a scenario where anyone can deposit on non-minted NFTs. The NFT ID is calculated, and 'enterFarm' calls '_getWiseLendingNFT', which will reverse if there's any collateral on the NFT. Moreover, any user can assign a specific NFT to a user by calling 'reservePositionForUser'. The code may fail to anticipate the deposited amount on new NFTs, leading to calculation errors. The attack scenario involves reserving NFTs and deposit restriction, causing 'enterFarm' to reverse.


  **Link**: [Issue #42](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/42)


- **Issue with WiseOracleHub.getTokensPriceFromUSD Missing TWAP Check for WETH_ADDRESS**

  The issue pertains to the `WiseOracleHub.getTokensPriceFromUSD()` function in the reported code, wherein it bypasses TWAP computation. This leniency permits the use of a token's price even if the difference surpasses the `ALLOWED_DIFFERENCE`. The bypass may happen when `_tokenAddress=WETH_ADDRESS`. The participant suggests adding a TWAP check for `WETH_ADDRESS` concerning Uniswap pool for optimized functioning.


  **Link**: [Issue #47](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/47)


- **Curve Security Check Issue Allowing Borrowable Tokens Price Manipulation**

  The issue relates to potential price manipulation of curve lp tokens via read-only-reentrancy in the function `MainHelper._curveSecurityChecks()`. An error in the order of function calls in `WiseCore._coreBorrowTokens()` excludes `_poolToken` from the `borrowTokens` array, bypassing the reentrancy check. This exploit could allow manipulation of the pool's `virtual_price`, permitting overborrowing of lp tokens and leaving bad debt in the protocol. A potential fix is suggested.


  **Link**: [Issue #48](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/48)


- **WiseSecurity's Withdraw Check Issue with Uncollateralized and Blacklisted Pool Tokens**

  The `WiseSecurity.checksWithdraw` function blocks the withdrawal of pool tokens that are blacklisted, uncollateralized, and have an open borrow position. The issue arises if a 'poolToken' is blacklisted, and uncollateralized; they should be withdrawable even if there is an open borrow position, but the withdrawal is stalled and funds are locked. Uncollateralized funds can potentially get stuck in the contract. The creators clarified that this is a design choice and the user must first clear any debts before a blacklisted token can be withdrawn. A bug in 'collateralizedeposit' was discovered during the review.


  **Link**: [Issue #51](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/51)



## Conclusion

The audit report for Hats.finance and Wise Lending uncovered several low-severity issues. It involved an 11-day, public audit competition hosted by Wise Lending in which 11 participants shared the total payout of $16,700. The scope of the audit encompassed a comprehensive list of Solidity files under different directories, among others: Babylonian.sol, FeeManager, MainHelper.sol, OwnableMaster.sol, WiseCore.sol, WiseLending.sol. Areas of concern included some vulnerabilities like inaccurate price reporting during market crashes that may lead to bad debt accumulation; an overflow issue with Oracle getter functions; a problem with liquidation logic; errors in the 'WiseOracleHub.getTokensPriceInUSD'; issues with the token deposit check in MainHelper.sol; among several others. Various fixes and improvements were suggested for each identified issue.

## Disclaimer


This report does not assert that the audited contracts are completely secure. Continuous review and comprehensive testing are advised before deploying critical smart contracts./n/n
The Wise Lending audit competition illustrates the collaborative effort in identifying and rectifying potential vulnerabilities, enhancing the overall security and functionality of the platform.