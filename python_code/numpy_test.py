import numpy as np

# 벡터 덧셈
vector1 = np.array([1, 2, 3])
vector2 = np.array([4, 5, 6])
vector_sum = vector1 + vector2  # 결과: array([5, 7, 9])

print(vector_sum)

# 행렬 덧셈
matrix1 = np.array([[1, 2, 3],
                    [4, 5, 6],
                    [7, 8, 9]])
matrix2 = np.array([[9, 8, 7],
                    [6, 5, 4],
                    [3, 2, 1]])
matrix_sum = matrix1 + matrix2  # 결과: array([[10, 10, 10],
                                      #       [10, 10, 10],
                                      #       [10, 10, 10]])
print(matrix_sum)





