package de.uniwue.helper;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Base64;

public class ImageHelper {

    public ImageHelper() {
    }

    public String encodeFileToBase64Binary(File file) throws IOException {
        String encodedfile = null;
        FileInputStream fileInputStreamReader = new FileInputStream(file);
        byte[] bytes = new byte[(int) file.length()];
        fileInputStreamReader.read(bytes);
        encodedfile = Base64.getEncoder().encodeToString(bytes);
        fileInputStreamReader.close();
        return encodedfile;
    }

    public String getPageImage(String projectDir, String pageID, String imageID) throws IOException {
        String base64Image = null;
        File f = null;
        if (imageID.equals("Original")) {
            f = new File(projectDir + File.separator + "Original" + File.separator + pageID + ".png");
        } else {
            if (imageID.equals("Gray")) {
                f = new File(projectDir + File.separator + "PreProc" + File.separator + "Gray" + File.separator + pageID
                        + ".png");
            }
            if (imageID.equals("Binary")) {
                f = new File(projectDir + File.separator + "PreProc" + File.separator + "Binary" + File.separator
                        + pageID + ".png");
            }
            if (imageID.equals("Despeckled")) {
                f = new File(projectDir + File.separator + "PreProc" + File.separator + "Despeckled" + File.separator
                        + pageID + ".png");
            }
        }
        if (f.exists())
            base64Image = encodeFileToBase64Binary(f);

        return base64Image;
    }

    public String getSegmentImage(String projectDir, String pageID, String segmentID, String imageType)
            throws IOException {
        String base64Image = null;
        File f = null;
        if (imageType.equals("Gray"))
            f = new File(projectDir + File.separator + "OCR" + File.separator + "Pages" + File.separator + pageID
                    + File.separator + segmentID + ".nrm.png");
        if (imageType.equals("Binary"))
            f = new File(projectDir + File.separator + "OCR" + File.separator + "Pages" + File.separator + pageID
                    + File.separator + segmentID + ".bin.png");
        if (f.exists())
            base64Image = encodeFileToBase64Binary(f);

        return base64Image;
    }

    public String getLineImage(String projectDir, String pageID, String segmentID, String lineID, String imageType)
            throws IOException {
        String base64Image = null;
        File f = null;
        if (imageType.equals("Gray"))
            f = new File(projectDir + File.separator + "OCR" + File.separator + "Pages" + File.separator + pageID
                    + File.separator + segmentID + File.separator + lineID + ".nrm.png");
        if (imageType.equals("Binary"))
            f = new File(projectDir + File.separator + "OCR" + File.separator + "Pages" + File.separator + pageID
                    + File.separator + segmentID + File.separator + lineID + ".bin.png");
        if (f.exists())
            base64Image = encodeFileToBase64Binary(f);
        return base64Image;
    }

}