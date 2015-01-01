function selectRunTime(job_mode){
	//var job_mode = $("#job_mode").val();
	if(job_mode == "M"){
		document.getElementById("jobRunTime").style.display="none";
		document.getElementById("job_run_time_M").style.display="";
		document.getElementById("job_run_time_H").style.display="";
		document.getElementById("job_run_time_m").style.display="";
		document.getElementById("job_run_time_S").style.display="";
	}else if("D" == job_mode){
		document.getElementById("jobRunTime").style.display="none";
		document.getElementById("job_run_time_M").style.display="none";
		document.getElementById("job_run_time_H").style.display="";
		document.getElementById("job_run_time_m").style.display="";
		document.getElementById("job_run_time_S").style.display="";
	}else if("S" == job_mode){
		document.getElementById("jobRunTime").style.display="";
		document.getElementById("job_run_time_M").style.display="none";
		document.getElementById("job_run_time_H").style.display="none";
		document.getElementById("job_run_time_m").style.display="none";
		document.getElementById("job_run_time_S").style.display="none";
	}else{
		document.getElementById("jobRunTime").style.display="none";
		document.getElementById("job_run_time_M").style.display="none";
		document.getElementById("job_run_time_H").style.display="none";
		document.getElementById("job_run_time_m").style.display="none";
		document.getElementById("job_run_time_S").style.display="none";
	}
}

function doReset(){
	$('#job_name').val('');
	$('#job_mode').val('');
	$('#job_run_freq').val('');
	$('#job_run_mode').val('');
	$('#job_run_time').val('');
	$('#job_enable').val('');
	$('#job_type').val('');
	$('#h_order_id').val('');
	$('#s_tab').val('');
	$('#d_tab').val('');
	$('#etl_sql').val('');
	selectRunTime("");
}