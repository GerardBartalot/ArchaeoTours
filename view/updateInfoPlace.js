$(document).ready(function () {
    $("#update-info-ajax").click(function () {
        
        // Get values
        var formData = new FormData();
        formData.append("nombre", $("#name").val());
        formData.append("localizacion", $("#localizacion").val());
        formData.append("tipologia", $("#tipologia").val());
        formData.append("periodo", $("#periodo").val());
        formData.append("subperiodo", $("#subperiodo").val());
        formData.append("descripcion", $("#descripcion").val());
        formData.append("link1", $("#link1").val());
        formData.append("link2", $("#link2").val());
        formData.append("link3", $("#link3").val());
        formData.append("video1", $("#video1").val());
        formData.append("video2", $("#video2").val());
        formData.append("imagen", $("#imagen")[0].files[0]);
        formData.append("imagen_secundaria1", $("#imagen_secundaria1")[0].files[0]);
        formData.append("imagen_secundaria2", $("#imagen_secundaria2")[0].files[0]);
        formData.append("imagen_secundaria3", $("#imagen_secundaria3")[0].files[0]);

        // Check if all inputs are filled
        if ($("#name").val() && $("#localizacion").val() && $("#tipologia").val() && $("#periodo").val() && 
            $("#subperiodo").val() && $("#descripcion").val() && $("#link1").val() && $("#link2").val() && 
            $("#link3").val() && $("#video1").val() && $("#video2").val() && $("#imagen")[0].files[0] && 
            $("#imagen_secundaria1")[0].files[0] && $("#imagen_secundaria2")[0].files[0] && $("#imagen_secundaria3")[0].files[0]) {
        
            // Send data
            $.ajax({
                url: '../controller/LugaresController.php?action=updatePlaceAjax',
                method: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function(data) {
                    console.log("Raw response data:", data);
                    try {
                        if (!data) {
                            console.error("Empty response from server");
                        } else {
                            var parsedData = JSON.parse(data);
                            console.log("Parsed data:", parsedData);
                        }
                    } catch (e) {
                        console.error("Failed to parse JSON response:", e);
                    }
                },
                error: function(xhr, status, error) {
                    console.error("AJAX error:", status, error);
                }
            }); 
        } else {
            alert("Por favor, complete todos los campos antes de enviar.");
        }
    });
});
