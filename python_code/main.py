import sys
import os
import pandas as pd

filePath = "c:\\Users\\admin\\Downloads\\unyong_info_20250428_20250429012515.dat"

# 파일을 읽어서 pandas DataFrame으로 변환
# sep='|'로 구분자를 지정하고, encoding='EUC-KR'로 인코딩 설정
df = pd.read_csv(filePath, sep='|', encoding='EUC-KR')

# 데이터프레임 정보 출력
print("\nDataFrame 정보:")
print(df.info())

# 처음 5개 행 출력
print("\n처음 5개 행:")
print(df.head())

# 컬럼 이름 출력
print("\n컬럼 이름:")
print(df.columns.tolist())





