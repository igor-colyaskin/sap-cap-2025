const cds = require('@sap/cds')
// Импортируем наших исполнителей
const employees = require('./lib/employees')

module.exports = cds.service.impl(async function () {
  const { Employees } = this.entities

  // --- РЕГИСТРАЦИЯ СОБЫТИЙ ---

  // 1. Валидация (Create/Update)
  // Мы просто передаем имя функции, не вызывая её скобками ()
  this.before(['CREATE', 'UPDATE'], Employees, employees.validateAndEnrich)

  // 2. Виртуальные поля (Read)
  this.after('READ', Employees, employees.calculateBonus)

  // 3. Actions
  this.on('boostSalary', Employees, employees.boostSalary)
})
