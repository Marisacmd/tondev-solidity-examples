pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract Multiplication {

	uint storedData=1;

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

    function multiplyStoredNumberByMyNumber(uint x) public checkOwnerAndAccept{
	require(1 <= x && x <= 10);
        storedData = storedData*x;
    }

    function getStoredNumber() public checkOwnerAndAccept view returns (uint) {
        return storedData;
    }

}
