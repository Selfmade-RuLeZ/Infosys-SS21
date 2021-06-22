$(document).ready(function () {
  // Tabelle erstellen und Daten laden
  $("#dataTable").DataTable({
    ajax: "/api/tenants",
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
        data: "iban",
      },
      {
        data: "personen",
      },
    ],
  });

  var table = $("#dataTable").DataTable();
  var selectedRow = null;

  // Tabellenzeile selected Event
  $("#dataTable tbody").on("click", "tr", function () {
    selectedRow = table.row(this).data();

    $("#SDPID").val(selectedRow.id);
    $("#SDPName").val(selectedRow.name);
    $("#SDPLastName").val(selectedRow.lastName);
    $("#SDPIBAN").val(selectedRow.iban);
    $("#SDPPersons").val(selectedRow.personen);
  });

  $("#SDPsave").click(function () {
    var id = $("#SDPID").val();
    var name = $("#SDPName").val();
    var lastName = $("#SDPLastName").val();
    var iban = $("#SDPIBAN").val();
    var personen = $("#SDPPersons").val();

    if (id === "") {
      createRecord(name, lastName, iban, personen);
    } else {
      updateRecord(id, name, lastName, iban, personen);
    }
  });

  function updateRecord(id, name, lastName, iban, personen) {
    var sendData = {
      name: name,
      lastName: lastName,
      iban: iban,
      personen: personen,
    };
    $.ajax({
      url: `/api/tenants/${id}`,
      type: "PUT",
      contentType: "application/json",
      data: JSON.stringify(sendData),
      success: function (result) {
        alert("Der Datensatz wurde aktualisiert!");
        location.reload();
      },
    });
  }

  function createRecord(name, lastName, iban, personen) {
    var sendData = {
      name: name,
      lastName: lastName,
      iban: iban,
      personen: personen,
    };

    $.ajax({
      url: "/api/tenants",
      type: "POST",
      contentType: "application/json",
      data: JSON.stringify(sendData),
      success: function (result) {
        alert("Der Datensatz wurde angelegt!");
        location.reload();
      },
    });
  }

  $("#SDPnew").click(function () {
    selectedRow = null;

    $("#SDPID").val("");
    $("#SDPName").val("");
    $("#SDPLastName").val("");
    $("#SDPIBAN").val("");
    $("#SDPPersons").val("");
  });

  $("#SDPdelete").click(function () {
    if (selectedRow == null) {
      alert("Sie müssen erst einen Datensatz wählen!");
      return;
    }

    $.ajax({
      url: `/api/tenants/${$("#SDPID").val()}`,
      type: "DELETE",
      success: function () {
        $("#SDPID").val("");
        $("#SDPName").val("");
        $("#SDPLastName").val("");
        $("#SDPIBAN").val("");
        $("#SDPPersons").val("");

        alert("Der Datensatz wurde gelöscht!");
        location.reload();
      },
    });
  });
});
