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


- **Issue: Inaccuracy in Oracle Feed Reports During Asset Price Crash Leading to Accumulation of Bad Debt**

  This issue reveals a problem with Chainlink feeds that use underlying aggregators. During a significant price drop, the oracle continues to report the minimum price (minPrice) instead of the actual asset price. If the asset's price falls below the minPrice threshold, the system will value the token at minPrice instead of market value. This allows users to borrow against the inflated price asset, leading to a


  **Link**: [Issue #1](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/1)


- **"Oracle Getter Functions Occasionally Reverting Due to Overflow Issues in TickMath and FullMath Libraries"**

  There's an issue with the Oracle getter functions in the `TickMath`, `FullMath`, and `OracleLibrary` which occasionally cause them to revert due to incorrect handling of 256 bit value overflows. This is a consequence of updating these libraries (originally from Uniswap V3) to solidity version 0.8.24 which reverts on overflow. The recommended solution is to


  **Link**: [Issue #3](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/3)


- **"AaveHub Function Could Cause Stuck Residual aToken in Contract due to Partial Withdrawal"**

  The issue pertains to the `AaveHub.withdrawExactAmount` and `AaveHelper._wrapWithdrawExactAmount` functions. The `AAVE.withdraw` function might in some cases return less of the underlying asset than needed, thereby leaving residual aTokens stuck in the `AaveHub` contract. These stuck tokens cannot be withdrawn or used. A potential solution could be transferring these


  **Link**: [Issue #7](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/7)


- **Liquidation Logic Issue: Unnecessary Risk to Liquidators When Sourcing Collateral from Pure Collateral and Lending Shares**

  The issue concerns the liquidation logic that disproportionately consumes pure collateral and lending shares collateral, when repaying liquidators. This becomes problematic when pure collateral is sufficient to cover the payment, but the lending shares portion can't be entirely covered by the pool, exposing liquidators to risk. A proposed solution is to first draw from pure collateral, fully, if possible, before resorting to lending shares. This


  **Link**: [Issue #15](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/15)


- **"WiseOracleHub.getTokensPriceInUSD Function Lacks Validation for Returned ETH Price"**

  The `WiseOracleHub.getTokensPriceInUSD` function, designed to return the USD value of a token by fetching the token/ETH value from a chainlink pricefeed and extracting the ETH USD price, is not validating the returned ETH price. This could result in using an invalid price and disrupt the protocol. It is advised to update `OracleHelper.getETHPriceInUSD` function to


  **Link**: [Issue #29](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/29)


- **"Token Deposit Miscalculation in MainHelper.sol Allowing Extra Deposit"**

  The issue pertains to a flawed check in the `MainHelper.sol` where the number of tokens that can be deposited is erroneously set to `MAX_TOTAL_TOKEN_NUMBER + 1` as opposed to the intended `MAX_TOTAL_TOKEN_NUMBER`. A fix is suggested through correct approximation coding within the token depositing function.


  **Link**: [Issue #39](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/39)


- **"Inaccurate Precision and Restriction Factors in WiseLendingContract Due to ONE_YEAR Defined as 52 Weeks"**

  The issue pertains to incorrect usage of the constant `ONE_YEAR` in the `WiseLendingDeclaration.sol` file, where it is defined as `52 weeks` (or 364 days), which is causing calculation errors in various contract functions. The inaccuracies are notably observed in the `PRECISION_FACTOR_YEAR` and `RESTRICTION_FACTOR`. The suggested improvement is to define `ONE


  **Link**: [Issue #41](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/41)


- **Issue: Potential Vulnerability Allowing Unauthorised Deposits on Non-Minted NFTs, Possibly Leading to Function**

  An issue in the Wise Lending platform allows anyone to deposit on non-existent NFTs, potentially locking the `enterFarm` function for users. This is due to the NFT ID being determined as [lastId + 1], allowing for deposits on future NFTs. An attack scenario suggests that an attacker reserves NFTs for some users. This may lead to unexpected calculation errors and


  **Link**: [Issue #42](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/42)


- **"WiseOracleHub.getTokensPriceFromUSD() Skips TWAP Computation, Allows Price Use Even If Difference Greater Than**

  The issue pertains to the `WiseOracleHub.getTokensPriceFromUSD()` function skipping Time-Weighted Average Price (TWAP) computation. This issue allows for the use of price even if the difference exceeds the `ALLOWED_DIFFERENCE`. It is suggested that adding a TWAP check for `WETH_ADDRESS` could mitigate the issue. This problem affects the incentive computation process and potentially


  **Link**: [Issue #47](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/47)


- **Issue with WiseCore._coreBorrowTokens() Misplacement Leading to Potential Virtual Price Manipulation & LP Token Drainage**

  The issue lies with the possibility of manipulating the curve lp tokens price through read-only-reentrancy. The problem occurs in the `WiseCore._coreBorrowTokens` function, where the `_prepareAssociatedTokens` function is called before `_addPositionTokenData`, causing the `_poolToken` not to be included in the `borrowTokens` array. This leads to the curve reentrancy


  **Link**: [Issue #48](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/48)


- **Issue with WiseSecurity.checksWithdraw Function Blocking Withdrawal of Uncollateralized, Blacklisted PoolTokens with OpenBorrow**

  The issue highlights a problem with the `WiseSecurity.checksWithdraw` function that prevents withdrawal of pool tokens that are uncollateralized, blacklisted, and have an OpenBorrowPosition. This could result in user funds getting stuck in the contract if the pool tokens are blacklisted. This scenario is problematic as blacklisted, uncollateralized pool tokens cannot be used to improve borrow positions


  **Link**: [Issue #51](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/51)



## Conclusion

Wise Lending, a decentralized liquidity market, participated in a public audit competition over 11 days to examine the security of its system's smart contracts. Areas of focus included chain libraries, data management, and various aspects of the Wise Lending system. Several issues of low severity were discovered. These included weaknesses in oracle feed reports and getter functions, an inaccurate token deposit calculation, and flaws with the liquidation logic and withdrawal function. Further missteps were found in price computations, possible unauthorized deposits on non-minted NFTs, and potential vulnerabilities with the system's borrow tokens function. These areas have been identified for improvement to safeguard smooth functioning and secure processing. The competition successfully identified key areas requiring rectification, thus helping Wise Lending to enhance its service offering while ensuring adherence to its goal of a robust, secure, and scalable Web3

## Disclaimer


This report does not assert that the audited contracts are completely secure. Continuous review and comprehensive testing are advised before deploying critical smart contracts./n/n
The Wise Lending audit competition illustrates the collaborative effort in identifying and rectifying potential vulnerabilities, enhancing the overall security and functionality of the platform.