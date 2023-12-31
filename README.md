# Function and ErrorHandler in Smart Contract

This is a smart contract that implements the `require()`, `assert()` and `revert()` statements to handle errors in Student DataBase in solidity smart contract

## Contract Details

### Student Struct

```sh
 struct Student {
        string name;
        uint256 age;
        string techStack;
    }
```

### students mapping

```sh
 mapping(address => Student) public students;
```

The `students` is the mapping (storage variable) that stores the details of the student.

### createStudentProfile

The `createStudentProfile` function allows that allows a student to create a profile. It uses the `require` statements to check that the student `name` and `techStack` is greater than 4 letters and `age` is not equal to zero.

```sh
function createStudentProfile(
        string memory _name,
        uint256 _age,
        string memory _techStack
    ) public {
        require(bytes(_name).length > 4, "Name greater than 4 letters");

        require(_age != 0, "Age cannot be Zero");

        require(
            bytes(_techStack).length > 4,
            "TechStack  greater than 4 letters"
        );

        students[msg.sender] = Student(_name, _age, _techStack);
    }
```

### confirmStudentName

The `confirmStudentName` functions uses the `assert` statement to compare and check that the input name from a user is the same as the name stored on the `students`storage database.

```sh
function confirmStudentName(string calldata _name) public view {
        string memory name = students[msg.sender].name;
        assert(
            keccak256(abi.encodePacked(name)) ==
                keccak256(abi.encodePacked(_name))
        );
    }
```

### deleteProfile

The `deleteProfile` function uses the `revert` statement to check if the student profile already exist. This is to ensure that a user can't delete a profile they haven't created.

```sh
 function deleteProfile() public {
        if (bytes(students[msg.sender].name).length == 0)
            revert ProfileDoesNotExist();

        delete students[msg.sender];
    }
```
### Author : Deekshitha
