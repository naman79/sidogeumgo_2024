"""
기관코드 필터링 스크립트

사용 방법:
1. https://www.code.go.kr/index.do 접속
2. 기관명 '인천시' 검색
3. 우측 하단 기관코드 전체자료 다운로드
4. 기관코드 전체자료.zip 압축풀기
5. 기관코드 전체자료.txt 파일을 열어 org_code.txt 로 저장하기
6. 하단의 파이썬 코드 파일을 실행하여 filtered_org_code_2025.txt 파일을 생성하기
   실행: python gigwan_extract.py [입력파일] [출력파일]
   예시: python gigwan_extract.py org_code.txt filtered_org_code_2025.txt
7. 보고서 시스템 > 시스템관리 > 행정기관코드관리 메뉴에서 파일업로드를 클릭하여
   filtered_org_code_2025.txt 파일을 업로드하기
8. 완료후 메세지 확인 (현재는 정상처리되었으나 메세지가 오류로 표시됨)

필터링 대상 지역:
- 6280000: 인천광역시
- 6530000: 전라남도
- 6430000: 충청남도
"""

import os
import sys
import argparse
import time
from typing import List, Set

# 컬럼 매핑 정의
COLUMN_MAPPING = {
    '기관코드': 0, '전체기관명': 1, '최하위기관명': 2, '차수': 3, '서열': 4, '소속기관차수': 5,
    '차상위기관코드': 6, '최상위기관코드': 7, '대표기관코드': 8, '유형분류_대': 9, '유형분류_중': 10,
    '유형분류_소': 11, '우편번호': 12, '행정동코드': 13, '소재지코드': 14, '나머지주소': 15,
    '지번': 16, '전화번호': 17, '팩스번호': 18, '생성일자': 19, '폐지일자': 20, '변경일자': 21,
    '존폐여부': 22, '이전기관코드': 23
}

# 필터링할 최상위 기관 코드 (6280000: 인천광역시, 6530000: 전라남도, 6430000: 충청남도)
FILTER_CODES: Set[str] = {'6280000', '6530000', '6430000'}
FILTER_NAMES = {'6280000': '인천광역시', '6530000': '전라남도', '6430000': '충청남도'}

# 지원 인코딩 목록
SUPPORTED_ENCODINGS: List[str] = ['cp949', 'euc-kr', 'utf-8']


def process_file_streaming(input_path: str, output_path: str, encoding: str) -> tuple[int, int]:
    """
    파일을 스트리밍 방식으로 읽어서 필터링된 데이터를 즉시 출력 파일에 작성
    (메모리 효율적)

    Args:
        input_path: 입력 파일 경로
        output_path: 출력 파일 경로
        encoding: 파일 인코딩 (cp949, euc-kr, utf-8 등)

    Returns:
        tuple: (총 라인 수, 필터링된 라인 수)
    """
    line_count = 0
    filtered_count = 0
    columns_to_extract = list(COLUMN_MAPPING.keys())

    with open(input_path, 'r', encoding=encoding) as infile, \
         open(output_path, 'w', encoding='cp949') as outfile:

        # 헤더 작성
        outfile.write('\t'.join(columns_to_extract) + '\n')

        # 데이터 처리
        for line in infile:
            line_count += 1
            data = line.strip().split('\t')

            # 최상위기관코드(인덱스 7) 확인
            if len(data) > 7 and data[7] in FILTER_CODES:
                extracted_data = [
                    data[COLUMN_MAPPING[col]] if len(data) > COLUMN_MAPPING[col] else 'NULL'
                    for col in columns_to_extract
                ]
                outfile.write('\t'.join(extracted_data) + '\n')
                filtered_count += 1

                # 진행률 표시 (10,000 라인마다)
                if filtered_count % 10000 == 0:
                    print(f"[진행중] {filtered_count:,}개 기관 데이터 처리됨...")

    return line_count, filtered_count


