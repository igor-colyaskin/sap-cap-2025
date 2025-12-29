using my.tinyoffice from '../db/schema';

service CatalogService {
    @readonly entity Employees as projection on tinyoffice.Employee;
    @readonly entity Departments as projection on tinyoffice.Department;
}