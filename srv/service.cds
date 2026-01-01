using my.tinyoffice from '../db/schema';

service CatalogService {
    @odata.draft.enabled
    entity Employees   as
        projection on tinyoffice.Employee {
            *, // Берем все поля из базы (ID, name, salary...)

            // Добавляем новое ВИРТУАЛЬНОЕ поле
            // Оно существует только в API, в базе его нет
            virtual null as bonus : Decimal(10, 2)
        };

    @readonly
    entity Departments as projection on tinyoffice.Department;
}

annotate CatalogService.Employees with {
    // Аннотируем именно ID, а не ассоциацию
    department_ID @(
        // Текст берем через навигацию
        Common.Text           : department.name,
        Common.TextArrangement: #TextOnly,

        // Список значений
        Common.ValueList      : {
            Label         : 'Выберите отдел',
            CollectionPath: 'Departments',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: department_ID,
                    ValueListProperty: 'ID'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'
                }
            ]
        }
    );
};

annotate CatalogService.Departments with {
    ID @(
        Common.Text           : name,
        Common.TextArrangement: #TextOnly
    )
};

annotate CatalogService.Employees with @(
    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: 'ID',
                Value: ID,
            },
            {
                $Type: 'UI.DataField',
                Label: 'name',
                Value: name,
            },
            {
                $Type: 'UI.DataField',
                Label: 'department',
                Value: department_ID,
            },
            {
                $Type: 'UI.DataField',
                Label: 'salary',
                Value: salary,
            },
        ],
    },
    UI.HeaderInfo                : {
        TypeName      : 'Employee',
        TypeNamePlural: 'Employees',
        Title         : {
            $Type: 'UI.DataField',
            Value: name,
        },
        Description   : {
            $Type: 'UI.DataField',
            Value: department,
        },
    },
    UI.Facets                    : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'GeneratedFacet1',
        Label : 'General Information',
        Target: '@UI.FieldGroup#GeneratedGroup',
    }, ],
    UI.PresentationVariant       : {
        SortOrder     : [{
            Property  : name,
            Descending: false // false = А-Я, true = Я-А
        }],
        Visualizations: ['@UI.LineItem'] // Примени это к нашей таблице
    },
    UI.LineItem                  : [
        // {
        //     $Type: 'UI.DataField',
        //     Label: 'ID',
        //     Value: ID,
        // },
        {
            $Type         : 'UI.DataField',
            Label         : 'Full Name',
            Value         : name,
            @UI.Importance: #High
        },
        {
            $Type         : 'UI.DataField',
            Label         : 'Department',
            Value         : department_ID,
            @UI.Importance: #Medium
        },
        {
            $Type         : 'UI.DataField',
            Label         : 'Salary',
            Value         : salary,
            @UI.Importance: #Low
        },
        {
            $Type         : 'UI.DataField',
            Label         : 'Estimated Bonus',
            // Расчетный бонус
            Value         : bonus, // Наше новое поле
            @UI.Importance: #High
        }
    ],
    UI.SelectionFields           : [
        department,
        salary
    ],
);
