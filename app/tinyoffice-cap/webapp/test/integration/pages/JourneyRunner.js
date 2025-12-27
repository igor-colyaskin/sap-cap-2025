sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"tiny/office/tinyofficecap/test/integration/pages/EmployeeList",
	"tiny/office/tinyofficecap/test/integration/pages/EmployeeObjectPage"
], function (JourneyRunner, EmployeeList, EmployeeObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('tiny/office/tinyofficecap') + '/test/flpSandbox.html#tinyofficetinyofficecap-tile',
        pages: {
			onTheEmployeeList: EmployeeList,
			onTheEmployeeObjectPage: EmployeeObjectPage
        },
        async: true
    });

    return runner;
});

