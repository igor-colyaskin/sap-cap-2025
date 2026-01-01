const cds = require('@sap/cds')

// 1. Функция валидации и авто-коррекции
async function validateAndEnrich(req) {
  const data = req.data

  // Валидация
  if (data.salary && data.salary < 50000) {
    req.error(400, 'Слишком мало для агента уровня 007! Минимум 50 000.', 'salary')
  }

  // Авто-коррекция имени
  if (data.name) {
    data.name = data.name.charAt(0).toUpperCase() + data.name.slice(1)
  }
}

// 2. Функция расчета бонуса (Виртуальное поле)
async function calculateBonus(data) {
  const records = Array.isArray(data) ? data : [data]
  records.forEach(employee => {
    if (employee.salary) {
      employee.bonus = (employee.salary * 0.2).toFixed(2)
    }
  })
}

// 3. Функция повышения зарплаты (Action)
async function boostSalary(req) {
  // этот код не работал после рефакторинга на CDS v4 --------------------------------------------------------------------------
  //   // Чтобы получить доступ к сущности Employees, используем cds.entities
  //   // (или req.target, если хотим динамически)
  //   const { Employees } = cds.entities('my.tinyoffice')

  //   // Внимание: req.params[0] может быть сложным, используем деструктуризацию для надежности
  //   // Но для простоты оставим как было, если у вас работало,
  //   // или используем универсальный способ получения ID:
  //   const id = req.data.ID || req.params[0]
  //  --------------------------------------------------------------------------------------------------------------------------

  // ПРОБЛЕМА БЫЛА ЗДЕСЬ: cds.entities(...) не сработало.

  // РЕШЕНИЕ:
  // Мы можем не импортировать сущности отдельно.
  // Мы можем использовать СТРОКУ в запросе SELECT.
  // CAP сам найдет таблицу по имени.

  // Используем полное имя из базы (namespace + имя)
  // Или используем req.target (это объект определения сущности Employees)
  const Employees = req.target

  // Получаем ID.
  // В Draft/V4 params[0] может быть объектом или строкой.
  // Попробуем универсальный хак, чтобы достать ID:
  const id = req.params[0]?.ID || req.params[0]

  const amount = req.data.amount || 5000

  // Логика
  const employee = await SELECT.one.from(Employees).where({ ID: id })
  if (!employee) req.error(404, 'Сотрудник не найден')

  const newSalary = parseFloat(employee.salary) + parseFloat(amount)

  await UPDATE(Employees).set({ salary: newSalary }).where({ ID: id })

  return await SELECT.one.from(Employees).where({ ID: id })
}

// Экспортируем функции наружу, чтобы service.js мог их видеть
module.exports = {
  validateAndEnrich,
  calculateBonus,
  boostSalary,
}
