# **Wise Lending Audit Competition on Hats.finance** 


## Introduction to Hats.finance


Hats.finance builds autonomous security infrastructure for integration with major DeFi protocols to secure users' assets. 
It aims to be the decentralized choice for Web3 security, offering proactive security mechanisms like decentralized audit competitions and bug bounties. 
The protocol facilitates audit competitions to quickly secure smart contracts by having auditors compete, thereby reducing auditing costs and accelerating submissions. 
This aligns with their mission of fostering a robust, secure, and scalable Web3 ecosystem through decentralized security solutions​.

## Wise Lending One liner

Decentralized liquidity market that allows users to supply crypto assets and start earning a variable APY from borrowers

## About Hats Audit Competition


Hats Audit Competitions offer a unique and decentralized approach to enhancing the security of web3 projects. Leveraging the large collective expertise of hundreds of skilled auditors, these competitions foster a proactive bug hunting environment to fortify projects before their launch. Unlike traditional security assessments, Hats Audit Competitions operate on a time-based and results-driven model, ensuring that only successful auditors are rewarded for their contributions. This pay-for-results ethos not only allocates budgets more efficiently by paying exclusively for identified vulnerabilities but also retains funds if no issues are discovered. With a streamlined evaluation process, Hats prioritizes quality over quantity by rewarding the first submitter of a vulnerability, thus eliminating duplicate efforts and attracting top talent in web3 auditing. The process embodies Hats Finance's commitment to reducing fees, maintaining project control, and promoting high-quality security assessments, setting a new standard for decentralized security in the web3 space​​.


## Competition Details


- Type: A public audit competition hosted by Wise Lending
- Duration: 11 days
- Maximum Reward: $200,000
- Submissions: 11
- Total Payout: $16,700 distributed among 11 participants.

## Scope of Audit

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


