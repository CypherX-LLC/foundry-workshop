pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
//import {InvariantTest} from "forge-std/InvariantTest.sol";
//import { StdInvariant } from "forge-std/StdInvariant.sol";
import {WETH9} from "../src/WETH9.sol";
import {Handler} from "./handlers/Handler.sol";

// the order matters, if Test, StdInvariant is used, will throw error
contract WETH9Invariants is Test {
    WETH9 public weth;
    Handler public handler;

    function setUp() public {
        weth = new WETH9();
        handler = new Handler(weth);
        // Don't forget to call targetContract! 
        // If we don't configure the fuzzer to filter for a given contract, 
        // it will fuzz all methods on all contracts created during setUp.
        targetContract(address(handler));
    }

/*     function invariant_wethSupplyIsAlwaysZero() public {
        assertEq(0, weth.totalSupply());
    } */

    // ETH can only be wrapped into WETH, WETH can only
    // be unwrapped back into ETH. The sum of the Handler's
    // ETH balance plus the WETH totalSupply() should always
    // equal the total ETH_SUPPLY.
    function invariant_conservationOfETH() public {
        assertEq(
          handler.ETH_SUPPLY(),
          address(handler).balance + weth.totalSupply()
        );
    }

    // The WETH contract's Ether balance should always
    // equal the sum of all the individual deposits
    // minus all the individual withdrawals
    function invariant_solvencyDeposits() public {
        assertEq(
          address(weth).balance,
          handler.ghost_depositSum() - handler.ghost_withdrawSum()
        );
    }

    // write test functions using helpers like assertEq
/*     function invariant_badInvariantThisShouldFail() public {
        assertEq(0, weth.totalSupply());
    }

    function test_zeroDeposit() public {
        weth.deposit{ value: 0 }();
        assertEq(0, weth.balanceOf(address(this)));
        assertEq(0, weth.totalSupply());
    } */
}