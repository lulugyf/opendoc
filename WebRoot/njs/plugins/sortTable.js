function sortTable(tableID, sortColumn, nodeType)
{
	//get table.
	var table = document.getElementById(tableID);
	
	//get tbody.
	var tableBody = table.tBodies[0];
	
	//table rows.
	var tableRows = tableBody.rows;
	
	var rowArray = new Array();
	
	//initial row array.
	for (var i=0; i<tableRows.length; i++)
	{
	rowArray[i] = tableRows[i];
	}
	
	if(table.sortColumn == sortColumn)
	{
	rowArray.reverse();
	}
	else
	{
	rowArray.sort(generateCompareTR(sortColumn, nodeType));
	}
	
	var tbodyFragment = document.createDocumentFragment();
	for(var i=0; i< rowArray.length; i++)
	{
	tbodyFragment.appendChild(rowArray[i]);
	}
	
	tableBody.appendChild(tbodyFragment);
	table.sortColumn = sortColumn;
}
	
function generateCompareTR(sortColumn, nodeType)
{
	return function compareTR(trLeft, trRight){
	    trLeft.cells[sortColumn].innerHTML=trLeft.cells[sortColumn].innerHTML.replace(/(^\s*)|(\s*$)/g, "")==''?'&nbsp;':trLeft.cells[sortColumn].innerHTML.replace(/(^\s*)|(\s*$)/g, "");
		trRight.cells[sortColumn].innerHTML=trRight.cells[sortColumn].innerHTML.replace(/(^\s*)|(\s*$)/g, "")==''?'&nbsp;':trRight.cells[sortColumn].innerHTML.replace(/(^\s*)|(\s*$)/g, "");
		var leftValue = convert(getChildVal(trLeft.cells[sortColumn].firstChild), nodeType);
		var rightValue = convert(getChildVal(trRight.cells[sortColumn].firstChild), nodeType); 
		
		switch(nodeType)
		{
				case "zh": 
					return(leftValue.localeCompare(rightValue));
				default:
					if(leftValue<rightValue)
					{
					return -1;
					}
					else if(leftValue>rightValue)
					{
					return 1;
					}
					else
					{
					return 0
					}
		}
	}
}
		
function convert(value, dataType)
{ var tp=dataType;
	if(dataType && dataType.indexOf(':')>-1){
	    tp = dataType.substring(0,dataType.indexOf(':'));
	}
	
	switch(tp)
	{
	case "int":
	return parseInt(value);
	case "float":
	return parseFloat(value);
	case "date":
	return new Date(Date.parse(fmtDate(value,dataType)));
	case "zh":
	return value;
	default:
	return value.toString();
	}
}

function getChildVal(obj){
 try{
   if(obj.tagName){
     return getChildVal(obj.firstChild);
   }else{
     return obj.nodeValue;
   }
 }catch(e){
 }
}

function fmtDate(value,dataType){
	 var vl = dataType.substring(dataType.indexOf(':')+1);
    switch(vl.toLowerCase()){
    	case "yyyymmdd":
           return value.substring(0,4)+'/'+value.substring(4,6)+'/'+value.substring(6);
      default:
        return value.replace(/-/g,"/");
    }
	
}