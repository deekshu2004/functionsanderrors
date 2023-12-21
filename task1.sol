

// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// Created a Contract named StudentDatabase
contract StudentDatabase {
    error ProfileDoesNotExist();

    struct Student {
        string name;
        uint256 age;
        string toolused;
    }

    mapping(address => Student) public students;

// Used to create a studentprofile
    function createProfile(
        string memory _name,
        uint256 _age,
        string memory _toolused
    ) public {
        // Here we are declaring require statement where it checks that the name should be greater than 4 letters 
        // Else it gives a error stating name should be greater than 4 letters 
        require(bytes(_name).length > 4, "Name greater than 4 letters");
// And here it checks that the age entered should not be zero
        require(_age != 0, "Age cannot be Zero");

        require(
            bytes(_toolused).length > 4,
            "toolused  greater than 4 letters"
        );

        students[msg.sender] = Student(_name, _age, _toolused);
    }
// Here we are creating a function to check that the name is matching or not if not it will revert the transaction
    function confirmName(string calldata _name) public view {
        string memory name = students[msg.sender].name;
        assert(
            keccak256(abi.encodePacked(name)) ==
                keccak256(abi.encodePacked(_name))
        );
    }
//  Here we are creating a function to check that the entered age is matching or not else it will revert the transaction
    function confirmStudentAge(uint _age) public view {
        assert(students[msg.sender].age == _age);
    }
// This function is used to confirm the tool used
    function confirmStudenttoolused(string calldata _toolused) public view {
        string memory toolused = students[msg.sender].toolused;
        assert(
            keccak256(abi.encodePacked(toolused)) ==
                keccak256(abi.encodePacked(_toolused))
        );
    }
// Here this function is used to update the profile 
    function updateProfile(
        string memory _name,
        uint256 _age,
        string memory _toolused
    ) public {
        require(
            bytes(students[msg.sender].name).length != 0,
            "Profile does not exist"
        );
        students[msg.sender] = Student(_name, _age, _toolused);
    }
// Here we have created a function to delete the profile 
    function deleteProfile() public {
        // if we enter wrong details it will revert the transaction 
        if (bytes(students[msg.sender].name).length == 0)
            revert ProfileDoesNotExist();

        delete students[msg.sender];
    }
// Function used to view the profile 
    function viewProfile()
        public
        view
        returns (string memory, uint256, string memory)
    {
        if (bytes(students[msg.sender].name).length == 0)
            revert ProfileDoesNotExist();
        return (
            students[msg.sender].name,
            students[msg.sender].age,
            students[msg.sender].toolused
        );
    }
}
