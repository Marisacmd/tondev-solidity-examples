pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract Queue {

        string[] storedData = [];

	constructor() public {
		require(tvm.pubkey() != 0, 101);
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
	}

	modifier checkOwnerAndAccept {
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
		_;
	}

    function putHimInQueue(string x) public checkOwnerAndAccept{
        storedData.push(x);
    }

    function callNext() public checkOwnerAndAccept{
        storedData[0] = storedData[storedData.length - 1];
        storedData.pop();
    
    }

    function viewQueue() public checkOwnerAndAccept view returns (string[]){
        return storedData;
    }


}
