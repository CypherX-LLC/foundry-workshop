// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "forge-std/interfaces/IERC20.sol";

contract ForkTest is Test {
    IERC20 public dai;

    function setUp() public {
        // mainnet address of dai contract
        dai = IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F);
    }

    function testDeposit() public {
        address cryptoson = address(123);

        uint256 balBefore = dai.balanceOf(cryptoson);
        console.log("balance before", balBefore);

        uint256 totalBefore = dai.totalSupply();
        console.log("total supply before", totalBefore / 1e18);

        // token, account, amount, adjust total supply
        deal(address(dai), cryptoson, 2e6 * 1e18, true);

        uint256 balAfter = dai.balanceOf(cryptoson);
        console.log("balance after", balAfter / 1e18);

        uint256 totalAfter = dai.totalSupply();
        console.log("total supply after", totalAfter / 1e18);

        console.log(unicode"congrats you are rich 🤑");
    }
}