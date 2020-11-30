source .hlc.env
if [ -z $SAMPLE_CC ] ; then
export CC_LABLNAME="${SAMPLE_CC,,}"
echo $CC_LABLNAME
else
export CC_LABLNAME="marbles"
fi
echo  "  Initiating ......"

export CC_LABLNAME="${SAMPLE_CC,,}"
echo $CC_LABLNAME

export PEER_CONN_PARMS="--peerAddresses {PEER_NAME0}-{ORG_1}:7051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/{ORG_1}/peers/{PEER_NAME0}-{ORG_1}/tls/ca.crt"
export PEER_CONN_PARMS1="--peerAddresses {PEER_NAME0}-{ORG_2}:9051 --tlsRootCertFiles /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/{ORG_2}/peers/{PEER_NAME0}-{ORG_2}/tls/ca.crt"
sleep 5
peer chaincode invoke -o {ORD_NAME0}:7050 --isInit --tls true --cafile $ORDERER_CA -C {CHANNEL_NAME1}  -n  $CC_LABLNAME $PEER_CONN_PARMS $PEER_CONN_PARMS1 -c '{"Args":["initMarble","marble1","blue","35","tom"]}'
echo ""
sleep 5
echo -e $PCOLOR"Invoke transaction by creating a new CAR from {ORG_1} "$NONE
peer chaincode invoke -o {ORD_NAME0}.{DOMAIN_NAME}:7050 --tls --cafile $ORDERER_CA -C {CHANNEL_NAME1} -n $CC_LABLNAME $PEER_CONN_PARMS $PEER_CONN_PARMS1 -c  '{"function": "createCar","Args":["Battery-Car", "Tesla", "A100", "Bright-Red", "vinayag"]}'

echo ""
echo  "  Querying all asset "
echo ""
sleep 5
peer chaincode query -C {CHANNEL_NAME1} -n  $CC_LABLNAME -c '{"Args":["queryCar","CAR0"]}' 
echo ""

sleep 3
echo " Querying the asset from {ORG_1}"
echo ""
peer chaincode query -C {CHANNEL_NAME1} -n  $CC_LABLNAME -c '{"Args":["readMarble","marble1"]}'


