import random

PROBLEMS = [
    {"question": "커서를 줄의 처음으로 이동하는 명령어?", "answer": "0"},
    {"question": "커서를 줄의 끝으로 이동하는 명령어?", "answer": "$"},
    {"question": "한 단어 앞으로 이동하는 명령어?", "answer": "w"},
    {"question": "한 단어 뒤로 이동하는 명령어?", "answer": "b"},
    {"question": "현재 줄 삭제?", "answer": "dd"},
    {"question": "현재 문자 삭제?", "answer": "x"},
    {"question": "줄 복사?", "answer": "yy"},
    {"question": "붙여넣기?", "answer": "p"},
]

def start_quiz():
    print("=== Vim 명령어 연습 프로그램 ===")
    print("종료하려면 'quit' 입력\n")

    while True:
        problem = random.choice(PROBLEMS)
        q = problem["question"]
        a = problem["answer"]

        user_input = input(f"Q: {q}\n>>> ")

        if user_input.lower() in ("quit", "exit"):
            print("연습을 종료합니다.")
            break

        if user_input == a:
            print("✔ 정답!\n")
        else:
            print(f"❌ 오답! 정답은 '{a}' 입니다.\n")


if __name__ == "__main__":
    start_quiz()
