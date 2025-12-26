using my.tinyoffice from '../db/schema';

service CatalogService {
    @readonly entity Employee as projection on tinyoffice.Employee;
}