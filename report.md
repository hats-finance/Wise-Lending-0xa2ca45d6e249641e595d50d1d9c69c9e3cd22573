# **Introduction to Hats.finance**


  Hats.finance builds autonomous security infrastructure for integration with major DeFi protocols to secure users' assets. 
  It aims to be the decentralized choice for Web3 security, offering proactive security mechanisms like decentralized audit competitions and bug bounties. 
  The protocol facilitates audit competitions to quickly secure smart contracts by having auditors compete, thereby reducing auditing costs and accelerating submissions. 
  This aligns with their mission of fostering a robust, secure, and scalable Web3 ecosystem through decentralized security solutions​.

## Wise Lending Overview

Decentralized liquidity market that allows users to supply crypto assets and start earning a variable APY from borrowers

##Competition Details
  - Type: A public audit competition hosted by Wise Lending
  - Duration: 11 days
  - Maximum Reward: $16,700
  - Total Payout: $16,700 distributed among 11 participants.## low

  - **Oracle Misreporting causes Accumulation of Bad Debt during Crashes** - **Summary:** This issue, classed as medium severity, involves a bug in the Oracle feed/hub where it reports incorrect asset prices during a market crash. Chainlink feeds, which use underlying aggregators, would continue to report the minimum price, `minPrice`, instead of the market value for a falling asset. As such, borrowers could accrue bad debt by borrowing against the inflated asset price. Comments suggest comparing `minPrice` and optionally `maxPrice` of the underlying aggregators against Chainlink's returned `answer` from `latestResolver()` and reverting the call if it's outside or equals the bounds. Failing to address this could potentially lead to the collapse of the market.
  **Link**: [Issue #1](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/1)

  - **Possible Overflow Issue in Oracle Libraries** - **Summary:** The contributor @0xfuje has identified a medium severity issue that Oracle getter functions could occasionally revert. The vulnerability is traced back to the `TickMath` and `FullMath` libraries used by `PendleTokenCustomOracle` and `WiseOracleHub` among others. These libraries ambiguously handle cases where a value exceeds 256 bits, leading to overflow problems especially in Solidity version 0.8.24, causing the execution to revert and fail to return the correct result. @0xfuje recommends wrapping these functions in an unchecked block, referencing the Uniswap 0.8 branch for guidance. They also noted that `Babilonian` library doesn't revert on overflows, unlike the other mentioned contracts, but probably doesn't have an impact. The issue submission indicates consideration of the impact it has on in-scope contracts like `WiseOracleHub.latestResolver()`.
  **Link**: [Issue #3](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/3)

  - **Residual aTokens Stuck in AaveHub Contract During Withdrawal** - **Summary:** This issue points to a medium-severity flaw in Aave's withdrawal process. The problem arises when the actual amount withdrawn by `AAVE.withdraw` function is less than needed - leading to residual aTokens getting stuck in the `AaveHub` contract. These stranded tokens cannot be withdrawn or used, causing a potential loss for users. The flaw resides in functions `AaveHub.withdrawExactAmount`, `_wrapWithdrawExactShares`, and `_wrapBorrowExactAmount`. A solution could be transferring these residual aTokens back to the position owner or re-depositing them into `WiseLending`. This issue was found through manual review and the project team is considering its applicability.
  **Link**: [Issue #7](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/7)

  - **Issue Title:** Unwanted Risk in Liquidation Due to Current Lending Pool Logic
**Summary:** A medium severity issue was reported by a user identified as @nirohgo. The problem lies with the lending pool's liquidation logic, which could lead to unwanted risk for liquidators and potentially inhibit liquidations. The issue stems from a scenario where the pure collateral is sufficient to cover the payment, but the lending shares portion tied to the Liquidity Pool does not have enough liquidity to cover its share. As a result, liquidators could receive only a portion of their due payment and the remainder in shares that cannot be withdrawn immediately. This adds an unwelcome risk for liquidators, which might discourage them from liquidating positions. As a solution, the user suggests changing the liquidation logic to draw from the pure collateral first, and only then from the lending shares. After a discussion of potential code implementaions, it was decided that the issue was not a bug, but rather a
  **Link**: [Issue #15](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/15)

  - **Inconsistent ETH Price Validation Leading to Incorrect Accounting** - **Summary:** This issue is of medium severity, it involves the `WiseOracleHub.getTokensPriceInUSD` function in the Wise Lending codebase. The function, which calculates the USD value of a token, uses values fetched from the Chainlink function `getETHPriceInUSD` without any validation, potentially leading to outdated or invalid prices. Consequently, the resulting calculation of the token's USD price could be incorrect, potentially impacting the protocol's accounting. It's recommended to validate the returned price feed data in a similar way used in `OracleHelper._chainLinkIsDead`. There is, however, a conflicting view in the comments where one of the respondents mentions that this function is only used for internal team allocation and thus doesn't require validation. Despite the discussion, the final decision on the issue's resolution remains inconclusive.
  **Link**: [Issue #29](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/29)

  - **Off-by-one Error in MainHelper Contract** - **Summary:** This low level severity issue, originally marked as medium, was found in the MainHelper.sol contract where the check on the number of tokens deposited allows one token over the `MAX_TOTAL_TOKEN_NUMBER`. The submitter, @bahurum, suggests a change in the line of code to correctly set the limit to `MAX_TOTAL_TOKEN_NUMBER`. No specific comments were added in regards to this issue.
  **Link**: [Issue #39](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/39)

  - **Inaccurate Precision Calculation due to Incorrect 'ONE_YEAR' Constant** - **Summary:** This medium severity issue points out a misinterpretation in the WiseLendingDeclaration.sol contract. The constant 'ONE_YEAR' is currently set as '52 weeks', equivalent to 364 days, instead of the actual 365 days. This discrepancy is seen to affect the calculation of the `PRECISION_FACTOR_YEAR` and `RESTRICTION_FACTOR`, both of which use the 'ONE_YEAR' constant. This incorrect precision causes an enormous difference in these factors' actual values, thereby yielding incorrect results in several functions like `_getCurrentSharePriceMax()`. The user suggests replacing the '52 weeks' with '365 days' to fix this issue.
  **Link**: [Issue #41](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/41)

  - **Title:** Potential Abuse of Non-Existing NFT Deposits - **Summary:** The issue reveals a medium-severity vulnerability allowing anyone to deposit on yet-to-be-minted NFTs, causing potential disruptions to the `enterFarm` function. An attacker can reserve NFTs for users, deposit minor amounts, and lock the `enterFarm` function, inhibiting the entry of new users. The issue might also lead to unexpected calculation errors due to unanticipated deposits on newly minted NFTs. As a side note, the impact is reduced, as the existing users are not affected, and the farm is re-deployable if needed.
  **Link**: [Issue #42](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/42)

  - **Issue with Inflation/Deflation Scenarios in WiseOracleHub.getTokensPriceFromUSD()** - **Summary:** The GitHub issue, submitted by user @@Tri-pathi, is of medium severity and concerns the WiseOracleHub.getTokensPriceFromUSD() function in the Wise Lending contract which converts the USD value of a token into a token amount with a current price. The issue arises due to the skipping of TWAP computation which allows price usage even if the difference is more than the 'ALLOWED_DIFFERENCE'. The problematic scenario occurs if `_tokenAddress=WETH_ADDRESS`, as the checks are bypassed. The user suggests adding the TWAP check for `WETH_ADDRESS` consistent with the uniswap pool. The issue sparked a thorough discussion in the comments, leading to potential mitigation strategies such as including a TWAP check from any high TVL pool and reverting if the price difference between ETH price in USD from Chainlink and TWAP varies considerably.
  **Link**: [Issue #47](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/47)

  - **Potential Draining of Borrowable Curve LP Tokens Resulting in Bad Debt** - **Summary:** This high severity issue, reported by @bahurum, pertains to a vulnerability within the `MainHelper._curveSecurityChecks()` and `WiseCore._coreBorrowTokens()` functions in the WiseCore contract. Specifically, the `_prepareAssociatedTokens()` function is called before `_addPositionTokenData()` which results in the `_poolToken` not getting included in the `borrowTokens` array, thereby bypassing the curve reentrancy check. This leaves an opening for an attacker to use read-only-reentrancy to manipulate the curve pool's `virtual_price` downwards, enabling them to borrow more of the LP token than should be allowed, potentially profiting at the expense of the protocol. The proposed solution is to add `_poolToken` to the `borrowTokens` array prior to passing it into `_curveSecurityChecks()`. However, the project team clarified points about the borrowing
  **Link**: [Issue #48](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/48)

  - **High-Risk Issue With PoolToken Withdrawal** - **Summary:** This high-severity issue filed by Tri-pathi involves the WiseSecurity.checksWithdraw function that obstructs the withdrawal of pooltokens that are uncollateralized, blacklisted, and have OpenBorrowPosition. The issuer claims this leads to locked user funds and identifies this as a serious issue. However, project team responses indicate it is a design choice to ensure users pay back loans before blacklisted tokens can be withdrawn. Also, the master has control over when this function is enacted. The issuer argues against the project team's response, leading to further discussions. Ultimately, despite deciding to leave the code as is, the project team decided to reward the issuer for identifying a different bug while scrutinizing this issue.
  **Link**: [Issue #51](https://github.com/hats-finance/Wise-Lending-0xa2ca45d6e249641e595d50d1d9c69c9e3cd22573/issues/51)



## Conclusion

In an audit competition held by Wise Lending, auditors have discovered several severity issues within Hats.finance's infrastructure. These vulnerabilities touch on various areas; they range from oracle misreporting which leads to bad debt accumulation to potential overflow issues in Oracle libraries. The identified issues also included flaws in Aave's withdrawal process that leave residual aTokens stuck in the AaveHub contract, inaccuracies in ETH price validation that leads to incorrect accounting, and other programming mistakes in the main helper contract, impacting the precision of calculations. In addition, a major vulnerability was found in the WiseCore contract that potentially

## Disclaimer


    This report does not assert that the audited contracts are completely secure. Continuous review and comprehensive testing are advised before deploying critical smart contracts./n/n
    The Wise Lending audit competition illustrates the collaborative effort in identifying and rectifying potential vulnerabilities, enhancing the overall security and functionality of the platform.