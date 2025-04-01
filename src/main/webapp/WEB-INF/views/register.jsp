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
                                <button type="button" class="-ml-6 show-password">O</button>
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
                                <li class="group flex items-center gap-2 data-passed:text-blue-300" data-strength-rule="lowercase">
                                    <i class="fa-solid fa-circle-xmark group-data-passed:hidden!"></i>
                                    <i class="fa-solid fa-circle-check group-not-data-passed:hidden!"></i>
                                    at least 1 lowercase
                                </li>
                                <li class="group flex items-center gap-2 data-passed:text-blue-300" data-strength-rule="uppercase">
                                    <i class="fa-solid fa-circle-xmark group-data-passed:hidden!"></i>
                                    <i class="fa-solid fa-circle-check group-not-data-passed:hidden!"></i>
                                    at least 1 uppercase
                                </li>
                                <li class="group flex items-center gap-2 data-passed:text-blue-300" data-strength-rule="min-length">
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
                            <button type="button" class="-ml-6 show-password">O</button>
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
            $('form').ajaxForm({
                beforeSubmit: (formData, $form, options) => {
                    return $form.valid();
                },
                success: (response, statusText, jqXHR, $form) => {
                    window.location.replace('${pageContext.request.contextPath}/login');
                },
                error: (jqXHR, statusText, errorText, $form) => {
                }
            })
            // .validate();

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

            $('form input#password').on('input', function () {
                let $this = $(this);

                let password = $this.val();
                let score = zxcvbnts.core.zxcvbn(password).score;  // 0 - 4

                let $formField = $this.closest('.form-field');

                let $strengthBar = $formField.find('.strength-bar');
                $strengthBar.children().each(function (i, _) {
                    if (i < score)
                        this.setAttribute('data-passed', '');
                    else
                        this.removeAttribute('data-passed');
                });

                let $rules = $formField.find('[data-strength-rule]')
                $rules.each(function () {
                    if (validateRule.call(this, password))
                        this.setAttribute('data-passed', '');
                    else
                        this.removeAttribute('data-passed');
                });
            });

            $('form button.show-password').mousedown(function () {
                $(this).prev().prop("type", "text");
            }).mouseup(function () {
                $(this).prev().prop("type", "password");
            }).mouseout(function () {
                $(this).prev().prop("type", "password");
            });
        </script>
    </jsp:body>
</login:base>
