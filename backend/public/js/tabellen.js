$(document).ready(function () {
    // Tabelle erstellen und Daten laden
    $("#contractTable").DataTable({
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

    $("#flatTable").DataTable({
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

    $("#ownerTable").DataTable({
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

    $("#propertyTable").DataTable({
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

    $("#utilityCostTable").DataTable({
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

    $("#journalTable").DataTable({
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

    $("#positionTable").DataTable({
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