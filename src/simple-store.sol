// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract SimpleStroge {
    // if we dont asign val for this it default to 0

    // to be able to view favnum  wen deploy we need to add visbility type
    uint256 myfavnum;

    //

    struct Person {
        uint256 favnum;
        string name;
    }

    Person[] public personList;

    // now to be able to access user fav number just by getting thier name and returnin tier number
    // we use mapping similar to object

    mapping(string => uint256) public nameToFavNum;

    // memory and calldata are very similar //
    // memory value been pass to anf fn can be re asgined but calldata we cant do that, dat their major diff

    //they are use for storing temprary varables

    function addPersonNum(string memory _name, uint256 _favnum) external {
        //now we add the username and thier fav num to the mapping
        nameToFavNum[_name] = _favnum;

        Person memory favnum = Person({name: _name, favnum: _favnum});

        // you can push to an array with this
        personList.push(favnum);
    }

    // if we pass input we have to define the type of the imput  like bule
    function store(uint256 _favnum) public virtual {
        myfavnum = _favnum;
    }

    // to read a start from a blochaing we use view or pure
    // eg

    // reading state from the chain does not cause fee

    // if another fn calls it it charge fee tho

    function retrive() public view returns (uint256) {
        return myfavnum;
    }

    function retrived() public view returns (uint256) {
        return myfavnum;
    }
}
