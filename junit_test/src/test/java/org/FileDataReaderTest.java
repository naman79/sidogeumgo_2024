package org;

import java.io.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class FileDataReaderTest {

    @Test
    public void testReadData() throws IOException {
        String filePath = "c:\\Users\\admin\\Downloads\\unyong_info_20250428_20250429012515.dat";
        List<String[]> resultList = readData(filePath);

        for (String[] result : resultList) {
            System.out.println(Arrays.toString(result));
        }
    }

    @Test
    void sampleTest() {
        assertEquals(2, 1 + 1);
    }

    public List<String[]> readData(String filePath) throws IOException {
        List<String[]> dataList = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(
                new InputStreamReader(new FileInputStream(filePath), "EUC-KR"))) {
            String line;
            while ((line = reader.readLine()) != null) {
                dataList.add(parseLine(line));
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