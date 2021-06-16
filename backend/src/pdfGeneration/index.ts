import pdf from "pdf-creator-node";
import fs from "fs";
import path from "path";
// Read HTML Template
var html = fs.readFileSync(
  path.join(__dirname, "../../../template/template.html"),
  "utf8"
);

var options = {
  format: "A3",
  orientation: "portrait",
  border: "10mm",
  header: {
    height: "45mm",
    contents: '<div style="text-align: center;">Dream Home Team</div>',
  },
  footer: {
    height: "28mm",
    contents: {
      first: "Betriebskostenabrechnung",
      2: "Second page", // Any page number is working. 1-based index
      default:
        '<span style="color: #444;">{{page}}</span>/<span>{{pages}}</span>', // fallback value
      last: "Last Page",
    },
  },
};

export default {
  createPDF: async (users: PDFUser[], usages: PDFUsage[]) => {
    var document = {
      html: html,
      data: {
        users,
        usages,
      },
      path: "../../../template/template.html",
      type: "buffer",
    };

    return await pdf
      .create(document, options)
      .then((res: any) => {
        return res;
      })
      .catch((error: any) => {
        console.error(error);
      });
  },
};
