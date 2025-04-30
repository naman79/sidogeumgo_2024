import io
from typing import List, Set

class DataDiffRunner:
    """
    두 파일을 파싱, 비교, 결과 출력까지 처리합니다.
    """
    def run_diff(self, file_path: str, file_path1: str, charset_name: str) -> None:
        """
        Args:
            file_path: 기준 파일 경로
            file_path1: 비교 파일 경로
            charset_name: 문자셋
        """
        try:
            data_list1 = self.parse_file(file_path, charset_name)
            data_list2 = self.parse_file(file_path1, charset_name)

            unique_rows = self.find_unique_rows(data_list1, data_list2)

            print("filePath에만 있는 데이터:")
            for i, row in enumerate(unique_rows, 1):
                print(f"행 {i}:")
                for j, value in enumerate(row, 1):
                    print(f"  컬럼 {j}: {value}")
                print("------------------------")
            print(f"총 {len(unique_rows)}개의 데이터가 filePath에만 있습니다.")
        except Exception as e:
            print(f"파일 읽기 오류: {str(e)}")
            import traceback
            traceback.print_exc()

    def parse_file(self, file_path: str, charset_name: str) -> List[List[str]]:
        data_list = []
        with io.open(file_path, 'r', encoding=charset_name) as file:
            for line in file:
                data = self.parse_line(line)
                data_list.append(data)
        return data_list

    def parse_line(self, line: str) -> List[str]:
        data = line.strip().split('|')
        return [item.strip() for item in data]

    def find_unique_rows(self, base: List[List[str]], compare: List[List[str]]) -> List[List[str]]:
        compare_set = {tuple(row) for row in compare}
        unique_rows = []
        for row in base:
            if tuple(row) not in compare_set:
                unique_rows.append(row)
        return unique_rows
