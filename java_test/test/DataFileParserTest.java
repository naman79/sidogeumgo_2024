import org.junit.Test;
import static org.junit.Assert.*;
import java.util.*;
import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.HashSet;
import java.util.Arrays;
import java.nio.charset.Charset;

public class DataFileParserTest {
    @Test
    public void testParseLine_basic() throws IOException {
        DataDiffRunner runner = new DataDiffRunner();
        runner.runDiff(
                "c:\\Users\\admin\\Downloads\\unyong_info_20250428_20250429012515.dat",
                "c:\\Users\\admin\\Downloads\\unyong_info_20250425_20250426012520.dat",
                "EUC-KR");
    }

    @Test
    public void testParseLine_emptyColumns() {
        System.out.println("testParseLine_emptyColumns");
    }
}
