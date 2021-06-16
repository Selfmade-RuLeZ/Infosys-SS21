$(document).ready(function () {
    // Tabelle erstellen und Daten laden
    $("#dataTable").DataTable({
        ajax: "/api/contract",
        columns: [
            {
                data: "id",
            },
            {
                data: "tenant_id",
            },
            {
                data: "additionalCosts",
            },
            {
                data: "rentalFee",
            },
            {
                data: "startDate",
            },
            {
                data: "endDate",
            },
            {
                data: "propertyID",
            }
        ],
    });

    $("#dataTable").DataTable({
        ajax: "/api/flat",
        columns: [
            {
                data: "id",
            },
            {
                data: "contractId",
            },
            {
                data: "tenantId",
            },
            {
                data: "ownerId",
            },
        ],
    });

    $("#dataTable").DataTable({
        ajax: "/api/owner",
        columns: [
            {
                data: "id",
            },
            {
                data: "name",
            },
            {
                data: "lastName",
            },
            {
                data: "phoneNumber",
            },
            {
                data: "PostalCode",
            },
            {
                data: "address",
            },
        ],
    });

    $("#dataTable").DataTable({
        ajax: "/api/property",
        columns: [
            {
                data: "id",
            },
            {
                data: "ownerId",
            },
            {
                data: "postalCode",
            },
            {
                data: "address",
            }
        ],
    });

    $("#dataTable").DataTable({
        ajax: "/api/utilityCost",
        columns: [
            {
                data: "id",
            },
            {
                data: "bookingDate",
            },
            {
                data: "valueDate",
            },
            {
                data: "Amount",
            }
        ],
    });

    $("#dataTable").DataTable({
        ajax: "/api/journal",
        columns: [
            {
                data: "id",
            },
            {
                data: "bookingDate",
            },
            {
                data: "valueDate",
            },
            {
                data: "Amount",
            },
            {
                data: "tenantId",
            },
        ],
    });

    $("#dataTable").DataTable({
        ajax: "/api/position",
        columns: [
            {
                data: "id",
            },
            {
                data: "bookingDate",
            },
            {
                data: "valueDate",
            },
            {
                data: "usage",
            },
            {
                data: "amount",
            },
        ],
    });







});