def parse_arguments():
    """커맨드라인 인자 파싱"""
    parser = argparse.ArgumentParser(
        description='기관코드 필터링 스크립트 - 인천광역시, 전라남도, 충청남도 기관 추출',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
사용 예시:
  python gigwan_extract.py
  python gigwan_extract.py org_code.txt filtered_output.txt
  python gigwan_extract.py --input data.txt --output result.txt
        """
    )

    parser.add_argument(
        'input_file',
        nargs='?',
        default='org_code.txt',
        help='입력 파일 경로 (기본값: org_code.txt)'
    )

    parser.add_argument(
        'output_file',
        nargs='?',
        default='filtered_org_code_2025.txt',
        help='출력 파일 경로 (기본값: filtered_org_code_2025.txt)'
    )

    parser.add_argument(
        '--input', '-i',
        dest='input_file_alt',
        help='입력 파일 경로 (대체 옵션)'
    )

    parser.add_argument(
        '--output', '-o',
        dest='output_file_alt',
        help='출력 파일 경로 (대체 옵션)'
    )

    args = parser.parse_args()

    # 대체 옵션이 제공된 경우 우선 사용
    input_path = args.input_file_alt if args.input_file_alt else args.input_file
    output_path = args.output_file_alt if args.output_file_alt else args.output_file

    return input_path, output_path


def main():
    """메인 실행 함수"""
    start_time = time.time()

    # 1. 커맨드라인 인자 파싱
    input_path, output_path = parse_arguments()

    # 2. 입력 파일 존재 확인
    if not os.path.exists(input_path):
        print(f"[오류] '{input_path}' 파일을 찾을 수 없습니다.")
        print(f"[도움말] python {sys.argv[0]} --help")
        sys.exit(1)

    print("=" * 80)
    print(f"[입력 파일] {input_path}")
    print(f"[출력 파일] {output_path}")
    print(f"[필터링 대상] {', '.join([f'{code}({FILTER_NAMES[code]})' for code in FILTER_CODES])}")
    print("=" * 80)

    # 3. 파일 처리 (인코딩 자동 감지 + 스트리밍 방식)
    success = False
    line_count = 0
    filtered_count = 0

    for encoding in SUPPORTED_ENCODINGS:
        try:
            print(f"\n[시도] '{encoding}' 인코딩으로 파일 읽기...")
            line_count, filtered_count = process_file_streaming(input_path, output_path, encoding)
            success = True
            print(f"[성공] {encoding} 인코딩으로 파일 처리 완료")
            break
        except UnicodeDecodeError:
            print(f"[경고] '{encoding}' 인코딩 실패, 다음 인코딩 시도...")
            # 실패한 출력 파일 삭제
            if os.path.exists(output_path):
                os.remove(output_path)
            continue
        except Exception as e:
            print(f"[오류] 처리 중 예외 발생: {e}")
            if os.path.exists(output_path):
                os.remove(output_path)
            sys.exit(1)

    if not success:
        print(f"\n[오류] 지원하는 모든 인코딩({', '.join(SUPPORTED_ENCODINGS)})으로 파일을 읽을 수 없습니다.")
        sys.exit(1)

    # 4. 결과 확인
    if filtered_count == 0:
        print("\n[경고] 필터링 조건에 맞는 데이터가 없습니다.")
        if os.path.exists(output_path):
            os.remove(output_path)
        return

    # 5. 결과 통계 출력
    elapsed_time = time.time() - start_time
    file_size = os.path.getsize(output_path)

    # 파일 크기 포맷팅
    if file_size < 1024:
        size_str = f"{file_size} bytes"
    elif file_size < 1024 * 1024:
        size_str = f"{file_size / 1024:.2f} KB"
    else:
        size_str = f"{file_size / (1024 * 1024):.2f} MB"

    print("\n" + "=" * 80)
    print(f"[완료] 처리 결과:")
    print(f"  - 총 라인 수: {line_count:,}개")
    print(f"  - 추출된 기관: {filtered_count:,}개")
    print(f"  - 필터링 비율: {(filtered_count / line_count * 100):.2f}%")
    print(f"  - 출력 파일: {output_path}")
    print(f"  - 파일 크기: {size_str}")
    print(f"  - 처리 시간: {elapsed_time:.2f}초")
    print("=" * 80)


if __name__ == "__main__":
    main()