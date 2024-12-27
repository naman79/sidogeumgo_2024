
# 인천시: 6280000
# 강원특별자치도: 6530000
# 충청북도: 6430000
# 6280000 6530000 6430000

file_path = 'org_code.txt'
output_txt_path = 'filtered_org_code_2025.txt'

column_mapping = {
    '기관코드': 0, '전체기관명': 1, '최하위기관명': 2, '차수': 3, '서열': 4, '소속기관차수': 5,
    '차상위기관코드': 6, '최상위기관코드': 7, '대표기관코드': 8, '유형분류_대': 9, '유형분류_중': 10,
    '유형분류_소': 11, '우편번호': 12, '행정동코드': 13, '소재지코드': 14, '나머지주소': 15,
    '지번': 16, '전화번호': 17, '팩스번호': 18, '생성일자': 19, '폐지일자': 20, '변경일자': 21,
    '존폐여부': 22, '이전기관코드': 23
}

filter_codes = ['6280000', '6530000', '6430000']
columns_to_extract = list(column_mapping.keys())
results = []

def process_file(encoding):
    with open(file_path, 'r', encoding=encoding) as file:
        for line in file:
            data = line.strip().split('\t')
            if len(data) > 7 and data[7] in filter_codes:
                extracted_data = [data[column_mapping[col]] if len(data) > column_mapping[col] else 'NULL' for col in columns_to_extract]
                results.append('\t'.join(extracted_data))

try:
    process_file('cp949')
except UnicodeDecodeError:
    process_file('euc-kr')

with open(output_txt_path, 'w', encoding='cp949') as txtfile:
    txtfile.write('\t'.join(columns_to_extract) + '\n')
    for result in results:
        txtfile.write(result + '\n')

print(f"TXT file created: {output_txt_path}")

