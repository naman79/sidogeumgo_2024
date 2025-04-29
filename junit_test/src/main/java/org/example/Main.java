package org.example;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

//TIP 코드를 <b>실행</b>하려면 <shortcut actionId="Run"/>을(를) 누르거나
// 에디터 여백에 있는 <icon src="AllIcons.Actions.Execute"/> 아이콘을 클릭하세요.
public class Main {
    public static void main(String[] args) {

        String filePath = "c:\\Users\\admin\\Downloads\\unyong_info_20250428_20250429012515.dat";
        List<String[]> dataList = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(
                new InputStreamReader(new FileInputStream(filePath), "EUC-KR"))) {
            String line;
            while ((line = reader.readLine()) != null) {
                // "|" 구분자로 데이터 분리
                String[] data = line.split("\\|");

                // 각 데이터 trim 처리
                for (int i = 0; i < data.length; i++) {
                    data[i] = data[i].trim();
                }

                // ArrayList에 데이터 추가
                dataList.add(data);
            }

            // 시도금고관리번후 수정 건이 있는지 확인
            int resultCount = 0;
            // 저장된 데이터 출력 (확인용)
            for (int i = 0; i < dataList.size(); i++) {
                System.out.println("행 " + (i + 1) + ":");
                String[] row = dataList.get(i);
                for (int j = 0; j < row.length; j++) {
                    if (j == 16) {
                        if (!row[15].equals("0")) {
                            System.out.println("  컬럼 " + (j + 1) + ": " + row[j]);
                            resultCount++;
                        }
                    }
                }
                System.out.println("------------------------");
            }
            System.out.println("결과 개수: " + resultCount);
        } catch (IOException e) {
            System.err.println("파일 읽기 오류: " + e.getMessage());
            e.printStackTrace();
        }
    }

}