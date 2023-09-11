// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

interface ISWAP{
    function readReserveA() external view returns (uint _reserveA);

    function readReserveB() external view returns (uint _reserveB);

    function addLiquidity(
        uint amountA,
        uint amountB
    ) external returns (bool success);

    function removeLiquidity(
        uint amountA,
        uint amountB
    ) external returns (bool success);

     function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) external returns (bool success);


    function transfer(
        address _to,
        uint256 _value
    ) external returns (bool success);


    function expectedTokenBAmounts(
        uint tokenA_Amount
    ) external returns (uint _returnedValue);

    function expectedTokenAAmounts(
        uint tokenB_Amount
    ) external returns (uint _returnedValue);

    function swapTokenAForTokenB(
        uint tokenA_Amount
    ) external returns (bool success);

    function swapTokenBForTokenA(
        uint tokenB_Amount
    ) external returns (bool success);

    event _LiquidityAdded(address _liquidityAdder, uint amountA, uint amountB);
    event _LiquidityRemoved(
        address _liquidityRemover,
        uint amountA,
        uint amountB
    );
    event _TokenASwapped(address swapper, uint amountA);
    event _TokenBSwapped(address swapper, uint amountB);
}