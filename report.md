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


- **"Inaccuracies in Oracle Feed Can Lead to Bad Debt Accumulation During Price Drops"**

  The GitHub issue pertains to the potential for the accumulation of bad debt during significant asset price drops due to Chainlink feeds' inability to provide accurate asset prices. The issue centers on how Chainlink aggregators maintain a pre-defined price range, with the oracle reporting a minimum price ('minPrice') instead


  **Link**: [Issue #1](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/1)


- **"Oracle Getter Functions Reverting Due to Incorrect Overflow Handling in TickMath and FullMath Libraries"**

  Oracle getter functions may occasionally revert due to overflow issues found in the underlying 'TickMath' and 'FullMath' libraries. It's suggested to wrap all 'TickMath', 'FullMath', and 'OracleLibrary' functions in an unchecked block, akin to the official Uniswap 0.


  **Link**: [Issue #3](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/3)


- **"AaveHub Withdrawal Issue: Residual Tokens Getting Stuck Leading to Inefficient Withdrawals"**

  The issue pertains to the AaveHub.`withdrawExactAmount` function in which the ERC20 aToken is withdrawn from `WiseLending` and then the underlying is withdrawn from aave via the `AaveHelper._wrapWithdrawExactAmount` function. However, there're instances where


  **Link**: [Issue #7](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/7)


- **Issue with Liquidation Logic: Proposed Updates for Handling Pure Collateral and Lending Shares Collateral for Better Financial Efficiency**

  The issue indicates a problem with the platform's liquidation logic, where pure collateral may be sufficient to cover payments, but the logic still draws from the lending shares. This scenario increases liquidators' risks as they may have to accept part of their payment in shares that can't be immediately withdrawn. A


  **Link**: [Issue #15](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/15)


- **"WiseOracleHub.getTokensPriceInUSD Function Does Not Validate ETH Price, Potentially Impacting Accounting in Protocol**

  Issue with the Validation of Returned ETH Price impacting the Token USD Calculation: The "WiseOracleHub.getTokensPriceInUSD" function within the Wise Lending platform has been found to have an issue with the validation of the returned ETH price. Essentially, the price of ETH drawn from the "get


  **Link**: [Issue #29](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/29)


- **"Token Deposit Check in MainHelper.sol Allows More Tokens than Maximum Limit"**

  "Off-by-One Token Deposit Issue in MainHelper.sol Contract Highlights Need for Adjusted Check Condition"


  **Link**: [Issue #39](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/39)


- **"WiseLendingDeclaration.sol Incorrect Implementation of ONE_YEAR Constant causing erroneous calculations"**

  Inaccuracy in Yearly Precision Calculation due to Misinterpretation of a Year's Duration in WiseLendingDeclaration.sol

The issue is associated with the inaccurate interpretation of 'ONE_YEAR' which is currently being treated as '52 weeks' or '364 days'. This error, resulting in minor deviations in


  **Link**: [Issue #41](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/41)


- **"Issue with NFTs Deposits on Unminted Tokens Leading to Lockouts and Calculation Errors"**

  Issue with the Deposit Mechanism in Non-Minted NFTs - An attacker can reserve Non-Fungible Tokens (NFTs) for users, deposit minuscule amounts, thereby blocking 'enterFarm' for them. This approach can be further exploited by depositing on future NFT


  **Link**: [Issue #42](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/42)


- **Issue: Incorrect TWAP Computation in WiseOracleHub.getTokensPriceFromUSD() Function Affecting Incent**

  The WiseOracleHub.getTokensPriceFromUSD() method reportedly skips TWAP (Time-Weighted Average Price) computation, permitting the use of price even if the discrepancy surpasses the 'ALLOWED_DIFFERENCE'. This concerns the mechanism converting the USD value of a token into its equivalent token amount with


  **Link**: [Issue #47](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/47)


- **Issue with Curve Security Checks in WiseCore and MainHelper leading to potential LP Tokens Price Manipulation**

  Summary: Issue related to function call sequence in lending protocol allows potential manipulation of token prices and unauthorized borrowing. An identified process sequence in 'WiseCore._coreBorrowTokens()' causes '_poolToken' not to be included in the 'borrowTokens' array and omitting curve reentrancy check


  **Link**: [Issue #48](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/48)


- **"WiseSecurity.checksWithdraw Blocks Withdrawal of Uncollateralized, Blacklisted Pooltokens with OpenBorrow**

  Issue with 'WiseSecurity.checksWithdraw' FunctionInhibiting Uncollateralized, Blacklisted PoolTokens Withdrawal

The issue concerns the 'WiseSecurity.checksWithdraw' function which blocks the withdrawal of uncollateralized, blacklisted pool tokens that have an 'OpenBorrow


  **Link**: [Issue #51](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/51)



## Conclusion

The audit of the Hats.finance's Wise Lending audit competition conducted over 11 days, by 11 participants yielded several low-severity issues. The problems ranged from inaccuracies in Oracle Feeds leading to potential bad debt accumulation, to issues with inefficient withdrawals, liquidation logic, Token USD Calculation, and potential token price manipulation among others. Issues were also discovered concerning the withdrawal of uncollateralized assets and incorrect implementation. Overall, while the findings of the audit indicated areas for improvement, the issues identified were of low severity and unlikely to significantly impact the functioning of the Wise Lending platform. The audit's findings should guide the platform's development team in enhancing Wise Lending's performance, security, and efficiency.

## Disclaimer


This report does not assert that the audited contracts are completely secure. Continuous review and comprehensive testing are advised before deploying critical smart contracts./n/n
The Wise Lending audit competition illustrates the collaborative effort in identifying and rectifying potential vulnerabilities, enhancing the overall security and functionality of the platform.