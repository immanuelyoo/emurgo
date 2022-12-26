// SPDX-License-Identifier: MIT
pragma solidity 0.8;


contract employeeAttendance{
    struct Employee{
        string firstName;
        string lastName;
        string role;
        string department;
        uint attendanceValue;
    }

    mapping(address => Employee) private dataEmployee;
 
    address payable private ownerAddress;

    constructor(){
        ownerAddress = payable(msg.sender);
    }

    modifier onlyOwner {
        require(msg.sender == ownerAddress, "Hanya address owner yang bisa menjalankan!");
        _;
    }

    function registerEmployee(address _ownerAddress , string memory _firstName, string memory _lastName, string memory _role,string memory _department) public onlyOwner{
        dataEmployee[_ownerAddress].firstName=_firstName;
        dataEmployee[_ownerAddress].lastName=_lastName;
        dataEmployee[_ownerAddress].role=_role;
        dataEmployee[_ownerAddress].department=_department;
        dataEmployee[_ownerAddress].attendanceValue=0;
    }

    function updateAttendance(address _ownerAddress, uint _attendanceValue) public onlyOwner{
        dataEmployee[_ownerAddress].attendanceValue= _attendanceValue;
    }
    
    function updateEmployeeData(address _ownerAddress, string memory _role, string memory _department) public onlyOwner{
        dataEmployee[_ownerAddress].role=_role;
        dataEmployee[_ownerAddress].department=_department;
    }
    
    function getEmployee(address _ownerAddress) public view returns(address OwnerAddress, string memory FirstName, string memory LastName, string memory Role, string memory Department, uint AttendanceValue){
        OwnerAddress =_ownerAddress;
        FirstName = dataEmployee[_ownerAddress].firstName;
        LastName = dataEmployee[_ownerAddress].lastName;
        Role = dataEmployee[_ownerAddress].role;
        Department = dataEmployee[_ownerAddress].department;
        AttendanceValue= dataEmployee[_ownerAddress].attendanceValue;
    }

    function deleteEmployee(address _ownerAddress) onlyOwner public{
        delete dataEmployee[_ownerAddress];
    }

    function getSalary(address _ownerAddress, uint _overTime)public view returns(uint salary,bool valid,uint totalSalary){
        uint workingDays = dataEmployee[_ownerAddress].attendanceValue;
        uint dailySalary = 1;
        salary = dailySalary*workingDays;
        valid;
        totalSalary;
        if(_overTime <3){
            valid = false;
            totalSalary=salary;
        }else{
            valid = true;
            totalSalary = salary+1;
        }return (salary,valid,totalSalary);
    }
}