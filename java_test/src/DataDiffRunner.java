import java.io.IOException;
import java.util.List;
import java.util.ArrayList;
import java.util.Set;
import java.util.HashSet;
import java.util.Arrays;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.FileInputStream;
import java.nio.charset.Charset;

public class DataDiffRunner {
    /**
     * 두 파일을 파싱, 비교, 결과 출력까지 처리합니다.
     * @param filePath 기준 파일 경로
     * @param filePath1 비교 파일 경로
     * @param charsetName 문자셋
     */
    public void runDiff(String filePath, String filePath1, String charsetName) {
        try {
            List<String[]> dataList1 = parseFile(filePath, charsetName);
            List<String[]> dataList2 = parseFile(filePath1, charsetName);

            List<String[]> uniqueRows = findUniqueRows(dataList1, dataList2);

            System.out.println("filePath에만 있는 데이터:");
            for (int i = 0; i < uniqueRows.size(); i++) {
                String[] row = uniqueRows.get(i);
                System.out.println("행 " + (i + 1) + ":");
                for (int j = 0; j < row.length; j++) {
                    System.out.println("  컬럼 " + (j + 1) + ": " + row[j]);
                }
                System.out.println("------------------------");
            }
            System.out.println("총 " + uniqueRows.size() + "개의 데이터가 filePath에만 있습니다.");
        } catch (IOException e) {
            System.err.println("파일 읽기 오류: " + e.getMessage());
            e.printStackTrace();
        }
    }

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

    public List<String[]> findUniqueRows(List<String[]> base, List<String[]> compare) {
        Set<String> compareSet = new HashSet<>();
        for (String[] row : compare) {
            compareSet.add(Arrays.toString(row));
        }
        List<String[]> uniqueRows = new ArrayList<>();
        for (String[] row : base) {
            if (!compareSet.contains(Arrays.toString(row))) {
                uniqueRows.add(row);
            }
        }
        return uniqueRows;
    }
}
