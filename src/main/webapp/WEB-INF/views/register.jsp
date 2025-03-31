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

                    <div class="space-y-1">
                        <label for="username" class="block font-bold">Username</label>
                        <input type="text" name="username" id="username" required
                               class="w-full rounded-md border border-gray-500 text-gray-700 shadow p-1.5">
                    </div>

                    <div class="space-y-1">
                        <label for="email" class="block font-bold">Email</label>
                        <input type="email" name="email" id="email" required
                               class="w-full rounded-md border border-gray-500 text-gray-700 shadow p-1.5">
                    </div>

                    <div class="space-y-1">
                        <label for="password" class="block font-bold">Password</label>
                        <div class="flex items-center">
                            <input type="password" name="password" id="password" required
                                   class="w-full rounded-md border border-gray-500 text-gray-700 shadow p-1.5">
                            <button type="button" class="-ml-6 show-password">O</button>
                        </div>

                        <div class="rounded-full bg-gray-300">
                            <div class="h-2 strength-bar rounded-full"></div>
                        </div>
                        <div class="strength-text">Password strength: <span class="strength-label">-</span></div>
                    </div>

                    <div class="space-y-1">
                        <label for="confirm-password" class="block font-bold">Re-enter password</label>
                        <div class="flex items-center">
                            <input type="password" id="confirm-password" required
                                   class="w-full rounded-md border border-gray-500 text-gray-700 shadow p-1.5">
                            <button type="button" class="-ml-6 show-password"></button>
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
            ;(function () {
                // all package will be available under zxcvbnts
                const options = {
                    translations: zxcvbnts['language-en'].translations,
                    graphs: zxcvbnts['language-common'].adjacencyGraphs,
                    dictionary: {
                        ...zxcvbnts['language-common'].dictionary,
                        ...zxcvbnts['language-en'].dictionary,
                    },
                }
                zxcvbnts.core.zxcvbnOptions.setOptions(options)
                console.log(zxcvbnts.core.zxcvbn('somePassword'))
            })();
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

            $('form input#password').on('input', function () {
                let $this = $(this);

                let password = $this.val();
                let score = zxcvbnts.core.zxcvbn(password).score;  // 0 - 4

                let $strength_bar = $('.strength-bar');
                let $strength_text = $('.strength-text');
                let $strength_label = $('.strength-label');

                let strength;
                let width;
                let color;
                if (score === 4) {
                    strength = "Very strong";
                    width = "100%";
                    color = "#25ce00";
                } else if (score === 3) {
                    strength = "Strong";
                    width = "75%";
                    color = "#4caf50";
                } else if (score === 2) {
                    strength = "Medium";
                    width = "50%";
                    color = "orange";
                } else if (score === 1) {
                    strength = "Weak";
                    width = "25%";
                    color = "red";
                } else {
                    strength = "Very weak";
                    width = "1%";
                    color = "darkred";
                }
                $strength_bar.css("width", width);
                $strength_bar.css("background-color", color);
                $strength_label.text(strength);
                $strength_text.css("color", color);
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
