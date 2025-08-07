import pandas as pd

# 숫자 표기 옵션 설정 (지수 표기 대신 천 단위 콤마)
pd.set_option('display.float_format', '{:,.0f}'.format)

df = pd.read_csv(r"C:\Users\admin\Documents\sidogeumgo_2024\python_code\sample1.csv", encoding="cp949")
print(df.head())

# NaN 확인하기
print(df.isnull().sum())

# ALL_JUCHUK_AMT 컬럼의 데이터 전체 보기
print(df['ALL_JUCHUK_AMT'])

# NaN 처리하기
#print(df.isnull().sum())