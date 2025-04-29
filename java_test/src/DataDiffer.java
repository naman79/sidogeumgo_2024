import java.util.*;

public class DataDiffer {
    /**
     * base 리스트에만 존재하는 행을 반환합니다.
     * @param base 기준 데이터 리스트
     * @param compare 비교 대상 데이터 리스트
     * @return base에만 있는 행 리스트
     */
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
