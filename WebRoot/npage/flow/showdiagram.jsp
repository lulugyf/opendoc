<%@ page contentType="text/html;charset=GBK" %>
<html xmlns:v="urn:schemas-microsoft-com:vml">
<head>
	<title>mxDraw Example</title>
 	<link rel="stylesheet" href="css/common.css" type="text/css" />
	<meta http-equiv="Content-Type" content="text/html; charset=GBK">
	<script type="text/javascript">
		mxBasePath = '<%=request.getContextPath()%>/npage/flow';
	</script>
	<style>
	v\:* {behavior: url(#default#VML);}
	</style>
	<script type="text/javascript" src="js/mxclient.js"></script>
	
	<script type="text/javascript">
		function main(container)
		{
			// Checks if the browser is supported
			if (!mxClient.isBrowserSupported())
			{
				// Displays an error message if the browser is not supported.
				mxUtils.error('Browser is not supported!', 200, false);
			}
			else
			{
				// Enables crisp rendering of rectangles in SVG
				mxRectangleShape.prototype.crisp = true;
				// Creates the graph inside the given container
				
		    	var graph = new mxGraph(container);

				// Uncomment the following if you want the container
				// to fit the size of the graph
				//graph.setResizeContainer(true);
				
				// Enables rubberband selection
				new mxRubberband(graph);
				// Creates the default style for vertices
				
				var style = [];
				style[mxConstants.STYLE_SHAPE] = mxConstants.SHAPE_RECTANGLE;
				style[mxConstants.STYLE_PERIMETER] = mxPerimeter.RectanglePerimeter;
				style[mxConstants.STYLE_STROKECOLOR] = '#B4B4B4';
				style[mxConstants.STYLE_FILLCOLOR] = '#EEEEEE';
				style[mxConstants.STYLE_GRADIENTCOLOR] = 'white';
				style[mxConstants.STYLE_FONTCOLOR] = '#774400';
				style[mxConstants.STYLE_ALIGN] = mxConstants.ALIGN_CENTER;
				style[mxConstants.STYLE_VERTICAL_ALIGN] = mxConstants.ALIGN_MIDDLE;
				style[mxConstants.STYLE_VERTICAL_PLACE] = mxConstants.ALIGN_MIDDLE;
				style[mxConstants.STYLE_FONTSIZE] = '12';
				style[mxConstants.STYLE_FONTSTYLE] = 1;
				graph.getStylesheet().putDefaultVertexStyle(style);
				
				style = [];
				style[mxConstants.STYLE_SHAPE] = mxConstants.SHAPE_CONNECTOR;
				style[mxConstants.STYLE_STROKECOLOR] = '#36393D';
				style[mxConstants.STYLE_ALIGN] = mxConstants.ALIGN_CENTER;
				style[mxConstants.STYLE_VERTICAL_ALIGN] = mxConstants.ALIGN_MIDDLE;
				//style[mxConstants.STYLE_EDGE] = mxEdgeStyle.ElbowConnector; //曲线
				style[mxConstants.STYLE_ENDARROW] = mxConstants.ARROW_CLASSIC;
				style[mxConstants.STYLE_FONTSIZE] = '10';
				graph.getStylesheet().putDefaultEdgeStyle(style);
				
				style = [];
				style[mxConstants.STYLE_SHAPE] = mxConstants.SHAPE_IMAGE;
				style[mxConstants.STYLE_PERIMETER] = mxPerimeter.RectanglePerimeter;
				style[mxConstants.STYLE_IMAGE] = 'images/icon/1.png';
				style[mxConstants.STYLE_ALIGN] = mxConstants.ALIGN_CENTER;
				graph.getStylesheet().putCellStyle('imagetest', style);
				
				// Gets the default parent for inserting new cells. This
				// is normally the first child of the root (ie. layer 0).
				var parent = graph.getDefaultParent();
								
				// Adds cells to the model in a single step
				graph.getModel().beginUpdate();
				try
				{
					var v1 = graph.insertVertex(parent, null, 'Hello,', 20, 20, 80, 80);
					var v2 = graph.insertVertex(parent, null, 'World!', 200, 150, 80, 30);
					var e1 = graph.insertEdge(parent, null, '', v1, v2);
					
					var v3 = graph.insertVertex(parent, null, 'test', 230, 10, 200, 100, 'imagetest');
				}
				finally
				{
					// Updates the display
					graph.getModel().endUpdate();
				}
			}
			
		    /*** 鼠标样式初始化***/
		    var docAll = document.getElementById('graphContainer').children[0].children[1].children; 
		    for(var i=0;i<docAll.length;i++){
		        docAll[i].style.cursor='default';
		    }
		 	
			/*** 将id=graph中的纯界面层内容通过iframe展示出来***/ 
	        var cn =document.getElementById('graphContainer').innerHTML;
		    var ifr = document.createElement("iframe");
		    document.body.appendChild(ifr);
			var ifrdoc = ifr.document;
		    ifrdoc.open();
		    ifrdoc.writeln('<html>');
	        ifrdoc.writeln('<head>');
	        mxClient.link('stylesheet', mxClient.basePath + '/css/common.css', ifrdoc);
	        mxClient.link('stylesheet', mxClient.basePath + '/css/explorer.css', ifrdoc);
	        ifrdoc.writeln('</head>');
			ifrdoc.writeln("<body>");
			if (true) {
	            ifrdoc.namespaces.add("v", "urn:schemas-microsoft-com:vml");
	        }
		    ifrdoc.writeln(cn);
		    ifrdoc.writeln("</body>");
		    ifrdoc.writeln("</html>");
		    ifrdoc.close();
		};
	</script>
</head>

<!-- Page passes the container for the graph to the grogram -->
<body onload="main(document.getElementById('graphContainer'))">
	
	<!-- Creates a container for the graph with a grid wallpaper -->
	<div id="graphContainer"
		style="overflow:hidden;width:321px;height:241px;background:url('editors/images/grid.gif');cursor:default;">
	</div>
</body>
</html>
