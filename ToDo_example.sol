pragma ton - solidity >= 0.35 .0;
pragma AbiHeader expire;

contract ToDo {

    int8 idkey = 0;
    int8 undoneCounter;

    struct task {
        string taskName;
        uint32 timeAdded;
        bool readiness;
    }

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

    mapping(int8 => task) public allTasks;

    function counter() public checkOwnerAndAccept returns(int8) {
        return idkey = idkey + 1;
    }

    function addTask(string taskName) public checkOwnerAndAccept returns(mapping(int8 => task)) {
        counter();
        task myTask = task(taskName, now, false);
        allTasks[idkey] = myTask;
        return allTasks;
    }

    function showAllTasks() public checkOwnerAndAccept view returns(mapping(int8 => task)) {
        return allTasks;
    }

    function getTaskDescByKey(int8 key) public checkOwnerAndAccept view returns(task) {
        return allTasks[key];
    }

    function getNumberOfTasksOpened() public checkOwnerAndAccept returns(int8) {
        for (int8 i = 0; i <= idkey; i++) {
            if (allTasks[i].readiness == false) {
                undoneCounter = undoneCounter + 1;
            }
        }
        return undoneCounter;
    }

    function changeTasksStatus(int8 key) public checkOwnerAndAccept returns(mapping(int8 => task)) {
        allTasks[key].readiness = true;
        return allTasks;
    }

    function deleteTask(int8 key) public checkOwnerAndAccept returns(mapping(int8 => task)) {
        delete allTasks[key];
        return allTasks;
    }

}