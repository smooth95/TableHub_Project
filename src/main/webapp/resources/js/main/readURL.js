function readURL(input){
	let file = input.files[0]
	if(file != ""){
		let reader = new FileReader();
		reader.readAsDataURL(file);
		reader.onload = function(e){
			$("#preview").attr("src", e.target.result)
			}
		}
	}