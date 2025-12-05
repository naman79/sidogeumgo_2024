import { useState, useEffect, FormEvent, useRef } from 'react';
import { VimProblem, Stats, Feedback, PROBLEMS } from './types';
import './App.css';

function App() {
  const [currentProblem, setCurrentProblem] = useState<VimProblem | null>(null);
  const [userAnswer, setUserAnswer] = useState<string>("");
  const [feedback, setFeedback] = useState<Feedback | null>(null);
  const [stats, setStats] = useState<Stats>({
    correct: 0,
    incorrect: 0,
    total: 0
  });
  const inputRef = useRef<HTMLInputElement>(null);

  useEffect(() => {
    getRandomProblem();
  }, []);

  const getRandomProblem = (): void => {
    const randomIndex = Math.floor(Math.random() * PROBLEMS.length);
    setCurrentProblem(PROBLEMS[randomIndex]);
    setUserAnswer("");
    setFeedback(null);
  };

  const handleSubmit = (e: FormEvent<HTMLFormElement>): void => {
    e.preventDefault();
    if (!userAnswer.trim() || !currentProblem) return;

    const isCorrect = userAnswer === currentProblem.answer;

    setStats(prev => ({
      correct: prev.correct + (isCorrect ? 1 : 0),
      incorrect: prev.incorrect + (isCorrect ? 0 : 1),
      total: prev.total + 1
    }));

    setFeedback({
      type: isCorrect ? 'correct' : 'incorrect',
      message: isCorrect
        ? '정답입니다!'
        : `오답입니다. 정답은 '${currentProblem.answer}' 입니다.`
    });

    setTimeout(() => {
      getRandomProblem();
      setTimeout(() => {
        inputRef.current?.focus();
      }, 0);
    }, 2000);
  };

  const handleReset = (): void => {
    setStats({ correct: 0, incorrect: 0, total: 0 });
    getRandomProblem();
  };

  const accuracy: number = stats.total > 0
    ? Math.round((stats.correct / stats.total) * 100)
    : 0;

  return (
    <div className="container">
      <h1>Vim 명령어 연습</h1>

      <div className="stats">
        <div className="stat-item">
          <div className="stat-label">정답</div>
          <div className="stat-value">{stats.correct}</div>
        </div>
        <div className="stat-item">
          <div className="stat-label">오답</div>
          <div className="stat-value incorrect-color">{stats.incorrect}</div>
        </div>
        <div className="stat-item">
          <div className="stat-label">정확도</div>
          <div className="stat-value accuracy-color">{accuracy}%</div>
        </div>
      </div>

      <div className="progress-bar">
        <div className="progress-fill" style={{ width: `${accuracy}%` }}></div>
      </div>

      {feedback && (
        <div className={`feedback ${feedback.type}`}>
          {feedback.message}
        </div>
      )}

      {currentProblem && (
        <div className="question-card">
          <div className="question">{currentProblem.question}</div>

          <form onSubmit={handleSubmit}>
            <div className="input-container">
              <input
                ref={inputRef}
                type="text"
                value={userAnswer}
                onChange={(e) => setUserAnswer(e.target.value)}
                placeholder="답을 입력하세요"
                autoFocus
                disabled={feedback !== null}
              />
              <button
                type="submit"
                className="submit-btn"
                disabled={feedback !== null}
              >
                확인
              </button>
            </div>
          </form>

          <button
            className="skip-btn"
            onClick={getRandomProblem}
            disabled={feedback !== null}
          >
            다음 문제
          </button>
        </div>
      )}

      <button className="reset-btn" onClick={handleReset}>
        통계 초기화
      </button>
    </div>
  );
}

export default App;
