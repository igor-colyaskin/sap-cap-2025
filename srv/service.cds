using my.tinyoffice from '../db/schema';

service CatalogService {
    @readonly entity Employees as projection on tinyoffice.Employees;
}