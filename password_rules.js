


function validatePassword(password, userId = '') {
    const errors = [];

    // 조건 1: 길이
    if (password.length < 12) {
        errors.push("비밀번호는 최소 12자 이상이어야 합니다.");
    }

    // 조건 2: 문자 조합 (3가지 이상)
    const hasUpperCase = /[A-Z]/.test(password);
    const hasLowerCase = /[a-z]/.test(password);
    const hasNumber = /[0-9]/.test(password);
    const hasSpecialChar = /[^A-Za-z0-9]/.test(password);

    const countTypes = [hasUpperCase, hasLowerCase, hasNumber, hasSpecialChar].filter(Boolean).length;
    if (countTypes < 3) {
        errors.push("대문자, 소문자, 숫자, 특수문자 중 최소 3종류를 포함해야 합니다.");
    }

    // 조건 3: 연속 문자/숫자 제한
    if (/(\w)\1\1/.test(password)) {
        errors.push("같은 문자가 3번 이상 반복될 수 없습니다.");
    }
    if (/(012|123|234|345|456|567|678|789)/.test(password)) {
        errors.push("연속된 숫자 패턴을 사용할 수 없습니다.");
    }

    // 조건 4: 공통 비밀번호 블랙리스트
    const commonPasswords = ['123456', 'password', 'qwerty', 'abc123', 'admin'];
    if (commonPasswords.includes(password.toLowerCase())) {
        errors.push("너무 흔한 비밀번호는 사용할 수 없습니다.");
    }

    // 조건 5: 사용자 ID 포함 여부
    if (userId && password.toLowerCase().includes(userId.toLowerCase())) {
        errors.push("비밀번호에 사용자 ID를 포함할 수 없습니다.");
    }

    return {
        valid: errors.length === 0,
        errors
    };
}

// 예제
const result = validatePassword('MySecure!2024', 'user123');
if (!result.valid) {
    console.log("❌ 비밀번호 유효성 검사 실패:", result.errors);
} else {
    console.log("✅ 비밀번호가 유효합니다.");
}
