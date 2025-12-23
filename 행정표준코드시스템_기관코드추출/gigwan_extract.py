"""
기관코드 필터링 스크립트

사용 방법:
1. https://www.code.go.kr/index.do 접속
2. 기관명 '인천시' 검색
3. 우측 하단 기관코드 전체자료 다운로드
4. 기관코드 전체자료.zip 압축풀기
5. 기관코드 전체자료.txt 파일을 열어 org_code.txt 로 저장하기
6. 하단의 파이썬 코드 파일을 실행하여 filtered_org_code_2025.txt 파일을 생성하기
   실행: python gigwan_extract.py
7. 보고서 시스템 > 시스템관리 > 행정기관코드관리 메뉴에서 파일업로드를 클릭하여
   filtered_org_code_2025.txt 파일을 업로드하기
8. 완료후 메세지 확인 (현재는 정상처리되었으나 메세지가 오류로 표시됨)
9. 안동시만 추출하기 원했으나 최상위기관 경상북도만으로만 추출이 가능해서 수동으로 해당  코드 복사해서 붙여서 안동추가함(20251216)

필터링 대상 지역:
- 6280000: 인천광역시
- 6420000: 강원도
- 6430000: 충청남도
- 6470000: 경상북도
- 5070000: 안동시
"""

import os
import sys

# 파일 경로 설정
file_path = 'org_code.txt'
output_txt_path = 'filtered_org_code_2025.txt'

# 컬럼 매핑 정의
column_mapping = {
    '기관코드': 0, '전체기관명': 1, '최하위기관명': 2, '차수': 3, '서열': 4, '소속기관차수': 5,
    '차상위기관코드': 6, '최상위기관코드': 7, '대표기관코드': 8, '유형분류_대': 9, '유형분류_중': 10,
    '유형분류_소': 11, '우편번호': 12, '행정동코드': 13, '소재지코드': 14, '나머지주소': 15,
    '지번': 16, '전화번호': 17, '팩스번호': 18, '생성일자': 19, '폐지일자': 20, '변경일자': 21,
    '존폐여부': 22, '이전기관코드': 23
}

# 필터링할 최상위 기관 코드 (6280000: 인천광역시, 6420000: 강원도, 6430000: 충청남도)
filter_codes = ['6280000', '6420000', '6430000','6470000']
filter_names = {'6280000': '인천광역시', '6420000': '강원도', '6430000': '충청남도', '6470000': '경상북도'}

columns_to_extract = list(column_mapping.keys())
results = []


def process_file(encoding):
    """
    파일을 읽어서 필터링된 데이터를 results 리스트에 추가

    Args:
        encoding: 파일 인코딩 (cp949, euc-kr, utf-8 등)
    """
    line_count = 0
    filtered_count = 0

    with open(file_path, 'r', encoding=encoding) as file:
        for line in file:
            line_count += 1
            data = line.strip().split('\t')

            # 최상위기관코드(인덱스 7) 확인
            if len(data) > 7 and data[7] in filter_codes:
                extracted_data = [
                    data[column_mapping[col]] if len(data) > column_mapping[col] else 'NULL'
                    for col in columns_to_extract
                ]
                results.append('\t'.join(extracted_data))
                filtered_count += 1

    print(f"[인코딩: {encoding}] 총 {line_count:,}개 라인 중 {filtered_count:,}개 기관 데이터 추출")
    return filtered_count


def main():
    """메인 실행 함수"""

    # 1. 입력 파일 존재 확인
    if not os.path.exists(file_path):
        print(f"[오류] '{file_path}' 파일을 찾을 수 없습니다.")
        sys.exit(1)

    print(f"[입력 파일] {file_path}")
    print(f"[출력 파일] {output_txt_path}")
    print(f"[필터링 대상] {', '.join([f'{code}({filter_names[code]})' for code in filter_codes])}")
    print("-" * 80)

    # 2. 파일 읽기 (인코딩 자동 감지)
    encodings = ['cp949', 'euc-kr', 'utf-8']
    success = False

    for encoding in encodings:
        try:
            print(f"[시도] '{encoding}' 인코딩으로 파일 읽기...")
            filtered_count = process_file(encoding)
            success = True
            break
        except UnicodeDecodeError:
            print(f"[경고] '{encoding}' 인코딩 실패, 다음 인코딩 시도...")
            continue
        except Exception as e:
            print(f"[오류] {e}")
            sys.exit(1)

    if not success:
        print(f"[오류] 지원하는 모든 인코딩({', '.join(encodings)})으로 파일을 읽을 수 없습니다.")
        sys.exit(1)

    # 3. 결과 확인
    if len(results) == 0:
        print("[경고] 필터링 조건에 맞는 데이터가 없습니다.")
        return

    # 4. 결과 파일 저장
    try:
        with open(output_txt_path, 'w', encoding='cp949') as txtfile:
            # 데이터 작성 (헤더 없이)
            for result in results:
                txtfile.write(result + '\n')

        print("-" * 80)
        print(f"[완료] {len(results):,}개 기관 데이터를 '{output_txt_path}' 파일로 저장했습니다.")

        # 파일 크기 출력
        file_size = os.path.getsize(output_txt_path)
        if file_size < 1024:
            size_str = f"{file_size} bytes"
        elif file_size < 1024 * 1024:
            size_str = f"{file_size / 1024:.2f} KB"
        else:
            size_str = f"{file_size / (1024 * 1024):.2f} MB"

        print(f"[파일 크기] {size_str}")

    except IOError as e:
        print(f"[오류] 파일 저장 중 오류 발생: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()