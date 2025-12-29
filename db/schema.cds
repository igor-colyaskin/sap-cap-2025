namespace my.tinyoffice;

entity Employee {
  key ID : UUID;
  name   : String;
  department_ID : UUID;
  department : Association to Department on department.ID = department_ID;
  salary : Decimal(10,2);
}

entity Department {
  key ID : UUID;
  name   : String;
  building : String;
}