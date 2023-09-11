// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import  {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenA is ERC20{
    constructor() ERC20("Dypumping","DYtoken"){
        _mint(msg.sender,20_000e18);
    }
}
