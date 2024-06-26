## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
forge --help
anvil --help
cast --help
```

## Remapping

you can run and install everything with

```shell
make all
```
or use commands below and also use the yarn option

```shell
forge remappings
forge install transmissions11/solmate
forge update lib/solmate
forge remove solmate

yarn
yarn add @openzeppelin/contracts
```

# Workshop

# Chisel

Examples can be found in the Ressources section

## Anvil

to run a local node run

```shell
make anvil
```

You can fork the mainnet and print DAI with this command

```shell
make test_whale
```

Example:
`test/Whale.t.sol`

## Invariant & Fuzz Testing

In Foundry: 
- Fuzz Tests = Random Data to one function
- Invariant Tests = Random Data & Random Function Calls to many functions

### Invariant test

command line:
```shell
make test_inv
```

Example:
`test/WETH9.invariants.t.sol`

## Differential Testing

To run the python file `exp.py`:

```python
python exp.py 18446744073709551616
```

command line:
```shell
make test_diff
```

Example:
`test/Exp.differential.t.sol`

## Slither

command line:
```shell
slither .
```

## Ressources

https://book.getfoundry.sh/
https://mirror.xyz/horsefacts.eth/Jex2YVaO65dda6zEyfM_-DXlXhOWCAoSpOx5PLocYgw
https://github.com/Cyfrin/foundry-defi-stablecoin-f23
https://dev.to/stefanalfbo/foundry-chisel-ggl

