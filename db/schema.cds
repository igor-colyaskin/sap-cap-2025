namespace my.tinyoffice;

entity Employee {
  key ID : Integer;
  name   : String;
  department : Association to Department;
  salary : Decimal(10,2);
}

entity Department {
  key ID : Integer;
  name   : String;
  building : String;
}