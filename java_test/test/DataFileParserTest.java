import org.junit.Test;
import static org.junit.Assert.*;
import java.util.*;
import java.io.*;

public class DataFileParserTest {
    @Test
    public void testParseLine_basic() throws IOException {
        DataFileParser parser = new DataFileParser();
        String filePath = "c:\\Users\\admin\\Downloads\\unyong_info_20250428_20250429012515.dat";
        String charsetName = "EUC-KR";

        List<String[]> dataList = parser.parseFile(filePath, charsetName);

        for (int i = 0; i < dataList.size(); i++) {
            System.out.println("행 " + (i + 1) + ":");
            String[] row = dataList.get(i);
            for (int j = 0; j < row.length; j++) {
                System.out.println("  컬럼 " + (j + 1) + ": " + row[j]);
            }
            System.out.println("------------------------");
        }

    }

    @Test
    public void testParseLine_emptyColumns() {
        DataFileParser parser = new DataFileParser();
        String line = " |  b  | ";
        String[] result = parser.parseLine(line);
        assertArrayEquals(new String[] { "", "b", "" }, result);
    }
}
