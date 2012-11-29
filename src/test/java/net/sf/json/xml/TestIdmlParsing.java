package net.sf.json.xml;

import net.sf.json.JSON;
import net.sf.json.JSONObject;
import org.custommonkey.xmlunit.Diff;
import org.custommonkey.xmlunit.XMLTestCase;
import org.xml.sax.SAXException;

import javax.xml.parsers.ParserConfigurationException;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

public class TestIdmlParsing extends XMLTestCase {

   public void testShouldParseAndReSerializeIdmlDocument() throws IOException, ParserConfigurationException, SAXException {

      final XMLSerializer xmlSerializer = getXmlSerializer();

      String fixture = toString( "net/sf/json/xml/idml_document.idms" );

      JSON json = xmlSerializer.read( fixture );
      final String result = xmlSerializer.write( json );

      final Diff diff = compareXML( stripWhiteSpace( fixture ), stripWhiteSpace( result ));

//      System.out.println(stripWhiteSpace( fixture ));
//      System.out.println(stripWhiteSpace( result ));
//      System.out.println( "json = " + json.toString(2) );

      assertTrue( "Found difference: " + diff.toString(), diff.identical() );
   }

/*   public void test_should_parse_2nd_document() throws IOException, ParserConfigurationException, SAXException {

      final XMLSerializer xmlSerializer = getXmlSerializer();

      String fixture = toString( "net/sf/json/xml/idml_document2.idms" );

      JSON json = xmlSerializer.read( fixture );
      final String result = xmlSerializer.write( json );

      final Diff diff = compareXML( stripWhiteSpace( fixture ), stripWhiteSpace( result ));

//      System.out.println(stripWhiteSpace( fixture ));
//      System.out.println(stripWhiteSpace( result ));
//      System.out.println( "json = " + json.toString(2) );

      assertTrue( "Found difference: " + diff.toString(), diff.identical() );

   } */

   private XMLSerializer getXmlSerializer() {
      final XMLSerializer xmlSerializer = new XMLSerializer();
      xmlSerializer.setEscapeLowerChars( true );
      xmlSerializer.setKeepArrayName( true );
      xmlSerializer.setPerformAutoExpansion( true );
      xmlSerializer.setKeepCData( true );
      xmlSerializer.setTypeHintsEnabled( false );
      xmlSerializer.setTypeHintsCompatibility( false );
      xmlSerializer.setRootName( "Document" );
      return xmlSerializer;
   }

   private String stripWhiteSpace( String xmlFromFile ) {
      String xml = xmlFromFile.replaceAll( "\\s*(/?)>\\s+<", "$1><" );
      xml = xml.replaceAll( "\\s\\s+", " " );
      xml = xml.replace( "\n", "" );
      return xml;
   }

   private String toString( String path ) throws IOException {
      final InputStream inputStream = Thread.currentThread()
            .getContextClassLoader()
            .getResourceAsStream( path );
      try{
         StringBuffer result = new StringBuffer();
         BufferedReader in = new BufferedReader( new InputStreamReader( inputStream ) );
         String line = null;
         while( (line = in.readLine()) != null ){
            result.append( line );
         }
         return result.toString();
      } finally{
         inputStream.close();
      }
   }
}
