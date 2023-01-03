// Callback function to execute on click of convert button
async function uploadFile() {
  // Check if an yaml file has been selected
  if (fileupload.files[0]) {
    // Create form data
    let formData = new FormData();
    formData.append("file", fileupload.files[0]);
    try {
      // Firing post request to backend
      const response = await fetch("/convert", {
        method: "POST",
        body: formData,
      });
      const data = await response.json();
      // Populating UI with json data
      document.getElementsByClassName("json-container")[0].style.display =
        "flex";
      document.getElementById("json").textContent = JSON.stringify(
        data,
        undefined,
        2
      );
    } catch (e) {
      // Error handling
      alert("Oops! Something went wrong.");
    }
  } else {
    // Alert if no file is selected
    alert("Please upload a yaml file to convert");
  }
}
