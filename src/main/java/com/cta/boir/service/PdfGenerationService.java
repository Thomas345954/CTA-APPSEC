package com.cta.boir.service;
import com.itextpdf.text.DocumentException;

import org.springframework.stereotype.Service;
import org.xhtmlrenderer.pdf.ITextRenderer;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
@Service
public class PdfGenerationService {
	 public byte[] generatePdfFromHtml(String htmlContent) throws IOException, DocumentException, com.lowagie.text.DocumentException {
	        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
	        ITextRenderer renderer = new ITextRenderer();
	        renderer.setDocumentFromString(htmlContent);
	        renderer.layout();
	        renderer.createPDF(byteArrayOutputStream);
	        return byteArrayOutputStream.toByteArray();
	    }
}
