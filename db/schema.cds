namespace my.tinyoffice;

entity Employee {
  key ID              : UUID;
      name            : String;
      department_ID   : UUID;
      department      : Association to Department
                          on department.ID = department_ID;
      salary          : Decimal(10, 2);

      // НОВАЯ СВЯЗЬ: У сотрудника есть статистика его отдела
      // Мы связываем department_ID сотрудника с ID статистики
      departmentStats : Association to DepartmentStats
                          on departmentStats.ID = department_ID;
}

entity Department {
  key ID       : UUID;
      name     : String;
      building : String;
}

// 1. Создаем View, которое заранее считает суммы по отделам
entity DepartmentStats as
  select from Employee {
    key department_ID as ID, // Группируем по ID отдела

        // Считаем сумму зарплат
        sum(salary)   as totalSalary : Decimal(10, 2),

        // Считаем количество голов
        count(ID)     as headCount   : Integer
  }
  group by
    department_ID;

// ... (не забудьте точку с запятой выше)
