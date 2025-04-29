import java.io.IOException;
import java.util.List;

public class DataDiffRunner {
    /**
     * 두 파일을 파싱, 비교, 결과 출력까지 처리합니다.
     * @param filePath 기준 파일 경로
     * @param filePath1 비교 파일 경로
     * @param charsetName 문자셋
     */
    public void runDiff(String filePath, String filePath1, String charsetName) {
        DataFileParser parser = new DataFileParser();
        try {
            List<String[]> dataList1 = parser.parseFile(filePath, charsetName);
            List<String[]> dataList2 = parser.parseFile(filePath1, charsetName);

            DataDiffer differ = new DataDiffer();
            List<String[]> uniqueRows = differ.findUniqueRows(dataList1, dataList2);

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
}
