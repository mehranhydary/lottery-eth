pragma solidity ^0.6.1;

contract Lottery {
    address public manager;
    address payable[] public players;
    
    constructor() public {
        manager = msg.sender;
    }
    
    function enter() public payable {
        require(msg.value > 0.1 ether, "Please send more than 0.1 ether to this contract");
        players.push(msg.sender);
    }
    
    function random() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players)));
    }
    
    function pickWinner() public restricted {
        uint index = random() % players.length;
        players[index].transfer(address(this).balance);
        players = new address payable[](0);
    }
    function getPlayers() public view returns(address payable[] memory) {
        return players;
    }
    
    modifier restricted() {
        require(msg.sender == manager, "Only the manager of this lottery can call this function");
        _;
    }
}