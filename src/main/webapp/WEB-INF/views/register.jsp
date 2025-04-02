<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="login" tagdir="/WEB-INF/tags/login" %>

<login:base pageTitle="Register">
    <jsp:attribute name="includeHead">
        <script src="https://cdn.jsdelivr.net/npm/@zxcvbn-ts/core@2.0.0/dist/zxcvbn-ts.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@zxcvbn-ts/language-common@2.0.0/dist/zxcvbn-ts.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@zxcvbn-ts/language-en@2.0.0/dist/zxcvbn-ts.js"></script>
    </jsp:attribute>

    <jsp:body>
        <div class="flex items-center justify-center">
            <div class="my-4 flex flex-col items-stretch justify-center gap-5">
                <form action="${pageContext.request.contextPath}/api/account/register" method="post"
                      class="rounded-xl border border-gray-300 px-7 py-6 shadow min-w-90 space-y-4">
                    <h2 class="text-3xl font-bold">Register</h2>

                    <div class="form-field space-y-1">
                        <label for="username" class="block font-bold">Username</label>
                        <input type="text" name="username" id="username" required
                               class="w-full rounded-md border border-gray-500 text-gray-700 shadow p-1.5">
                    </div>

                    <div class="form-field space-y-1">
                        <label for="email" class="block font-bold">Email</label>
                        <input type="email" name="email" id="email" required
                               class="w-full rounded-md border border-gray-500 text-gray-700 shadow p-1.5">
                    </div>

                    <div class="form-field space-y-1">
                        <label for="password" class="block font-bold">Password</label>
                        <div class="space-y-1">
                            <div class="flex items-center">
                                <input type="password" name="password" id="password" required
                                       class="w-full rounded-md border border-gray-500 text-gray-700 shadow p-1.5">
                                <div class="-ml-7 show-password group">
                                    <i class="fa-solid fa-eye-slash group-data-visible:hidden!"></i>
                                    <i class="fa-solid fa-eye group-not-data-visible:hidden!"></i>
                                </div>
                            </div>

                            <div class="strength-bar rounded-full flex gap-0.5">
                                <div class="bg-gray-300 h-1.5 flex-auto data-passed:bg-blue-300"></div>
                                <div class="bg-gray-300 h-1.5 flex-auto data-passed:bg-blue-300"></div>
                                <div class="bg-gray-300 h-1.5 flex-auto data-passed:bg-blue-300"></div>
                                <div class="bg-gray-300 h-1.5 flex-auto data-passed:bg-blue-300"></div>
                            </div>
                        </div>

                        <div class="form-field space-y-1">
                            <h3 class="font-bold">Your password must contain: </h3>
                            <ul>
                                <li class="group flex items-center gap-2 data-passed:text-blue-300"
                                    data-strength-rule="lowercase">
                                    <i class="fa-solid fa-circle-xmark group-data-passed:hidden!"></i>
                                    <i class="fa-solid fa-circle-check group-not-data-passed:hidden!"></i>
                                    at least 1 lowercase
                                </li>
                                <li class="group flex items-center gap-2 data-passed:text-blue-300"
                                    data-strength-rule="uppercase">
                                    <i class="fa-solid fa-circle-xmark group-data-passed:hidden!"></i>
                                    <i class="fa-solid fa-circle-check group-not-data-passed:hidden!"></i>
                                    at least 1 uppercase
                                </li>
                                <li class="group flex items-center gap-2 data-passed:text-blue-300"
                                    data-strength-rule="min-length">
                                    <i class="fa-solid fa-circle-xmark group-data-passed:hidden!"></i>
                                    <i class="fa-solid fa-circle-check group-not-data-passed:hidden!"></i>
                                    minimum 8 characters
                                </li>
                            </ul>
                        </div>
                    </div>

                    <div class="space-y-1">
                        <label for="confirm-password" class="block font-bold">Re-enter password</label>
                        <div class="flex items-center">
                            <input type="password" id="confirm-password" required
                                   class="w-full rounded-md border border-gray-500 text-gray-700 shadow p-1.5">
                            <div class="-ml-7 show-password group">
                                <i class="fa-solid fa-eye-slash group-data-visible:hidden!"></i>
                                <i class="fa-solid fa-eye group-not-data-visible:hidden!"></i>
                            </div>
                        </div>
                    </div>

                    <div class="flex items-center justify-between">
                        <button type="submit"
                                class="rounded-full bg-blue-500 px-5 py-2 font-bold text-white hover:bg-blue-700">
                            Register
                        </button>
                    </div>
                </form>

                <div>
                    Or already have an account?
                    <a href="${pageContext.request.contextPath}/login">
                        Login here
                    </a>
                </div>
            </div>
        </div>

        <script>
            const options = {
                translations: zxcvbnts['language-en'].translations,
                graphs: zxcvbnts['language-common'].adjacencyGraphs,
                dictionary: {
                    ...zxcvbnts['language-common'].dictionary,
                    ...zxcvbnts['language-en'].dictionary,
                },
            };
            zxcvbnts.core.zxcvbnOptions.setOptions(options);
        </script>

        <script>
            $email = $('form input#email');
            $password = $('form input#password');
            $confirmPassword = $('form input#confirm-password');

            // this = password rule item
            function validateRule(password) {
                switch (this.getAttribute('data-strength-rule')) {
                    case 'lowercase':
                        return /[a-z]/.test(password);
                    case 'uppercase':
                        return /[A-Z]/.test(password);
                    case 'min-length':
                        return password.length >= 8;
                }
            }

            // this = password rule item
            function getRuleReason() {
                switch (this.getAttribute('data-strength-rule')) {
                    case 'lowercase':
                        return 'Password must contain at least 1 lowercase.'
                    case 'uppercase':
                        return 'Password must contain at least 1 uppercase.';
                    case 'min-length':
                        return 'Password must be at least 8 characters long.';
                }
            }

            // this = input
            function validateField() {
                switch (this.id) {
                    case 'username':
                        break;
                    case 'email':
                        break;
                    case 'password':
                        let password = this.value;
                        let score = zxcvbnts.core.zxcvbn(password).score;  // 0 - 4

                        let formField = this.closest('.form-field');
                        let strengthBar = formField.querySelector('.strength-bar');

                        updateStrengthBar.call(strengthBar, score);
                        updatePasswordRule.call(this);

                        $confirmPassword[0].setCustomValidity('');
                        if (this.value !== $confirmPassword.val())
                            $confirmPassword[0].setCustomValidity('Passwords does not match.');
                        break;
                    case 'confirm-password':
                        this.setCustomValidity('');
                        if (this.value !== $password.val())
                            this.setCustomValidity('Passwords does not match.');
                        break;
                }
                return this.validity.valid;
            }

            // this = form
            function validateForm() {
                return Array.from(this.querySelectorAll('input'))
                    .map(input => {
                        validateField.call(input);
                        return input.reportValidity();
                    }).every(Boolean);
            }

            // this = strength bar
            function updateStrengthBar(score) {
                for (let [i, bar] of Array.from(this.children).entries())
                    if (i < score)
                        bar.setAttribute('data-passed', '');
                    else
                        bar.removeAttribute('data-passed');
            }

            // this = password input
            function updatePasswordRule() {
                let input = this;
                let rules = this.closest('.form-field').querySelectorAll('[data-strength-rule]');
                rules.forEach(function (rule) {
                    if (validateRule.call(rule, input.value)) {
                        rule.setAttribute('data-passed', '');
                        input.setCustomValidity('');
                    } else {
                        rule.removeAttribute('data-passed');
                        input.setCustomValidity(getRuleReason.call(rule));
                    }
                });
            }

            $password.on('input', validateField);
            $confirmPassword.on('input', validateField);

            $('form .show-password').mousedown(function () {
                $(this).prev().prop('type', 'text');
                this.setAttribute('data-visible', '');
            }).mouseup(function () {
                $(this).prev().prop('type', 'password');
                this.removeAttribute('data-visible');
            }).mouseleave(function () {
                $(this).prev().prop('type', 'password');
                this.removeAttribute('data-visible');
            });

            $('form').ajaxForm({
                beforeSubmit: (_formData, $form, _options) => {
                    return validateForm.call($form[0]);
                },
                success: (_response, _statusText, _jqXHR, _$form) => {
                    window.location.replace('${pageContext.request.contextPath}/login');
                },
                error: (jqXHR, _statusText, _errorText, _$form) => {
                    if (jqXHR.status === 409) {
                        $email[0].setCustomValidity('Email is already taken.');
                        $email[0].reportValidity();
                    }
                }
            });
        </script>
    </jsp:body>
</login:base>
