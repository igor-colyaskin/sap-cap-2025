using CatalogService as service from '../../srv/service';

annotate service.Employees with {
    department  @Common.Text: department.name  @Common.TextArrangement: #TextOnly;
};

annotate service.Departments with {
    ID @(
        Common.Text           : name,
        Common.TextArrangement: #TextOnly
    )
};


annotate service.Employees with @(
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
    ],
    UI.SelectionFields           : [
        department,
        salary
    ],
);
