export CHANNEL_NAME=mychannel
peer channel create -o orderer0.orderer.com:7050 -c $CHANNEL_NAME -f ./channel-artifacts/mychannel.tx 
peer channel join -b mychannel.block 
export CORE_PEER_ADDRESS=peer1.example.com:7051
peer channel join -b mychannel.block
export CORE_PEER_ADDRESS=peer0.example.com:7051

peer chaincode install -n mycc -v 1.0 -p github.com/chaincode/mycc/
export CORE_PEER_ADDRESS=peer1.example.com:7051
peer chaincode install -n mycc -v 1.0 -p github.com/chaincode/mycc/
export CORE_PEER_ADDRESS=peer0.example.com:7051

peer chaincode instantiate -o orderer0.orderer.com:7050 -C $CHANNEL_NAME -n mycc -v 1.0 -c '{"Args":[""]}' -P "AND ('exampleMSP.peer')"
sleep 5
peer chaincode invoke -o orderer0.orderer.com:7050 -C $CHANNEL_NAME -n mycc  -c '{"Args":["initLedger"]}'


