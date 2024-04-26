pragma solidity ^0.8.19;

import {WETH9} from "../../src/WETH9.sol";
import {CommonBase} from "forge-std/Base.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {StdUtils} from "forge-std/StdUtils.sol";

contract Handler is CommonBase, StdCheats, StdUtils {
    WETH9 public weth;
    uint256 public ghost_depositSum;
    uint256 public ghost_withdrawSum;

    uint256 public constant ETH_SUPPLY = 120_500_000;

    // need an ETH balance in order to make a deposit. Let's deal some Ether
    constructor(WETH9 _weth) {
        weth = _weth;
        // A wrapper around the deal cheatcode that also works for most ERC-20 tokens.
        deal(address(this), ETH_SUPPLY);
    }


    function deposit(uint256 amount) public {
        amount = bound(amount, 0, address(this).balance);
        weth.deposit{ value: amount }();
        ghost_depositSum += amount;
    }

    // will transfer back native Ether to the caller
    function withdraw(uint256 amount) public {
        amount = bound(amount, 0, weth.balanceOf(address(this)));
        weth.withdraw(amount);
        ghost_withdrawSum += amount;
    }

    // receive ether
    receive() external payable {}

    // last way WETH can come into the world: by sending Ether directly to the WETH9 fallback function
    function sendFallback(uint256 amount) public {
        amount = bound(amount, 1, address(this).balance);
        (bool success,) = address(weth).call{ value: amount }("");
        require(success, "sendFallback failed");
        ghost_depositSum += amount;
    }




}