package com.sitech.jcf.sample.soapConverter;

import java.io.IOException;
import java.io.StringReader;
import java.util.List;

import org.apache.cxf.helpers.IOUtils;
import org.apache.cxf.io.CachedOutputStream;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;
import org.jdom.output.Format;
import org.jdom.output.XMLOutputter;
import org.jdom.Namespace;

/**
 * 
 * <p>
 * Title: 转换来自ESB请求的soap报文
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2011
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author zhengweic
 * @version 1.0
 */
public class RemoveNsConverter{
	String testXml = "<soapenv:Envelope  xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:cu=\"chinaUnicom\">"
			+ "	<soapenv:Header/>"
			+ "	<soapenv:Body>"
			+ "			<cu:sayHi_REQ>"
			+ "				<!--请求头-->"
			+ "				<cu:UNI_BSS_REQ_HEAD>"
			+ "					<ODOMAIN_NO></ODOMAIN_NO>"
			+ "					<ODUNS></ODUNS>"
			+ "					<SERVICE_TYPE></SERVICE_TYPE>"
			+ "					<SERVICE_CODE></SERVICE_CODE>"
			+ "					<ROUTE_INFO>"
			+ "						<ROUTE_TYPE></ROUTE_TYPE>"
			+ "						<ROUTE_VALUE></ROUTE_VALUE>"
			+ "					</ROUTE_INFO>"
			+ "					<PROC_ID></PROC_ID>"
			+ "					<SERIAL_IDO></SERIAL_IDO>"
			+ "					<OPROCESS_TIME></OPROCESS_TIME>"
			+ "					<CUTOFFDAY></CUTOFFDAY>"
			+ "				</cu:UNI_BSS_REQ_HEAD>"
			+ "				<cu:sayHi_REQ_BODY>"
			+ "					<cu:name>zhangsan</cu:name>"
			+ "				</cu:sayHi_REQ_BODY>"
			+ "				<cu:UNI_BSS_ATTACHED>"
			+ "					<cu:MEDIA_INFO>"
			+ "					</cu:MEDIA_INFO>"
			+ "				</cu:UNI_BSS_ATTACHED>"
			+ "			</cu:sayHi_REQ>"
			+ "	</soapenv:Body>" + "</soapenv:Envelope>";


	public CachedOutputStream convertOut(String src)
			{
		CachedOutputStream cos = new CachedOutputStream();
		SAXBuilder builder = new SAXBuilder();
		try {
			// src = src.replaceAll("soapenv:", "").replaceAll("cu:",
			// "").replaceAll("\\s", " ");
			Document doc = builder.build(new StringReader(src));
			Element root = doc.getRootElement();// <soapenv:Envelope
												// xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
			Namespace soapNamespace = root.getNamespace();
			// Element header =
			// root.getChild("Header",soapNamespace);//<soapenv:Header>
			Element body = root.getChild("Body", soapNamespace);// <soapenv:Body>
			Element req = (Element) body.getChildren().get(0);// <cu:****_REQ>


			Namespace cuNamespace = req.getNamespace();
			String req_name = req.getName();
			String opName = req_name.substring(0, req_name.length() - 4);// sayHi
			Element req_body = req.getChild(opName + "_REQ_BODY", cuNamespace);// <cu:sayHi_REQ_BODY>

			removeNamespace(req);// deal with arguments,remove all namespace
									// info
			XMLOutputter outPutter = new XMLOutputter(Format.getPrettyFormat());
			outPutter.output(doc, cos);// output
		} catch (JDOMException e) {
			throw new RuntimeException(e);
		} catch (IOException e) {
			throw new RuntimeException(e);
		}

		return cos;

	}

	private void removeNamespace(Element e) {
		List children = e.getChildren();
		if (children == null || children.size() == 0)
			return;
		for (Object em : children) {
			Element ele = (Element) em;
			ele.setNamespace(null);
			removeNamespace(ele);
		}
	}

	public static void main(String[] args) throws Exception {
		RemoveNsConverter sc = new RemoveNsConverter();
		CachedOutputStream out = sc.convertOut(sc.testXml);
		System.out.println(IOUtils.toString(out.getInputStream()));
	}

}