- **Issue with Chainlink Feed: Inaccurate Price Reporting During Crashes leading to Bad Debt Accumulation**

  The issue lies in how Chainlink handles price drops: when the price falls below a predefined minimum, the oracle reports the minimum price instead of the actual asset price. This could result in users borrowing against inflated asset prices, causing bad debt accumulation. Time-weighted average price (TWAP) oracles are ineffective against this. A proposed solution is to compare the minimum and maximum prices against Chainlink's current price, reverting the call if the price is outside this range.


  **Link**: [Issue #1](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/1)


- **Oracle Getter Functions Reverting Due to Overflows in OracleLibrary, TickMath, FullMath**

  The GitHub issue concerns Oracle getter functions that occasionally revert due to an overflow issue. The issue is found in TickMath, FullMath, and OracleLibrary functions which are based on the Uniswap V3 core and periphery repositories. These functions don't handle an overflow correctly when a value exceeds 256 bits, causing execution to revert. The recommended solution is to wrap these functions in an unchecked block.


  **Link**: [Issue #3](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/3)


- **AaveHub Function Can Cause Stuck Residual aToken in Contract**

  The issue outlines a potential stuck residual aToken in the `AaveHub` contract. This happens when the `AAVE.withdraw` function, called within `AaveHelper._wrapWithdrawExactAmount`, returns less than the actual required amount. The problem also extends to `_wrapWithdrawExactShares` and `_wrapBorrowExactAmount` functions. The proposed solution suggests modifications to the `AaveHub.withdrawExactAmount` function to either transfer these residual tokens to the position owner, or re-deposit them again in `WiseLending`.


  **Link**: [Issue #7](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/7)


- **Issues in Liquidation Logic: Unwanted Risk for Liquidators and Prevention of Liquidations**

  The issue focuses on how the liquidation logic sources collateral funds to repay the liquidator. The current process can lead to the liquidator receiving part of their payment in shares, which can't be immediately withdrawn if the lending shares collateral can't cover the payment. This creates unwanted risk for liquidators and can prevent liquidations. It is recommended to change the liquidation logic to draw from pure collateral first and only then from lending shares, potentially saving gas on the transaction too.


  **Link**: [Issue #15](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/15)


- **Issue in WiseOracleHub: Lack of Validity Check for Returned ETH Price Affects Token USD Price Calculation**

  The issue involves the `WiseOracleHub.getTokensPriceInUSD` function in the Wise Lending protocol which uses the `getETHPriceInUSD` function to fetch ETH price data without validating the returned data. This could result in using an invalid price and disrupt accounting in the protocol. It's recommended to update the `OracleHelper.getETHPriceInUSD` function to validate the returned price feed data to ensure the price fetched is always current and valid.


  **Link**: [Issue #29](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/29)


- **Issue with Token Deposit Limit in MainHelper.sol Code**

  The issue pertains to the number of tokens deposited in 'MainHelper.sol'. The current check system allows for depositing 'MAX_TOTAL_TOKEN_NUMBER + 1' tokens instead of the correct 'MAX_TOTAL_TOKEN_NUMBER' tokens. A change is recommended: replacing '>' with '>=' in the if clause.


  **Link**: [Issue #39](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/39)


- **Inaccurate Year Definition in WiseLendingDeclaration.sol Affects Precision Factors**

  The issue arises from the `WiseLendingDeclaration.sol` contract, where `ONE_YEAR` is defined as `52 weeks` or `364 days`. This calculation is further contributing to errors in the `PRECISION_FACTOR_YEAR` and `RESTRICTION_FACTOR` constants. This discrepancy significantly affects output whenever these constants are used, most extensively in `WiseLending.sol`. The recommendation is to adjust the `ONE_YEAR` constant to consider `365 days` instead of `364 days`, which should correct the current inconsistencies in values.


  **Link**: [Issue #41](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/41)


- **Issue with Deposit on Unminted NFTs Causing Unexpected Calculation Errors**

  The issue addresses a flaw in the NFT deposit system. It points out that a user can deposit on NFTs that haven't been minted yet. An attacker could exploit this by reserving NFTs for some users, then locking them out with a small deposit. In the same vein, an attacker could deposit on future NFTs and lock out new users. This bug can cause the 'enterFarm' function to fail and possibly lead to unexpected calculation errors. The testers provided a potential solidity script to reproduce the issue.


  **Link**: [Issue #42](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/42)


- **WiseOracleHub Skips TWAP Computation in getTokensPriceFromUSD Method**

  The issue involves the `WiseOracleHub.getTokensPriceFromUSD()` function. This function skips Time-Weighted Average Price (TWAP) computation, thereby allowing the use of a price that deviates more than the `ALLOWED_DIFFERENCE`. This check is skipped when the token address equals `WETH_ADDRESS`. The problem was identified in the system's incentives computation, and adding a TWAP check for the `WETH_ADDRESS` in relation to the Uniswap pool was recommended.


  **Link**: [Issue #47](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/47)


- **Curve LP Tokens Manipulation Risk In WiseCore._coreBorrowTokens() Function**

  An issue has been found in the 'MainHelper._curveSecurityChecks()' and 'WiseCore._coreBorrowTokens()' functions, where a missing reentrancy check allows for potential manipulation of curve pool's 'virtual_price'. This allows an attacker to borrow more lp tokens than they should, profiting at the protocol's expense and leaving the protocol in debt. There is a simple solution available which involves adding '_poolToken' to the 'borrowTokens' array before it passes through '_curveSecurityChecks()'.


  **Link**: [Issue #48](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/48)


- **WiseSecurity.ChecksWithdraw Issue Blocking Pooltoken Withdrawals Even If Uncollateralized and Blacklisted**

  The issue relates to the 'WiseSecurity.checksWithdraw' function which blocks the withdrawal of pool tokens that are uncollateralized, blacklisted and have an open borrow position. The problem arises when a user attempts to withdraw blacklisted and uncollateralized pool tokens as the withdraw action gets reversed with 'OpenBorrowPosition' and leads to the user's funds becoming locked in the contract. The protocol allows for the withdrawal of uncollateralized assets unless they're blacklisted, but the issue shows that uncollateralized funds can be stuck in the contract. A suggested solution is for user to improve their borrow position and then withdraw their assets.


  **Link**: [Issue #51](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/51)



## Conclusion

The audit competition for the Wise Lending protocol revealed several low severity issues in the autonomous security infrastructure provided by Hats.finance. The audit involved a comprehensive examination of numerous aspects of Wise Lending's code, such as Chainlink Feed, Oracle getter functions, AaveHub function, liquidation logic, WiseOracleHub, and more. Various issues identified included inaccurate price reporting during market crashes leading to bad debt accumulation, the possibility of stuck residuals, the risk of unwanted liabilities for liquidators, and potential calculation errors caused by inaccuracies in the definition of a ‘Year’, among others. Each identified issue was accompanied by a proposed solution for resolving the problem. Overall, the developer teams need to address these issues for a more secure and reliable protocol operation.

## Disclaimer


This report does not assert that the audited contracts are completely secure. Continuous review and comprehensive testing are advised before deploying critical smart contracts.
The Wise Lending audit competition illustrates the collaborative effort in identifying and rectifying potential vulnerabilities, enhancing the overall security and functionality of the platform.
Hats.finance does not provide any guarantee or warranty regarding the security of this project. Smart contract software should be used at the sole risk and responsibility of users.
