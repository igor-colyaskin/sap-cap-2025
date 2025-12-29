sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"tinyoffice/tinyoffice/test/integration/pages/EmployeesList",
	"tinyoffice/tinyoffice/test/integration/pages/EmployeesObjectPage"
], function (JourneyRunner, EmployeesList, EmployeesObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('tinyoffice/tinyoffice') + '/test/flp.html#app-preview',
        pages: {
			onTheEmployeesList: EmployeesList,
			onTheEmployeesObjectPage: EmployeesObjectPage
        },
        async: true
    });

    return runner;
});

