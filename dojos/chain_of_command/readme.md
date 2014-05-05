## Chain of command dojo

Within DinoCorp there is only one way of communicating with anyone in the company; through your boss.
Messages must be passed up and down through the employees who only know about the people immediatly above or below themselves.

The task is to produce a program that can trace the route a message would have to take giving an output similar to this:

`Emp1 -> boss1 -> BigBoss <- boss2 <- emp2`

The arrows denote directions of communication (-> is up <- is down the chain).
In order to do this you must read in a text file containing information on the employees organisation in the following format:

EmpID  |  EmpName  |  BossID

  1    |   Mr.Big   |
  
  13   |  Sally  |  1  
  
2  |  Bert  |  13  

Ordering is not guaranteed in the file (as records are updated constantly) nor is the premise that a lower ID means a senior staff member (keys are reused!).
Information in the file will be seperated by a pipe character `|`.
