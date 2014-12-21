package com.sitech.jcf.sample.soapConverter;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.StringReader;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.cxf.helpers.IOUtils;
import org.apache.cxf.io.CachedOutputStream;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.Namespace;
import org.jdom.input.SAXBuilder;
import org.jdom.output.Format;
import org.jdom.output.XMLOutputter;

import com.ibm.wsdl.util.StringUtils;
import com.sitech.jcf.ws.interceptors.SoapConverter;

public class SoapConverterImpl1 implements SoapConverter{
	private static final Log LOG = LogFactory.getLog(SoapConverterImpl1.class);
	/**
	 * 以入站报文为例
	 * 正确的报文是：
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.sample.jcf.sitech.com/">
   <soapenv:Header/>
   <soapenv:Body>
      <ser:queryPersonById>
         <person>
            <id>?</id>
            <name>?</name>
         </person>
      </ser:queryPersonById>
   </soapenv:Body>
</soapenv:Envelope>
	但是客户端发送的报文格式在每个节点前都加了namespace：ser——
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.sample.jcf.sitech.com/">
  <soapenv:Header />
  <soapenv:Body>
    <ser:queryPersonById>
      <ser:person>
        <ser:id>1234</ser:id>
      </ser:person>
    </ser:queryPersonById>
  </soapenv:Body>
</soapenv:Envelope>	
	我们需要去点person及其子节点的namespace
	这个动作在这里实现
	 */
	public CachedOutputStream convertIn(String src) {
		if (LOG.isDebugEnabled())
			LOG.debug("soap报文转换，入站原报文--->>>>>>>>"+src);
		CachedOutputStream cos = new CachedOutputStream();
		SAXBuilder builder = new SAXBuilder();
		Document doc;
		try {
			doc = builder.build(new StringReader(src));
			Element root = doc.getRootElement();
			Namespace soapNamespace = root.getNamespace();
			Element body = root.getChild("Body", soapNamespace);// Body
			
			Element req = (Element) body.getChildren().get(0);
			//只针对queryPersonById进行测试
			if(!req.getName().equals("queryPersonById")){
				CachedOutputStream ccos = new CachedOutputStream();
				//如果不是queryPersonById这个方法，报文不做修改
				
				IOUtils.copy(new ByteArrayInputStream(src.getBytes("UTF-8")), ccos);
				return ccos;
			}
			Element arg = (Element) req.getChildren().get(0);
			arg.setNamespace(null);//去掉person节点的ns
			//去掉person子节点的ns
			for(Object e:arg.getChildren()){
				((Element)e).setNamespace(null);
			}
			XMLOutputter outPutter = new XMLOutputter(Format.getPrettyFormat());
			outPutter.output(doc, System.out);// output
			outPutter.output(doc, cos);// output
			return cos;
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	public CachedOutputStream convertOut(String src) {
		CachedOutputStream cos = new CachedOutputStream();
		SAXBuilder builder = new SAXBuilder();
		try {
			Document doc = builder.build(new StringReader(src));
			Element root = doc.getRootElement();

			XMLOutputter outPutter = new XMLOutputter(Format.getPrettyFormat());
			outPutter.output(doc, cos);// output
		} catch (JDOMException e) {
			throw new RuntimeException(e);
		} catch (IOException e) {
			throw new RuntimeException(e);
		}

		return cos;
	}
}
