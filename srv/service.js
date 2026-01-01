const cds = require('@sap/cds')

// Экспортируем функцию, которая содержит логику сервиса
module.exports = cds.service.impl(async function () {
  // 1. Получаем доступ к нашим сущностям (чтобы не писать строки руками)
  // this.entities - это список всех таблиц в этом сервисе
  const { Employees } = this.entities

  // 2. Вешаем "Слушателя" (Hook)
  // "ПЕРЕД" (before) тем, как создать (CREATE) или обновить (UPDATE) запись...
  // ...в таблице Employees...
  // ...выполни эту функцию (req)
  this.before(['CREATE', 'UPDATE'], Employees, async req => {
    // req.data - это данные, которые прилетели с интерфейса (или API)
    const salary = req.data.salary
    // console.log('Service is starting...', req)

    // Если зарплата вообще была передана (мы ведь можем менять только имя)
    if (salary !== undefined) {
      // Наша бизнес-логика:
      if (salary < 50000) {
        // Если условие нарушено - БРОСАЕМ ОШИБКУ.
        // 400 - код ошибки (Bad Request).
        // Сообщение увидит пользователь.
        // 'salary' - подсветит красным конкретное поле ввода.
        req.error(400, 'Слишком мало для агента уровня 007! Минимум 50 000.', 'salary')
      }
    }
    if (req.data.name) {
      // Если пришло имя - делаем первую букву заглавной
      // charAt(0).toUpperCase() - берем первую букву и делаем Большой
      // slice(1) - берем остаток слова как есть
      req.data.name = req.data.name.charAt(0).toUpperCase() + req.data.name.slice(1)
    }
  })

  // НОВЫЙ КОД:
  // После того, как данные прочитаны (READ) из Employees
  // Аргумент data - это массив строк (или одна строка), которые вернула база
  this.after('READ', Employees, data => {
    // Данные могут быть массивом (список) или объектом (одна запись)
    // Превращаем всё в массив для удобства
    const records = Array.isArray(data) ? data : [data]

    // Пробегаем по каждой записи
    records.forEach(employee => {
      if (employee.salary) {
        // Логика бонуса: 20% от зарплаты
        // В JS лучше работать с числами, поэтому умножаем
        // toFixed(2) вернет строку, но OData это съест
        employee.bonus = (employee.salary * 0.2).toFixed(2)
      }
    })
  })
})
