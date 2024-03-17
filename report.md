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

## low


- **Risk of Accumulating Bad Debt Due to Inaccurate Asset Pricing during a Crash** - **Summary:** This medium-severity issue concerns the Oracle feed/Hub reporting an inaccurate asset price during a significant price drop. The problem stems from Chainlink's mechanism preventing prices from going outside a predefined range. Consequently, users can borrow against a minimum predefined price (minPrice) instead of the actual market value if the asset's price falls below minPrice, enabling the accumulation of substantial bad debts and possibly leading to the system's bankruptcy. Additional vulnerability exists due to TWAP oracles' inability to prevent price manipulation during crashes. The proposed solution involves comparing `minPrice` and `maxPrice` of underlying aggregators against Chainlink's returned `answer` from `latestResolver()`, diverting if it falls outside acceptable bounds.
**Link**: [Issue #1](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/1)


- **Potential Overflow in Oracle Getter Function Libraries** - **Summary:** A medium severity issue was found where the Oracle getter functions can occasionally revert due to an overflow in `TickMath` and `FullMath` libraries. A specific library version was used which reverts on overflow. This affects several contracts, including `WiseOracleHub.latestResolver()`, that rely on these libraries. The libraries were likely borrowed from the Uniswap V3 repositories and were expected to handle, not revert on, overflow. As a solution, the user @0xfuje recommended wrapping all `TickMath`, `FullMath` and `OracleLibrary` functions in an unchecked block to handle potential overflows better.
**Link**: [Issue #3](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/3)


- **Issue with aToken withdrawal in AaveHub and AaveHelper contracts** - **Summary:** The GitHub issue discusses a potential problem in the `AaveHub.withdrawExactAmount` and `AaveHelper._wrapWithdrawExactAmount` functions, as used in `WiseLending` contract. Under certain circumstances, an actual amount returned from `AAVE.withdraw` function may be less than the amount required, which could result in residual aToken getting stuck in the `AaveHub` contract. These residual tokens cannot be withdrawn or utilized. The contributor suggests a modification in the `AaveHub.withdrawExactAmount` function, where any residual `aTokens` that have not been burnt (still remaining in the contract) when withdrawing via `AAVE.withdraw` should be either transferred back to the position owner, or re-deposited back in `WiseLending`. The project team acknowledged the catch and is looking into it.
**Link**: [Issue #7](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/7)


- **Liquidity Concern for Liquidators in Pure Collateral & Lending Shares Scenario** - **Summary:** This issue, deemed medium severity, discusses a possible inefficiency in the liquidation process when dealing with pure collateral and lending shares. The current logic first calculates the liquidator's payment based on a mix of pure collateral and lending shares, then pays out in both. This becomes a problem when pure collateral is enough to cover the payment but lending shares in the pool are insufficient, potentially forcing the liquidator to take on additional risk and wait for the pool to refill. An attack scenario is provided along with a suggested adjustment to the liquidation logic, drawing from pure collateral first before lending shares. Although initial comments propose adding new code to address this, subsequent discussion suggests the concern is more an enhancement than a bug.
**Link**: [Issue #15](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/15)


- **Issue: Unvalidated ETH Pricing in WiseOracleHub Could Lead to Incorrect Token Value Calculations** - **Summary:** There's a medium severity issue in the Wise Oracle Hub's `getTokensPriceInUSD` and `getETHPriceInUSD` functions. These functions calculate the USD value of a token, which is derived from two fetched values - the token/ETH value from a chainlink price feed and the ETH USD price. However, the issue emerges because the ETH price returned from `getETHPriceInUSD` is neither checked nor validated, leading to potential use of an invalid price. This could cause a flaw in the protocol's accounting system by returning an invalid token USD price. While the developer explains that `getTokensPriceInUSD` is used for internal team allocation which doesn't require a check, the user who flagged the issue sees this vulnerability as a potential threat. The recommendation is to validate the price feed data in a similar way done in `OracleHelper._chainLink
**Link**: [Issue #29](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/29)


- **Off-by-one bug with tokens deposited in MainHelper.sol** - **Summary**: This issue, tagged as medium but noted by the submitter as low severity, is regarding an off-by-one error that occurs in MainHelper.sol. This error allows for depositing one token more than the `MAX_TOTAL_TOKEN_NUMBER`. The submitter recommends adjusting the '>' check to '>=' to resolve the issue.
**Link**: [Issue #39](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/39)


- **Precision issue in WiseLending contract due to incorrect representation of a year**:  A medium severity issue was reported by @0xRizwan in the `WiseLendingDeclaration.sol` where `ONE_YEAR` is represented as `52 weeks` (364 days) instead of `365 days`. This results in an error in the calculation of the `PRECISION_FACTOR_YEAR` and `RESTRICTION_FACTOR`, which are used extensively in various functions in contracts. The identified deviation in `RESTRICTION_FACTOR` will result in incorrect return values. The reporter recommended to use 365 days instead of 364 days/52 weeks to avoid a significant deviation in factor values. Furthermore, they recommended applying similar changes where `ONE_YEAR` is used in other contracts.
**Link**: [Issue #41](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/41)


- **Early Deposits on Non-Minted NFTs Interval Lockout Issue** - **Summary:** This issue, registered as medium severity, concerns a security flaw in the WiseLending code that allows anyone to deposit on NFTs that haven't been generated yet. This is possible due to how the NFT ID is calculated. The malicious user can also "lock" the `enterFarm` function for new users by making deposits on NFTs expected to be generated in future. This could cause `enterFarm` to revert and could lead to unexpected calculation errors due to the unanticipated deposited amount on the fresh NFTs. As a solution, the protocol can disengage farms if necessary and the incident would not affect existing users or the reusable NFTs within the farm.
**Link**: [Issue #42](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/42)


- **Incentive Calculation Issue with Two Oracles** - **Summary:** This issue rated with medium severity questions the calculation of incentives in the WiseOracleHub. The reported code is thought to permit the use of price data that differs significantly (> `ALLOWED_DIFFERENCE`) from the Time Weighted Average Price (TWAP). Additionally, the function 'getTokensFromETH()' is called, which for `_tokenAddress=WETH_ADDRESS`, bypasses certain checks and returns the amount. The report suggests that this violates the purpose of having two Oracles in place, and a TWAP check for `WETH_ADDRESS` should correspond to the Uniswap pool. Subsequent exchanges in the comment section elaborate on how this can potentially affect incentive distribution among owners and suggest possible fixes, such as adding a TWAP for the USD-ETH token pair. However, the team maintains that most of the time incentives will always be correct or not assigned due to a few checks that already exist in place. They conclude
**Link**: [Issue #47](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/47)


- **Misordered Functions Resulting in Potential Reentrancy Exploit in WiseCore** - **Summary:** Rated as high severity, this issue involves a potential reentrancy vulnerability in the WiseCore contract. In the function `_coreBorrowTokens()`, `_prepareAssociatedTokens()` is called before `_addPositionTokenData()`, meaning the `_poolToken` is not included in the `borrowTokens` array for the `_curveSecurityChecks()`. This could potentially allow an attacker to manipulate the curve pool's `virtual_price` and pass the health check with a lower value, enabling them to borrow more lp tokens than allowed, leading to a significant financial gain at the expense of the protocol. The problem is debated in the comment section with the project team providing an insight about the correct order of function call therefore downplaying the risk. Further discussions follow about the redundancy of certain checks and the team gives acknowledgment for pointing out this possibility and agree to consider it for a potential reward.
**Link**: [Issue #48](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/48)


- **Issue of Withdrawal Block for Uncollateralized, Blacklisted Pooltokens with OpenBorrowPositions** - **Summary:** This high severity issue involves the WiseSecurity.checksWithdraw function, which blocks the withdrawal of uncollateralized, blacklisted pooltokens with OpenBorrowPosition. When attempting to withdraw, the withdrawal will be reverted if the poolToken is blacklisted and uncollateralized. According to the submitter, this lock on the funds doesn't serve a purpose as uncollateralized assets cannot be used to improve the borrow position for blacklisted pooltokens. An attack scenario was also provided to show how users could take advantage of the blacklisting front run. Barriers to withdrawal could lead to loss of assets if the value of tokens drops during the blacklisting period. A sponsor commented that the feature is intentional for the removal of blacklisted tokens. However, the team decided to keep the code as it is and claimed it to be a design choice. They have discovered
**Link**: [Issue #51](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/51)



## Conclusion

The Wise Lending audit competition for Hats.finance identified several issues, ranging from low to high severity. These include an oracle feed reporting inaccurate asset price during a price drop, resulting in possible bad debt accumulation or even bankruptcy. There were issues regarding overflow in oracle getter function libraries leading to occasional system reversions. An issue was identified leading to AaveHub shortcomings resulting in potential token loss. The liquidation process also has a flaw when dealing with collateral and lending shares, which could result in added risk for the liquidator. An off-by-one error was found in MainHelper.sol, allowing one more

## Disclaimer


This report does not assert that the audited contracts are completely secure. Continuous review and comprehensive testing are advised before deploying critical smart contracts./n/n
The Wise Lending audit competition illustrates the collaborative effort in identifying and rectifying potential vulnerabilities, enhancing the overall security and functionality of the platform.