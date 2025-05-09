import sys
import os
import pandas as pd
import numpy as np

filePath = "c:\\Users\\admin\\Downloads\\unyong_info_20250428_20250429012515.dat"
filePath1 = "c:\\Users\\admin\\Downloads\\unyong_info_20250507_20250508012511.dat"


# 파일을 읽어서 pandas DataFrame으로 변환
# sep='|'로 구분자를 지정하고, encoding='EUC-KR'로 인코딩 설정
df = pd.read_csv(filePath, sep='|', encoding='EUC-KR')
df1 = pd.read_csv(filePath1, sep='|', encoding='EUC-KR')

# 데이터프레임 크기 비교
print("\n데이터프레임 크기 비교:")
print(f"df 크기: {df.shape}")
print(f"df1 크기: {df1.shape}")

# 컬럼 비교
print("\n컬럼 비교:")
print("df 컬럼:", df.columns.tolist())
print("df1 컬럼:", df1.columns.tolist())

# 컬럼이 동일한지 확인
print("\n컬럼 동일 여부:", set(df.columns) == set(df1.columns))

# 데이터 샘플 비교
print("\n각 데이터프레임의 처음 5개 행:")
print("\ndf 처음 5개 행:")
print(df.head())
print("\ndf1 처음 5개 행:")
print(df1.head())

# 데이터 타입 비교
print("\n데이터 타입 비교:")
print("\ndf 데이터 타입:")
print(df.dtypes)
print("\ndf1 데이터 타입:")
print(df1.dtypes)

# 결측치 비교
print("\n결측치 비교:")
print("\ndf 결측치:")
print(df.isnull().sum())
print("\ndf1 결측치:")
print(df1.isnull().sum())

# 공통 인덱스 찾기
common_indices = df.index.intersection(df1.index)
print(f"\n공통 인덱스 수: {len(common_indices)}")

# 각 컬럼별로 다른 데이터 출력 (같은 인덱스끼리만 비교)
print("\n=== 컬럼별 다른 데이터 ===")
for column in df.columns:
    if column in df1.columns:
        try:
            # 데이터 타입이 다른 경우를 처리
            df_col = df.loc[common_indices, column].astype(str)
            df1_col = df1.loc[common_indices, column].astype(str)
            
            # 해당 컬럼에서 다른 값이 있는 행 찾기
            diff_mask = df_col != df1_col
            if diff_mask.any():
                diff_indices = common_indices[diff_mask]
                print(f"\n컬럼 '{column}'의 다른 데이터:")
                print(f"- 다른 데이터 수: {len(diff_indices)}")
                print("\n인덱스와 데이터 비교:")
                for idx in diff_indices:
                    print(f"인덱스: {idx}")
                    print(f"df 값: {df.loc[idx, column]}")
                    print(f"df1 값: {df1.loc[idx, column]}")
                    print("-" * 40)
        except Exception as e:
            print(f"컬럼 '{column}' 처리 중 오류 발생: {str(e)}")

# 새로운 데이터 출력 (df1에만 있는 인덱스)
print("\n=== df1에만 있는 새로운 데이터 ===")
try:
    # df1에만 있는 인덱스 찾기
    new_indices = df1.index.difference(df.index)
    if len(new_indices) > 0:
        print(f"\n새로운 데이터 수: {len(new_indices)}")
        print("\n새로운 데이터의 인덱스:")
        for idx in new_indices:
            print(f"인덱스: {idx}")
            print("데이터:")
            print(df1.loc[idx])
            print("-" * 40)
    else:
        print("\n새로운 데이터가 없습니다.")
except Exception as e:
    print(f"새로운 데이터 추출 중 오류 발생: {str(e)}")




