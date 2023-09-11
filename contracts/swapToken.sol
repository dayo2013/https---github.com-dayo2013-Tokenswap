// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;
 import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

 import "./Interface/IERC20.sol";
 import "./Interface/ISWAP.sol";

 contract DySwap{
    //a state variable that sets the reserveA amount
    uint reserveA;

    //a state variable that sets the reserveB amount
    uint reserveB;

    // a struct that contains the liquidity provider
    struct LiquidityProvider {
        uint AmountA;
        uint AmountB;
    }

    //a mapping of address to its total amounts added to liquidity
    mapping(address => LiquidityProvider) liquidityProvider;
    mapping(address => bool) liquidityProviderStatus;

    //the contract address of tokenA
    IERC20 tokenA;
    //the contract address of tokenB
    IERC20 tokenB;

    constructor(address _tokenA, address _tokenB) {
        //set the contract address of token A by using the constructor argument
        tokenA = IERC20(_tokenA);
        //set the contract address of token B by using the constructor argument
        tokenB = IERC20(_tokenB);
    }

    function addLiquidity(
        uint amountA,
        uint amountB
    ) external returns (bool _success) {
        require(amountA > 0 || amountB > 0, "Zero Amounts");

        //get the amount of token A set by the provider
        IERC20(tokenA).transferFrom(msg.sender, address(this), amountA);

        //get the amount of token B set by the provider
        IERC20(tokenB).transferFrom(msg.sender, address(this), amountB);

        //increases total of reserveA by the amount of token A set by the provider
        reserveA += amountA;
        //increases total of reserveB by the amount of token B set by the provider
        reserveB += amountB;

        LiquidityProvider storage provider = liquidityProvider[msg.sender];
        provider.AmountA += amountA;
        provider.AmountB += amountB;

        //this sets that account has added liquidity
        liquidityProviderStatus[msg.sender] = true;

        _success = true;

        
    }

    function removeLiquidity(
        uint amountA,
        uint amountB
    ) external returns (bool _success) {
        require(liquidityProviderStatus[msg.sender], "Unknown Provider");
        require(amountA > 0 || amountB > 0, "Zero Amounts");

        //send back the amount of token A set by the provider
        if (amountA > 0) {
            IERC20(tokenA).transfer(msg.sender, amountA);
        }

        //send back the amount of token B set by the provider
        if (amountB > 0) {
            IERC20(tokenA).transfer(msg.sender, amountB);
        }

        //send back the amount of token A set by the provider
        if (amountA > 0) {
            //increases total of reserveA by the amount of token A set by the provider
            reserveA -= amountA;
        }

        //decrease the total amount of reserveA by the amount of token A set by the provider
        if (amountB > 0) {
            //decrease the total amount of reserveB by the amount of token B set by the provider
            reserveB -= amountB;
        }

        LiquidityProvider storage provider = liquidityProvider[msg.sender];
        provider.AmountA -= amountA;
        provider.AmountB -= amountB;

        _success = true;

        
    }

    function swapTokenAForTokenB(uint amountA) external returns (bool success) {
        require(amountA > 0, "Zero Amount");
        uint expectedTokenB = calculateTokenBReturnsForTokenA(amountA);
        reserveA += amountA;
        reserveB -= expectedTokenB;

        IERC20(tokenA).transferFrom(msg.sender, address(this), amountA);

        IERC20(tokenB).transfer(msg.sender, expectedTokenB);

        success = true;
        require(success, "Swapping Failed");
        
    }

    function swapTokenBForTokenA(uint amountB) external returns (bool success) {
        require(amountB > 0, "Zero Amount");
        uint expectedTokenA = calculateTokenAReturnsForTokenB(amountB);
        reserveB += amountB;
        reserveA -= expectedTokenA;

        IERC20(tokenB).transferFrom(msg.sender, address(this), amountB);

        IERC20(tokenA).transfer(msg.sender, expectedTokenA);

        success = true;
        require(success, "Swapping Failed");
        
    }

    function calculateTokenAReturnsForTokenB(
        uint amountB
    ) internal view returns (uint expectedAmount) {
        //formula implementing the x * y = k formula for calculating the return value for A
        expectedAmount = (reserveA -
            ((reserveA * reserveB) / (reserveB + (reserveB - amountB))));
    }

    function calculateTokenBReturnsForTokenA(
        uint amountA
    ) internal view returns (uint expectedAmount) {
        //formula implementing the x * y = k formula for calculating the return value for B
        expectedAmount = (reserveB -
            ((reserveA * reserveB) / (reserveA + (reserveA - amountA))));
    }

    //get expected amount before swapping Token A for Token B
    function expectedTokenBAmounts(
        uint tokenA_Amount
    ) external view returns (uint _returnedValue) {
        _returnedValue = calculateTokenBReturnsForTokenA(tokenA_Amount);
    }

    //get expected amount before swapping Token B for Token A
    function expectedTokenAAmounts(
        uint tokenB_Amount
    ) external view returns (uint _returnedValue) {
        _returnedValue = calculateTokenBReturnsForTokenA(tokenB_Amount);
    }

    //read total amount in reserveA
    function readReserveA() external view returns (uint _reserveA) {
        _reserveA = reserveA;
    }

    //read total amount in reserveA
    function readReserveB() external view returns (uint _reserveB) {
        _reserveB = reserveB;
    }
}
 
    

