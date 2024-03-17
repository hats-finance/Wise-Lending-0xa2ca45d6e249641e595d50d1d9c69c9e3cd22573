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


- **"Inaccurate Price During Crash: Risk of Bad Debt Accumulation due to Chainlink Feeds MinPrice Issue"**

  Issue centers around potential vulnerability with Oracle feeds in Chainlink where during significant market crashes or extreme price drops, the Oracle would continue to report inflated asset prices due to its `minPrice` mechanism. This could allow users to borrow against the asset at an inflated price leading to substantial bad debt accumulation and possible protocol bankruptcy. Current challenges include the TWAP's inability to defend against this scenario and potential gaps in


  **Link**: [Issue #1](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/1)


- **"Oracle Getter Functions Issue: Potential Reversion due to Overflow in TickMath and FullMath Libraries"**

  Overflow Issue in Oracle Getter Functions Leads to Revert, Needs Unchecked Block Implementation in `TickMath`, `FullMath`, and `OracleLibrary` Functions


  **Link**: [Issue #3](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/3)


- **Issue with AaveHub.withdrawExactAmount Function - Residual aTokens Getting Stuck in AaveHub Contract**

  Issue with AaveHub and AaveHelper Withdrawal Functions Leaving Residual aTokens. The Aave.withdraw function may return less than the expected amount leading to residual aTokens stranded in the AaveHub contract. This happens when the 'withdrawExactAmount' function is called to withdraw ERC20 aTokens. Same problem is observed with '_wrapWithdrawExactShares' and '_wrapBorrowExact


  **Link**: [Issue #7](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/7)


- **Issue with Liquidation Logic: Liquidators Receive Partial Payments Leading to Unnecessary Risk**

  Issue with Liquidation Logic: May Cause Unnecessary Risks and Economic Losses for Liquidators and Pool Users. Proposed Changes in Collateral Repayment Process Could Improve Efficiency and Minimize Risks.


  **Link**: [Issue #15](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/15)


- **"Lack of Validity Checks on 'getETHPriceInUSD' Function Could Lead to Inaccurate Token Pricing in Wise**

  In the WiseOracleHub.getTokensPriceInUSD function, the validation of the ETH price returned by Chainlink.latestRoundData() is missing, potentially resulting in the use of stale or outdated price data. This could cause incorrect USD pricing of tokens, affecting the accounting protocol. It is suggested to update OracleHelper.getETHPriceInUSD function to validate the returned price feed data. The code instances where


  **Link**: [Issue #29](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/29)


- **Token Deposit Limit Issue in MainHelper.sol Allowing One Extra Token Deposit**

  In the MainHelper.sol contract of the lending-audit project, a token deposit limit check is mistakenly allowing one extra token beyond the intended maximum. A recommended solution is to adjust the logic to correctly enforce the token limit, thus preventing potential deposit overflow issues.


  **Link**: [Issue #39](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/39)


- **"Inaccurate Calculation in WiseLendingDeclaration due to ONE_YEAR Defined as 52 Weeks Instead of 365 Days"**

  Incorrect Calculation of `ONE_YEAR` Value in `WiseLendingDeclaration.sol` Impacting APR Restriction Factor and Results in Various Functions. A suggestion to define `ONE_YEAR` as `365 days` instead of `52 weeks` to Correct Precision Calculation.


  **Link**: [Issue #41](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/41)


- **Issue with Deposits on Unminted NFTs: Resulting in Locked 'enterFarm' Operation and Possible Calculation Errors**

  Issue Summary: Deposits Possible on Yet-to-be-Minted Non-Fungible Tokens (NFTs), Leading to Potential Errors and Farm Locks

The issue describes a flaw that allows anyone to deposit on NFTs that haven't been minted yet, potentially leading to erroneous calculations and disruptions in service. These NFT IDs are determined as lastId + 1. Notably,


  **Link**: [Issue #42](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/42)


- **"WiseOracleHub.getTokensPriceFromUSD() Skips TWAP Computation, Allowing Price Use Beyond ALLOWED_DIFF**

  The issue relates to the `WiseOracleHub.getTokensPriceFromUSD()` function in the Wise Lending protocol, which bypasses a crucial Time-Weighted Average Price (TWAP) check. The check is meant to validate the price difference against an `ALLOWED_DIFFERENCE` threshold. The problem arises when the function concerns 'WETH_ADDRESS' tokens and omits this validation step,


  **Link**: [Issue #47](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/47)


- **Function Order Vulnerability in WiseCore._coreBorrowTokens() Facilitating Curve LP Token Manipulation**

  Issue in lending protocol allows for token price manipulation and potential drains on the protocol. Problem arises in lending-audit due to ordering of the `_prepareAssociatedTokens()` and `_addPositionTokenData()` functions in `WiseCore._coreBorrowTokens()`, causing an absence of curve reentrancy checks on `_poolToken`. Consequently, the virtual price of a loan can be viewed as lesser than


  **Link**: [Issue #48](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/48)


- **Issue with WiseSecurity.checksWithdraw Blocking Withdrawal of Uncollateralized, Blacklisted PoolTokens with OpenBorrowPosition**

  Issue with Withdrawal Blocked for Uncollateralized, Blacklisted Pool Tokens: The WiseSecurity 'checksWithdraw' function is preventing the withdrawal of uncollateralized and blacklisted pool tokens, thereby locking user funds. This lock-in occurs even when there's an OpenBorrowPosition. The issue may allow some users to front-run blacklisting and withdraw their tokens, while locking funds for others


  **Link**: [Issue #51](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/51)



## Conclusion

Wise Lending audit by Hats.finance indicated a set of low-severity vulnerabilities. They included: potential bad debt accumulation due to inflated asset prices during market crashes affecting Oracle feeds in Chainlink; overflow issue in Oracle Getter Functions leading to revert; residual aTokens left in AaveHub contract due to issues with withdrawal functions; issues with liquidation logic; inaccuracy in token pricing due to lack of validity checks on 'getETHPriceInUSD' function; deposit limit check in MainHelper.sol allowing an extra token deposit; incorrect calculation due to 'ONE_YEAR' defined as 52 weeks instead of 365 days; deposits made on yet-to-be-minted NFTs leading to potential errors and farm locks; 'WiseOracleHub.getTokensPriceFromUSD()' function bypassing TWAP computation; potential drains in the lending protocol due

## Disclaimer


This report does not assert that the audited contracts are completely secure. Continuous review and comprehensive testing are advised before deploying critical smart contracts./n/n
The Wise Lending audit competition illustrates the collaborative effort in identifying and rectifying potential vulnerabilities, enhancing the overall security and functionality of the platform.