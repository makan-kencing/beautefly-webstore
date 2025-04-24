zxcvbnts = window.zxcvbnts

const options = {
    translations: zxcvbnts['language-en'].translations,
    graphs: zxcvbnts['language-common'].adjacencyGraphs,
    dictionary: {
        ...zxcvbnts['language-common'].dictionary,
        ...zxcvbnts['language-en'].dictionary,
    },
};
zxcvbnts.core.zxcvbnOptions.setOptions(options);

// call this with the data-strength li
function checkRule(password) {
    switch (this.dataset.strengthRule) {
        case 'lowercase':
            return /[a-z]/.test(password);
        case 'uppercase':
            return /[A-Z]/.test(password);
        case 'min-length':
            return password.length >= 8;
    }
}

function getRuleReason() {
    switch (this.dataset.strengthRule) {
        case 'lowercase':
            return 'Password must contain at least 1 lowercase.'
        case 'uppercase':
            return 'Password must contain at least 1 uppercase.';
        case 'min-length':
            return 'Password must be at least 8 characters long.';
    }
}

class PasswordForm {
    constructor(form) {
        this.password = form.querySelector("#password");
        this.confirmPassword = form.querySelector("#confirm-password");
        this.strengthRules = form.querySelectorAll("[data-strength-rule]");

        this.strengthBar = form.querySelector(".strength-bar");

        this.password.addEventListener("input", () => this.onPasswordChange());
        this.confirmPassword.addEventListener("input", () => this.onConfirmPasswordChange());
        form.addEventListener("reset", () => {
            this.password.value = "";
            this.onPasswordChange()
        });
    }

    onPasswordChange() {
        const score = zxcvbnts.core.zxcvbn(this.password.value).score;  // 0 - 4

        this.updatePasswordStrengthBar(score);
        this.updatePasswordRule();

        this.confirmPassword.setCustomValidity('');
        if (this.password.value !== this.confirmPassword.value)
            this.confirmPassword.setCustomValidity('Passwords does not match.');
    }

    onConfirmPasswordChange() {
        this.confirmPassword.setCustomValidity('');
        if (this.confirmPassword.value !== this.password.value)
            this.confirmPassword.setCustomValidity('Passwords does not match.');
    }

    updatePasswordRule() {
        this.strengthRules.forEach((rule) => {
            if (checkRule.call(rule, this.password.value)) {
                rule.setAttribute('data-passed', '');
                this.password.setCustomValidity('');
            } else {
                rule.removeAttribute('data-passed');
                this.password.setCustomValidity(getRuleReason.call(rule));
            }
        });
    }

    updatePasswordStrengthBar(score) {
        for (let [i, bar] of Array.from(this.strengthBar.children).entries())
            if (i < score)
                bar.setAttribute('data-passed', '');
            else
                bar.removeAttribute('data-passed');
    }
}

class ShowPassword {
    constructor(passwordInput, eye) {
        this.passwordInput = passwordInput;
        this.eye = eye;

        this.eye.addEventListener("mousedown", () => this.show());
        this.eye.addEventListener("mouseup", () => this.hide());
        this.eye.addEventListener("mouseleave", () => this.hide());
    }

    show() {
        this.passwordInput.type = "text";
        delete this.eye.dataset.visible;
    }

    hide() {
        this.passwordInput.type = "password";
        this.eye.dataset.visible = "";
    }
}