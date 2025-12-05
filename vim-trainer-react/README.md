# Vim 명령어 연습 (React + TypeScript)

Vim 명령어를 연습할 수 있는 인터랙티브 웹 애플리케이션입니다.

## 기술 스택

- React 18
- TypeScript
- Vite
- CSS3

## 기능

- 랜덤 vim 명령어 퀴즈
- 정답/오답 실시간 피드백
- 정확도 통계 추적 (정답, 오답, 정확도 %)
- 진행률 바
- 다음 문제로 건너뛰기
- 통계 초기화
- 반응형 디자인

## 설치 및 실행

### 1. 의존성 설치

```bash
npm install
```

### 2. 개발 서버 실행

```bash
npm run dev
```

브라우저에서 http://localhost:5173 으로 접속하세요.

### 3. 빌드

```bash
npm run build
```

빌드된 파일은 `dist` 폴더에 생성됩니다.

### 4. 프리뷰

```bash
npm run preview
```

## 프로젝트 구조

```
vim-trainer-react/
├── src/
│   ├── App.tsx          # 메인 컴포넌트
│   ├── App.css          # 스타일
│   ├── main.tsx         # 진입점
│   ├── types.ts         # TypeScript 타입 정의
│   └── vite-env.d.ts    # Vite 타입 정의
├── index.html           # HTML 템플릿
├── package.json         # 의존성 관리
├── tsconfig.json        # TypeScript 설정
├── tsconfig.node.json   # Node용 TypeScript 설정
└── vite.config.ts       # Vite 설정
```

## 타입 정의

주요 TypeScript 인터페이스:

- `VimProblem`: 문제와 정답 구조
- `Stats`: 통계 데이터 (정답, 오답, 전체)
- `Feedback`: 피드백 메시지 타입

## 라이선스

MIT
