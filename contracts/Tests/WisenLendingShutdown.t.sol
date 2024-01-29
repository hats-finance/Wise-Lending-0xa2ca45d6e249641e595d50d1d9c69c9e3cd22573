// SPDX-License-Identifier: -- WISE --

pragma solidity =0.8.24;

import "forge-std/Test.sol";
import "../WiseOracleHub/TesterWiseOracleHub.sol";

import {
    AaveHub,
    Declarations as AaveDeclarations,
    AaveEvents,AaveHelper,
    OwnableMaster as OwnableMasterAaveHub
} from "../WrapperHub/AaveHub.sol";

import "../PositionNFTs.sol";
import "../Tests/TesterLending.t.sol";
import "../WiseSecurity/WiseSecurity.sol";

contract WiseLendingShutdownTest is Test{

    TesterWiseOracleHub public ORACLE_HUB_INSTANCE;
    PositionNFTs public POSITION_NFTS_INSTANCE;
    TesterLending public LENDING_INSTANCE;
    AaveHub public AAVE_HUB_INSTANCE;
    WiseSecurity public SECURITY_INSTANCE;
    FeeManager public FEE_MANAGER_INSTANCE;

    address constant WETH_ADDRESS = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    uint256 public constant NEW_BLOCK = 18540971;
    address WISE_DEPLOYER = 0x641AD78BAca220C5BD28b51Ce8e0F495e85Fe689;

    string public _namePositionNFT = "WL-NFTs";
    string public _symbolPositionNFT = "wisetoken";
    string public _baseURIPositionNFT = "WiseLendingNFTs";

    function _deployNewWiseLending()
        internal
    {
        vm.rollFork(
            NEW_BLOCK
        );

        vm.startPrank(
            WISE_DEPLOYER
        );

        address _wethAddrss = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
        address _ethPricingFeed = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419;
        address _uniswapFactoryV3 = 0x1F98431c8aD98523631AE4a59f267346ea31F984;

        ORACLE_HUB_INSTANCE = new TesterWiseOracleHub(
            _wethAddrss,
            _ethPricingFeed,
            _uniswapFactoryV3
        );

        POSITION_NFTS_INSTANCE = new PositionNFTs(
            _namePositionNFT,
            _symbolPositionNFT,
            _baseURIPositionNFT
        );

        console.log(
            "ORACLE_HUB_INSTANCE DEPLOYED AT ADDRESS",
            address(ORACLE_HUB_INSTANCE)
        );

        console.log(
            "POSITION_NFTS_INSTANCE DEPLOYED AT ADDRESS",
            address(POSITION_NFTS_INSTANCE)
        );

        address[] memory aaveUnderlyingAssetsArray = new address[](5);
        address[] memory aaveTokenArray = new address[](5);

        aaveTokenArray[0] = 0x4d5F47FA6A74757f35C14fD3a6Ef8E3C9BC514E8;
        aaveUnderlyingAssetsArray[0] = WETH_ADDRESS;

        aaveTokenArray[1] = 0x5Ee5bf7ae06D1Be5997A1A72006FE6C607eC6DE8;
        aaveUnderlyingAssetsArray[1] = 0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599;

        aaveTokenArray[2] = 0x98C23E9d8f34FEFb1B7BD6a91B7FF122F4e16F5c;
        aaveUnderlyingAssetsArray[2] = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;

        aaveTokenArray[3] = 0x23878914EFE38d27C4D67Ab83ed1b93A74D4086a;
        aaveUnderlyingAssetsArray[3] = 0xdAC17F958D2ee523a2206206994597C13D831ec7;

        aaveTokenArray[4] = 0x018008bfb33d285247A21d44E50697654f754e63;
        aaveUnderlyingAssetsArray[4] = 0x6B175474E89094C44Da98b954EedeAC495271d0F;

        address master = WISE_DEPLOYER;

        address wiseOracleHub = address(
            ORACLE_HUB_INSTANCE
        );

        address nftContract = address(
            POSITION_NFTS_INSTANCE
        );

        address aave = 0x87870Bca3F3fD6335C3F4ce8392D69350B4fA4E2;

        _handleOracle();

        LENDING_INSTANCE = new TesterLending(
            master,
            wiseOracleHub,
            nftContract
        );

        AAVE_HUB_INSTANCE = new AaveHub(
            master,
            aave,
            address(LENDING_INSTANCE)
        );

        SECURITY_INSTANCE = new WiseSecurity(
            master,
            address(LENDING_INSTANCE),
            address(AAVE_HUB_INSTANCE)
        );

        LENDING_INSTANCE.setSecurity(
            address(SECURITY_INSTANCE)
        );

        AAVE_HUB_INSTANCE.setWiseSecurity(
            address(SECURITY_INSTANCE)
        );

        _handleCreatePool();

        AAVE_HUB_INSTANCE.setAaveTokenAddressBulk(
            aaveUnderlyingAssetsArray,
            aaveTokenArray
        );

        FEE_MANAGER_INSTANCE = FeeManager(
            address(
                SECURITY_INSTANCE.FEE_MANAGER()
            )
        );

        address[] memory feeAddresses = new address[](7);
        uint256[] memory feeValues = new uint256[](7);

        for (uint256 i = 0; i < feeValues.length; i++) {
            feeValues[i] = 1E17;
        }

        feeAddresses[0] = 0x83F20F44975D03b1b09e64809B757c47f942BEeA;
        feeAddresses[1] = 0x98C23E9d8f34FEFb1B7BD6a91B7FF122F4e16F5c;
        feeAddresses[2] = 0x23878914EFE38d27C4D67Ab83ed1b93A74D4086a;
        feeAddresses[3] = 0x018008bfb33d285247A21d44E50697654f754e63;
        feeAddresses[4] = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
        feeAddresses[5] = 0xdAC17F958D2ee523a2206206994597C13D831ec7;
        feeAddresses[6] = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;

        FEE_MANAGER_INSTANCE.setPoolFeeBulk(
            feeAddresses,
            feeValues
        );

        FEE_MANAGER_INSTANCE.setAaveFlagBulk(
            aaveTokenArray,
            aaveUnderlyingAssetsArray
        );

        vm.stopPrank();
    }

    function _handleCreatePool()
        internal
    {
        PoolManager.CreatePool[] memory createPoolArray = new PoolManager.CreatePool[](12);

        // good to add pool name details
        createPoolArray[0] = PoolManager.CreatePool(
            {
                allowBorrow: true,
                // good to put token name
                poolToken: 0xdAC17F958D2ee523a2206206994597C13D831ec7,
                poolMulFactor: 17500000000000000,
                poolCollFactor: 740000000000000000,
                maxDepositAmount: 2000000000000000000000000
            }
        );

        // good to add pool name details
        createPoolArray[1] = PoolManager.CreatePool(
            {
                allowBorrow: true,
                // good to put token name
                poolToken: 0x6B175474E89094C44Da98b954EedeAC495271d0F,
                poolMulFactor: 25000000000000000,
                poolCollFactor: 670000000000000000,
                maxDepositAmount: 338000000000000000000000000
            }
        );

        // good to add pool name details
        createPoolArray[2] = PoolManager.CreatePool(
            {
                allowBorrow: true,
                // good to put token name
                poolToken: 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48,
                poolMulFactor: 15000000000000000,
                poolCollFactor: 770000000000000000,
                maxDepositAmount: 1760000000000
            }
        );

        // good to add pool name details
        createPoolArray[3] = PoolManager.CreatePool(
            {
                allowBorrow: true,
                poolToken: WETH_ADDRESS,
                poolMulFactor: 17500000000000000,
                poolCollFactor: 805000000000000000,
                maxDepositAmount: 1800000000000000000000000
            }
        );

        // good to add pool name details
        createPoolArray[4] = PoolManager.CreatePool(
            {
                allowBorrow: true,
                // good to put token name
                poolToken: 0x4d5F47FA6A74757f35C14fD3a6Ef8E3C9BC514E8,
                poolMulFactor: 17500000000000000,
                poolCollFactor: 805000000000000000,
                maxDepositAmount: 1800000000000000000000000
            }
        );

        // good to add pool name details
        createPoolArray[5] = PoolManager.CreatePool(
            {
                allowBorrow: true,
                // good to put token name
                poolToken: 0x98C23E9d8f34FEFb1B7BD6a91B7FF122F4e16F5c,
                poolMulFactor: 15000000000000000,
                poolCollFactor: 770000000000000000,
                maxDepositAmount: 1760000000000
            }
        );

        // good to add pool name details
        createPoolArray[6] = PoolManager.CreatePool(
            {
                allowBorrow: true,
                // good to put token name
                poolToken: 0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0,
                poolMulFactor: 17500000000000000,
                poolCollFactor: 805000000000000000,
                maxDepositAmount: 600000000000000000000000
            }
        );

        // good to add pool name details
        createPoolArray[7] = PoolManager.CreatePool(
            {
                allowBorrow: true,
                // good to put token name
                poolToken: 0x23878914EFE38d27C4D67Ab83ed1b93A74D4086a,
                poolMulFactor: 17500000000000000,
                poolCollFactor: 740000000000000000,
                maxDepositAmount: 2000000000000000000000000
            }
        );

        // good to add pool name details
        createPoolArray[8] = PoolManager.CreatePool(
            {
                allowBorrow: true,
                // good to put token name
                poolToken: 0x018008bfb33d285247A21d44E50697654f754e63,
                poolMulFactor: 25000000000000000,
                poolCollFactor: 670000000000000000,
                maxDepositAmount: 338000000000000000000000000
            }
        );

        // good to add pool name details
        createPoolArray[9] = PoolManager.CreatePool(
            {
                allowBorrow: true,
                // good to put token name
                poolToken: 0x5Ee5bf7ae06D1Be5997A1A72006FE6C607eC6DE8,
                poolMulFactor: 10000000000000000,
                poolCollFactor: 730000000000000000,
                maxDepositAmount: 4300000000000
            }
        );

        // good to add pool name details
        createPoolArray[10] = PoolManager.CreatePool(
            {
                allowBorrow: true,
                // good to put token name
                poolToken: 0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599,
                poolMulFactor: 10000000000000000,
                poolCollFactor: 730000000000000000,
                maxDepositAmount: 4300000000000
            }
        );

        // good to add pool name details
        createPoolArray[11] = PoolManager.CreatePool(
            {
                allowBorrow: true,
                // good to put token name
                poolToken: 0x83F20F44975D03b1b09e64809B757c47f942BEeA,
                poolMulFactor: 25000000000000000,
                poolCollFactor: 770000000000000000,
                maxDepositAmount: 338000000000000000000000000
            }
        );

        for (uint256 i = 0; i < createPoolArray.length;) {

            LENDING_INSTANCE.createPool(
                createPoolArray[i]
            );

            unchecked {
                i++;
            }
        }
    }

    function _handleOracle()
        internal
    {
        uint256 SIZE = 18;

        address[] memory tokenAddresses = new address[](SIZE);
        IPriceFeed[] memory priceFeedAddresses = new IPriceFeed[](SIZE);
        address[][] memory underlyingFeeds = new address[][](SIZE);

        // Token: WETH (0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2) on Ethereum
        tokenAddresses[0] = WETH_ADDRESS;

        // Feed: https://data.chain.link/ethereum/mainnet/crypto-usd/eth-usd
        priceFeedAddresses[0] = IPriceFeed(
            0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
        );

        // Token: Aave WETH Ethereum (aEthWETH)
        tokenAddresses[1] = 0x4d5F47FA6A74757f35C14fD3a6Ef8E3C9BC514E8;

        // Feed: https://data.chain.link/ethereum/mainnet/crypto-usd/eth-usd
        priceFeedAddresses[1] = IPriceFeed(
            0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
        );

        // Token: USDC (USDC) on Ethereum
        tokenAddresses[2] = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;

        // https://data.chain.link/ethereum/mainnet/stablecoins/usdc-usd
        priceFeedAddresses[2] = IPriceFeed(
            0x8fFfFfd4AfB6115b954Bd326cbe7B4BA576818f6
        );

        // Token: Aave Ethereum USDC (aEthUSDC)
        tokenAddresses[3] = 0x98C23E9d8f34FEFb1B7BD6a91B7FF122F4e16F5c;

        // https://data.chain.link/ethereum/mainnet/stablecoins/usdc-usd
        priceFeedAddresses[3] = IPriceFeed(
            0x8fFfFfd4AfB6115b954Bd326cbe7B4BA576818f6
        );

        // Token: DAI Stablecoin (DAI) on Ethereum
        tokenAddresses[4] = 0x6B175474E89094C44Da98b954EedeAC495271d0F;

        // https://data.chain.link/ethereum/mainnet/stablecoins/dai-usd
        priceFeedAddresses[4] = IPriceFeed(
            0xAed0c38402a5d19df6E4c03F4E2DceD6e29c1ee9
        );

        // Token: Aave Ethereum DAI (aEthDAI)
        tokenAddresses[5] = 0x018008bfb33d285247A21d44E50697654f754e63;

        // https://data.chain.link/ethereum/mainnet/stablecoins/dai-usd
        priceFeedAddresses[5] = IPriceFeed(
            0xAed0c38402a5d19df6E4c03F4E2DceD6e29c1ee9
        );

        // Token: Wrapped liquid staked Ether 2.0 (wstETH)
        tokenAddresses[6] = 0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0;

        // Derivatice Oracle: WstETHOracle (by WISE Team)
        priceFeedAddresses[6] = IPriceFeed(
            0xC42e9F1Aa22f78bC585e6911424c6B4936674e08
        );

        // Token: Tether USD (USDT) on Ethereum
        tokenAddresses[7] = 0xdAC17F958D2ee523a2206206994597C13D831ec7;

        // https://data.chain.link/ethereum/mainnet/stablecoins/usdt-usd
        priceFeedAddresses[7] = IPriceFeed(
            0x3E7d1eAB13ad0104d2750B8863b489D65364e32D
        );

        // Token: Aave Ethereum USDT (aEthUSDT)
        tokenAddresses[8] = 0x23878914EFE38d27C4D67Ab83ed1b93A74D4086a;

        // https://data.chain.link/ethereum/mainnet/stablecoins/usdt-usd
        priceFeedAddresses[8] = IPriceFeed(
            0x3E7d1eAB13ad0104d2750B8863b489D65364e32D
        );

        // Token: Magic Internet Money (MIM) on Ethereum
        tokenAddresses[9] = 0x99D8a9C45b2ecA8864373A26D1459e3Dff1e17F3;

        // MIM:USD Feed (https://docs.chain.link/data-feeds/price-feeds/addresses?network=ethereum&page=1&search=MIM)
        priceFeedAddresses[9] = IPriceFeed(
            0x7A364e8770418566e3eb2001A96116E6138Eb32F
        );

        // Token: Wrapped BTC (WBTC)
        tokenAddresses[10] = 0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599;

        // Derivative WBTCOracle (by WISE Team) on Ethereum
        priceFeedAddresses[10] = IPriceFeed(
            0x96FF7a7C519cdEc9e42280c93cB0E32bCeCD4E65
        );

        // Token: DecimalPlaceHolder
        tokenAddresses[11] = 0xA3b580D30c56580A04Ac42646bc2D34FC3913983;

        // https://data.chain.link/ethereum/mainnet/crypto-other/wbtc-btc
        priceFeedAddresses[11] = IPriceFeed(
            0xfdFD9C85aD200c506Cf9e21F1FD8dd01932FBB23
        );

        // Token: DecimalPlaceHolder
        tokenAddresses[12] = 0xFd9bCed9b0027dB9fa42Ef0cCA37C0D683B733C3;

        // https://data.chain.link/ethereum/mainnet/crypto-usd/btc-usd
        priceFeedAddresses[12] = IPriceFeed(
            0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c
        );

        // Savings Dai (sDAI) on Ethereum
        tokenAddresses[13] = 0x83F20F44975D03b1b09e64809B757c47f942BEeA;

        // Derivative Oracle SDAIOracle (by WISE Team) on Ethereum
        priceFeedAddresses[13] = IPriceFeed(
            0x9a8EAA4097102d3DD86f4b66904674f82522768e
        );

        // Token: Moo Convex MIM (mooConvex...) on Ethereum
        tokenAddresses[14] = 0xd5bAd7c89028B3F7094e40DcCe83D4e6b3Fd9AA4;

        // Derivative Oracle MooOracleCurve (by WISE Team) on Ethereum
        priceFeedAddresses[14] = IPriceFeed(
            0x09c68b09Fe0801C760f70f5df33881301Ff7ECFd
        );

        // Token: Moo Convex TriCryptoUSDC (mooConvex...) on Ethereum
        tokenAddresses[15] = 0xD1BeaD7CadcCC6b6a715A6272c39F1EC54F6EC99;

        // Derivative Oracle MooOracleCurve (by WISE Team) on Ethereum
        priceFeedAddresses[15] = IPriceFeed(
            0x893F8fC622895457e96C6Fd3143A786c398DF0cA
        );

        // Token: Moo Convex TriCrypto (mooConvex...) on Ethereum
        tokenAddresses[16] = 0xe50e2fe90745A8510491F89113959a1EF01AD400;

        // Derivative Oracle MooOracleCurve (by WISE Team) on Ethereum
        priceFeedAddresses[16] = IPriceFeed(
            0x897DB44Ff11C5848069e8247dc73282c834c86d7
        );

        // Token: Aave Ethereum WBTC (aEthWBTC) on Ethereum
        tokenAddresses[17] = 0x5Ee5bf7ae06D1Be5997A1A72006FE6C607eC6DE8;

        // good to put feed name
        priceFeedAddresses[17] = IPriceFeed(
            0x96FF7a7C519cdEc9e42280c93cB0E32bCeCD4E65
        );

        underlyingFeeds[0] = new address[](0);
        underlyingFeeds[1] = new address[](0);
        underlyingFeeds[2] = new address[](0);
        underlyingFeeds[3] = new address[](0);
        underlyingFeeds[4] = new address[](0);
        underlyingFeeds[5] = new address[](0);
        underlyingFeeds[6] = new address[](0);
        underlyingFeeds[7] = new address[](0);
        underlyingFeeds[8] = new address[](0);
        underlyingFeeds[9] = new address[](0);
        underlyingFeeds[10] = new address[](2);
        underlyingFeeds[10][0] = 0xFd9bCed9b0027dB9fa42Ef0cCA37C0D683B733C3;
        underlyingFeeds[10][1] = 0xA3b580D30c56580A04Ac42646bc2D34FC3913983;
        underlyingFeeds[11] = new address[](0);
        underlyingFeeds[12] = new address[](0);
        underlyingFeeds[13] = new address[](0);
        underlyingFeeds[14] = new address[](4);
        underlyingFeeds[14][0] = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
        underlyingFeeds[14][1] = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
        underlyingFeeds[14][2] = 0xdAC17F958D2ee523a2206206994597C13D831ec7;
        underlyingFeeds[14][3] = 0x99D8a9C45b2ecA8864373A26D1459e3Dff1e17F3;
        underlyingFeeds[15] = new address[](4);
        underlyingFeeds[15][0] = 0xFd9bCed9b0027dB9fa42Ef0cCA37C0D683B733C3;
        underlyingFeeds[15][1] = 0xA3b580D30c56580A04Ac42646bc2D34FC3913983;
        underlyingFeeds[15][2] = WETH_ADDRESS;
        underlyingFeeds[15][3] = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
        underlyingFeeds[16] = new address[](4);
        underlyingFeeds[16][0] = 0xFd9bCed9b0027dB9fa42Ef0cCA37C0D683B733C3;
        underlyingFeeds[16][1] = 0xA3b580D30c56580A04Ac42646bc2D34FC3913983;
        underlyingFeeds[16][2] = WETH_ADDRESS;
        underlyingFeeds[16][3] = 0xdAC17F958D2ee523a2206206994597C13D831ec7;
        underlyingFeeds[17] = new address[](2);
        underlyingFeeds[17][0] = 0xFd9bCed9b0027dB9fa42Ef0cCA37C0D683B733C3;
        underlyingFeeds[17][1] = 0xA3b580D30c56580A04Ac42646bc2D34FC3913983;

        ORACLE_HUB_INSTANCE.addOracleBulk(
            tokenAddresses,
            priceFeedAddresses,
            underlyingFeeds
        );

        uint256 i;
        uint256 l = tokenAddresses.length;
        uint256 reclibrateTokenAddressesLength;

        for (i; i < l;) {
            if (underlyingFeeds[i].length == 0) {
                reclibrateTokenAddressesLength++;
            }
            unchecked {
                ++i;
            }
        }

        address[] memory reclibrateTokenAddresses = new address[](
            reclibrateTokenAddressesLength
        );

        uint256 k;
        for (i = 0; i < l;) {
            if (underlyingFeeds[i].length == 0) {
                reclibrateTokenAddresses[k] = tokenAddresses[i];
                unchecked {
                    ++k;
                }
            }
            unchecked {
                ++i;
            }
        }
        ORACLE_HUB_INSTANCE.recalibrateBulk(
            reclibrateTokenAddresses
        );
    }

    receive()
        external
        payable
    {}

    function setUp()
        public
    {
        _deployNewWiseLending();
    }

    function testSetSecurityWorker()
        public
    {
        vm.expectRevert(
            NotAllowedEntity.selector
        );

        SECURITY_INSTANCE.securityShutdown();

        vm.prank(
            WISE_DEPLOYER
        );

        SECURITY_INSTANCE.setSecurityWorker(
            address(this),
            true
        );

        SECURITY_INSTANCE.securityShutdown();

        vm.prank(
            WISE_DEPLOYER
        );

        SECURITY_INSTANCE.setSecurityWorker(
            address(this),
            false
        );

        vm.expectRevert(
            NotAllowedEntity.selector
        );

        SECURITY_INSTANCE.securityShutdown();
    }

    function testSecurityShutdown()
        public
    {
        uint256 depositValue = 10 ether;
        uint256 borrowAmount = 2 ether;
        uint256 paybackAmount = 1 ether;
        uint256 withdrawAmount = 1 ether;

        uint256 depositValueWbtc = 1E8;

        address daiAddress = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
        address wbtcAddress = 0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599;

        POSITION_NFTS_INSTANCE.mintPosition();

        uint256 nftId = POSITION_NFTS_INSTANCE.tokenOfOwnerByIndex(
            address(this),
            0
        );

        LENDING_INSTANCE.depositExactAmountETH{value: depositValue}(
            nftId
        );

        LENDING_INSTANCE.borrowExactAmountETH(
            nftId,
            borrowAmount
        );

        vm.prank(
            WISE_DEPLOYER
        );

        SECURITY_INSTANCE.securityShutdown();

        assertEq(
            SECURITY_INSTANCE.wasBlacklisted(WETH_ADDRESS),
            true,
            "WETH pool should be blacklisted."
        );

        vm.expectRevert(
            TokenBlackListed.selector
        );

        vm.roll(
            block.number + 1
        );

        LENDING_INSTANCE.depositExactAmountETH{
            value: depositValue
        }(
            nftId
        );

        vm.expectRevert(
            TokenBlackListed.selector
        );

        vm.warp(
            block.timestamp + 1 minutes
        );

        LENDING_INSTANCE.borrowExactAmountETH(
            nftId,
            borrowAmount
        );

        LENDING_INSTANCE.paybackExactAmountETH{
            value: paybackAmount
        }(
            nftId
        );

        vm.expectRevert(
            OpenBorrowPosition.selector
        );

        vm.roll(
            block.number + 1
        );

        LENDING_INSTANCE.withdrawExactAmountETH(
            nftId,
            withdrawAmount
        );

        LENDING_INSTANCE.paybackExactAmountETH{
            value: 2 * paybackAmount
        }(
            nftId
        );

        vm.roll(
            block.number + 1
        );

        LENDING_INSTANCE.withdrawExactAmountETH(
            nftId,
            withdrawAmount
        );

        vm.expectRevert(
            TokenBlackListed.selector
        );

        LENDING_INSTANCE.depositExactAmount(
            nftId,
            daiAddress,
            depositValue
        );

        vm.roll(
            block.number + 1
        );

        vm.expectRevert(
            TokenBlackListed.selector
        );

        LENDING_INSTANCE.depositExactAmount(
            nftId,
            wbtcAddress,
            depositValueWbtc
        );
    }

    function testRevokeShutdown()
        public
    {
        uint256 depositValue = 10 ether;
        uint256 borrowAmount = 2 ether;
        uint256 withdrawAmount = 1 ether;

        POSITION_NFTS_INSTANCE.mintPosition();

        uint256 nftId = POSITION_NFTS_INSTANCE.tokenOfOwnerByIndex(
            address(this),
            0
        );

        LENDING_INSTANCE.depositExactAmountETH{value: depositValue}(
            nftId
        );

        vm.prank(
            WISE_DEPLOYER
        );

        SECURITY_INSTANCE.setSecurityWorker(
            address(this),
            true
        );

        SECURITY_INSTANCE.securityShutdown();

        vm.expectRevert(
            TokenBlackListed.selector
        );

        LENDING_INSTANCE.depositExactAmountETH{value: depositValue}(
            nftId
        );

        vm.expectRevert(
            TokenBlackListed.selector
        );

        LENDING_INSTANCE.borrowExactAmountETH(
            nftId,
            borrowAmount
        );

        vm.expectRevert(
            NotMaster.selector
        );

        SECURITY_INSTANCE.revokeShutdown();

        vm.prank(
            WISE_DEPLOYER
        );

        SECURITY_INSTANCE.revokeShutdown();

        LENDING_INSTANCE.borrowExactAmountETH(
            nftId,
            borrowAmount
        );

        LENDING_INSTANCE.depositExactAmountETH{value: depositValue}(
            nftId
        );

        LENDING_INSTANCE.withdrawExactAmountETH(
            nftId,
            withdrawAmount
        );
    }
}