export interface VimProblem {
  question: string;
  answer: string;
}

export interface Stats {
  correct: number;
  incorrect: number;
  total: number;
}

export interface Feedback {
  type: 'correct' | 'incorrect';
  message: string;
}

export const PROBLEMS: VimProblem[] = [
  { question: "커서를 줄의 처음으로 이동하는 명령어?", answer: "0" },
  { question: "커서를 줄의 끝으로 이동하는 명령어?", answer: "$" },
  { question: "한 단어 앞으로 이동하는 명령어?", answer: "w" },
  { question: "한 단어 뒤로 이동하는 명령어?", answer: "b" },
  { question: "현재 줄 삭제?", answer: "dd" },
  { question: "현재 문자 삭제?", answer: "x" },
  { question: "줄 복사?", answer: "yy" },
  { question: "붙여넣기?", answer: "p" },
  { question: "실행 취소(되돌리기)?", answer: "u" },
  { question: "다시 실행?", answer: "Ctrl+r" },
  { question: "파일 저장?", answer: ":w" },
  { question: "파일 저장하고 종료?", answer: ":wq" },
  { question: "저장하지 않고 종료?", answer: ":q!" },
  { question: "Insert 모드로 전환?", answer: "i" },
  { question: "현재 줄 끝에서 Insert 모드?", answer: "A" },
  { question: "새 줄 아래에 추가하고 Insert 모드?", answer: "o" },
  { question: "검색?", answer: "/" },
  { question: "다음 검색 결과로 이동?", answer: "n" },
  { question: "이전 검색 결과로 이동?", answer: "N" },
  { question: "파일 처음으로 이동?", answer: "gg" },
  { question: "파일 끝으로 이동?", answer: "G" },
];
