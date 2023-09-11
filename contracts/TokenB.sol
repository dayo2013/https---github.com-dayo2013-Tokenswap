// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;
 import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

 contract TokenB is ERC20{
    constructor() ERC20("pumping","pmp"){
        _mint(msg.sender,20_000e18);
    }
}
