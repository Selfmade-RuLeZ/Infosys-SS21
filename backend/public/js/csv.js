function supportAjaxUploadWithProgress() {
    return supportFileAPI() && supportAjaxUploadProgressEvents() && supportFormData();

    function supportFileAPI() {
        var fi = document.createElement('INPUT');
        fi.type = 'file';
        return 'files' in fi;
    };

    function supportAjaxUploadProgressEvents() {
        var xhr = new XMLHttpRequest();
        return !! (xhr && ('upload' in xhr) && ('onprogress' in xhr.upload));
    };

    function supportFormData() {
        return !! window.FormData;
    }
}

var form = document.getElementById('upload-form');
var fileSelect = document.getElementById('file-select-input');
var uploadButton = document.getElementById('upload-button');

form.onsubmit = function(event) {
    // Prevent a non-AJAX file upload from starting
    event.preventDefault();

    // Let the user know that the upload has begun
    uploadButton.innerHTML = 'Uploading...';

    // Get the selected files from the input
    var files = fileSelect.files;

    // Create a new FormData object
    var formData = new FormData();

    // Loop through each of the selected files.
    for(var i = 0; i < files.length; i++){
        var file = files[i];
        // Check the file type
        if (!/image.*/.test(file.type)) {
            return;
        }

        // Add the file to the form's data
        formData.append('photos[]', file, file.name);
    }

    // Set up the request object
    var xhr = new XMLHttpRequest();

    // Open the connection and pass the file name
    xhr.open('POST', 'handler.php', true);

    // Set up a handler for when the request finishes
    xhr.onload = function () {
        uploadButton.innerHTML = 'Upload';
        if (xhr.status === 200) {
            // File(s) uploaded
            alert('File uploaded successfully');
        } else {
            alert('Something went wrong uploading the file.');
        }
    };

    xhr.send(formData);
}