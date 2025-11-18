check more about

--broadcast 
vm


 if we dont add broadcast it wont send it will simulate seding it
forge script script/deploy-simple.s.sol --rpc-url http://127.0.0.1:8545 --broadcast (--private-key) or (account test) 



cast can actuall convert value from hexdecimal to real number
run
cast --to-base hexval dec


check on upcodes


// to interacet with out contract we can use cast command like this

// to send value
// cast send then the fn name in "" then the fn value  then private key
cast send 0x5FbDB2315678afecb367f032d93F642f64180aa3 "store(uint256)" 123 --account test

to read value
cast call 0x5FbDB2315678afecb367f032d93F642f64180aa3 "retrive()" --account test




