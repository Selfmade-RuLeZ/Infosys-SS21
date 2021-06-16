$(document).ready(function () {
  // Tabelle erstellen und Daten laden
  $("#dataTable").DataTable({
    ajax: "/api/openRental",
    columns: [
      {
        data: "id",
      },
      {
        data: "firstName",
      },
      {
        data: "lastName",
      },
      {
        data: "amount",
      },
    ],
  });
});
