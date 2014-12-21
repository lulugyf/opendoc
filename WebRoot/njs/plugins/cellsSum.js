function tableSum(tableId){
		//get table
		var table = document.getElementById(tableId);
		
		//get tbody
		var tableBody = table.tBodies[0];

		//table rows
		var tableRows = tableBody.rows;
		var rowLen = tableRows.length-1;
		
		//get columns
		var tableColumns = table.getElementsByTagName("td");
		cols = tableColumns.length;
		var colLen = cols/rowLen;
		
		for(i=0;i<colLen;i++)
		{
			cellsSum(tableBody,rowLen,i);
		 }
		
	
}
	
function cellsSum(tableBody,rowLen,focusColumn){
		var sum = 0.0;
		for(var i=0;i<rowLen;i++){
			var value = tableBody.rows(i).cells[focusColumn].innerText;
			if(!isNaN(value)){
				var num = parseInt(value);
				sum += num;
			}		
		}
		 var textId = "sum"+focusColumn;
	   var text = document.getElementById(textId);
	   text.innerHTML=sum;
	}