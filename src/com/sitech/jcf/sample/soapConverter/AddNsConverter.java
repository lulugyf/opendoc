package com.sitech.jcf.sample.soapConverter;

import java.io.StringReader;
import java.util.List;

import org.apache.cxf.helpers.IOUtils;
import org.apache.cxf.io.CachedOutputStream;
import org.apache.log4j.Logger;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.Namespace;
import org.jdom.input.SAXBuilder;
import org.jdom.output.Format;
import org.jdom.output.XMLOutputter;

public class AddNsConverter{
	private final Logger LOG = Logger.getLogger(getClass());
	String testXml="<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">" +
			"   <soap:Body>" +
			"      <ns2:HELLO_REQResponse xmlns:ns2=\"chinaUnicom\">" +
			"         <HELLO_RSP>" +
			"            <HELLO_RES_BODY>" +
			"               <name>zhangsan</name>" +
			"            </HELLO_RES_BODY>" +
			"         </HELLO_RSP>" +
			"      </ns2:HELLO_REQResponse>" +
			"   </soap:Body>" +
			"</soap:Envelope>";

	public CachedOutputStream convertIn(String src){
//		LOG.info("--->>>>>>>>"+src);
		CachedOutputStream cos = new CachedOutputStream();
		SAXBuilder builder = new SAXBuilder();
		Document doc;
		try {
			doc = builder.build(new StringReader(src));
			Element root = doc.getRootElement();
			Namespace soapNamespace = root.getNamespace();
			Namespace cuNamespace = Namespace.getNamespace("cu", "chinaUnicom");
			root.addNamespaceDeclaration(cuNamespace);
			Element body = root.getChild("Body", soapNamespace);// Body
			Element response = (Element) body.getChildren().get(0);// <ns2:HELLO_REQResponse xmlns:ns2="chinaUnicom">
			Element rps = (Element) response.getChildren().get(0);
			addNs(response, cuNamespace);
			addNs(rps, cuNamespace);
			List rpsList = response.cloneContent();
			body.removeChild(response.getName(), response.getNamespace());
			body.addContent(rpsList);
			XMLOutputter outPutter = new XMLOutputter(Format.getPrettyFormat());
			outPutter.output(doc, cos);// output
			return cos;
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	private void addNs(Element parent, Namespace ns) {
		List children = parent.getChildren();
		if (children == null || children.size() == 0)
			return;
		for (Object em : children) {
			Element ele = (Element) em;
			ele.setNamespace(ns);
//			addNs(ele, ns);
		}
	}
	public static void main(String[] args) throws Exception {
		AddNsConverter converter = new AddNsConverter();
		CachedOutputStream out = (CachedOutputStream) converter.convertIn(converter.testXml);
		System.out.println(IOUtils.toString(out.getInputStream()));
	}

}
