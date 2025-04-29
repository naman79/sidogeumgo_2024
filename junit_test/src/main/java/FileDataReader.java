package org.example;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class FileDataReader {
    private final String filePath;

    public FileDataReader(String filePath) {
        this.filePath = filePath;
    }

    public List<String[]> readData() throws IOException {
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