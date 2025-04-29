import java.io.*;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;

public class DataFileParser {
    public List<String[]> parseFile(String filePath, String charsetName) throws IOException {
        List<String[]> dataList = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(
                new InputStreamReader(new FileInputStream(filePath), Charset.forName(charsetName)))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = parseLine(line);
                dataList.add(data);
            }
        }
        return dataList;
    }

    public String[] parseLine(String line) {
        String[] data = line.split("\\|");
        for (int i = 0; i < data.length; i++) {
            data[i] = data[i].trim();
        }
        return data;
    }
}
