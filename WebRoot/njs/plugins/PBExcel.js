
function PBExcel(actionPath)
{

    this.CreateExcelFile =  CreateExcelFile;                         //生成Excel文件函数 
    this.CreateHiddenExcelForm = CreateHiddenExcelForm;        // 生成不可见的隐含表单
    this.FormAction = actionPath;   //表单提交的URL（此URL返回Excel文件)
    
    
		function CreateExcelFile(tableId,excelFileName)
		{
			
				if (tableId == null )
				{ 
				  alert("\u8bf7\u6307\u5b9a\u8981\u751f\u6210Excel\u6587\u4ef6\u7684\u8868\u683c\u7684ID\u3002");
				  return;
				}
				
				var tableElement = document.getElementById(tableId);
				
				if (tableElement == null )
				{ 
				  alert("\u6307\u5b9a\u7684\u8868\u683c(ID=" + tableId + ")\u4e0d\u5b58\u5728,\u8bf7\u68c0\u67e5\u3002");
				  return;
				}
				
				this.CreateHiddenExcelForm();
				
				if(document.all){
				    var c = tableElement.cloneNode(true); //避免修改tableElement的border属性（原方法先改变border再还原）
					c.setAttribute("border", "1");
				    document.PBExcelTableForm.tableContent.value = c.outerHTML;  //把指定ID表格所含的html代码赋给表单
				    c=null;
				}else{
				    var d = document.createElement('div');  
				    var c = tableElement.cloneNode(true); 
					c.setAttribute("border", "1");
					d.appendChild(c);
					document.PBExcelTableForm.tableContent.value = d.innerHTML;  //把指定ID表格所含的html代码赋给表单，firefox不支持outerHTML
					c=null;
					d=null;
				}
				
				document.PBExcelTableForm.excelFileName.value = excelFileName ;         //把excel文件名称赋给表单
				document.PBExcelTableForm.submit();                                     //提交表单
		}
		
		function CreateHiddenExcelForm()
		{
				var formString;
				if ( document.getElementById("HiddenExcelFormDiv") == null )           //判断是否已经创建过隐含 报表
				{  
					formString =  "<div align='center' id=HiddenExcelFormDiv style='visibility:hidden;'>"
					formString = formString + "<form action='" +  this.FormAction + "' name='PBExcelTableForm' method='POST'>"
					formString = formString + "<input type=hidden  name='excelFileName' value='' />"
					formString = formString + "<input type=\"hidden\" name=\"_htuaMJlBLG\" id=\"_htuaMJlBLG\" value=\"noCheck\"/> ";//不对特殊字符进行过滤 add by zhangzha on 20120202
					formString = formString + "<textArea cols=1 border=1 rows=1 name='tableContent'>"
					formString = formString + "</textArea>"
					formString = formString + "</form>"
					formString = formString + "</div>"
					var newDiv = document.createElement("div");                           
					newDiv.innerHTML = formString;
					
					document.body.appendChild(newDiv);                                       //把隐含 报表输出到document
				}

		}
}