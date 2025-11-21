

for use to see our log for console.log 
we need to add -vv to the forge test
forget test -vv

to get the root cause of a failed test addanother v to the -vv = -vvv

 to test specific fn  in the log we use

forget test --match-test function or variable name-vvv





 type of test

 unit test
   --testing spesicfic part of our code
 intergration test
 forked test
   -- is testig code on simulated real environment 
 stagging test
   -- testing our code in a real environment not production
 


 //simulate a real environment and get it value for us

 --fork-url rpc-url


 //downside of fork
 we make alot of api calls to alcamy which can run out our bill



use deploy our own mock localy it have the data copy for what all those once on real chain, 
we deploy it to our local avail so we can access it from their withou having to provide  --fork-url rpc url


check more on casting uint160 to address


so we use chisel to write solidity in terminal