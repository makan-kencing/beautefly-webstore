<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="webstore" tagdir="/WEB-INF/tags/webstore" %>
<jsp:useBean id="account" type="com.lavacorp.beautefly.webstore.account.dto.UserAccountDetailsDTO" scope="request"/>

<webstore:base pageTitle="Settings">
    <jsp:body>
        <main class="flex min-h-screen bg-white text-black">
            <!-- Sidebar -->
            <div class="w-64 bg-gray-100 border-r border-gray-300 overflow-y-auto p-5">
                <h2 class="text-xl font-semibold mb-6">Account</h2>
                <div class="space-y-2">
                    <div class="menu-item active flex items-center gap-3 px-5 py-3 rounded cursor-pointer bg-blue-300 hover:bg-blue-100" data-page="account">
                        <i data-lucide="user" class="w-5 h-5"></i> <span>Account Details</span>
                    </div>
                    <div class="menu-item flex items-center gap-3 px-5 py-3 rounded cursor-pointer hover:bg-blue-100" data-page="address">
                        <i data-lucide="map-pin" class="w-5 h-5"></i> <span>Addresses</span>
                    </div>
                    <div class="menu-item flex items-center gap-3 px-5 py-3 rounded cursor-pointer hover:bg-blue-100" data-page="password">
                        <i data-lucide="key" class="w-5 h-5"></i> <span>Password</span>
                    </div>
                    <div class="menu-item flex items-center gap-3 px-5 py-3 rounded cursor-pointer hover:bg-blue-100" data-page="orders">
                        <i data-lucide="shopping-bag" class="w-5 h-5"></i> <span>My Orders</span>
                    </div>
                </div>
            </div>

            <!-- Content -->
            <div class="flex-1 p-10">
                <div id="account" class="page">
                    <!-- Account Details -->
                    <h1 class="text-2xl font-semibold mb-4">Account Details</h1>
                    <div class="bg-white border border-gray-300 p-6 rounded-lg shadow-sm space-y-6">

                        <!--images-->
                        <form id="update-image" action="${pageContext.request.contextPath}/api/file/upload" method="post" enctype="multipart/form-data" class="flex items-center gap-6">
                            <div class="w-20 h-20 rounded-full overflow-hidden border-2 border-gray-300">
                                <img src="${account.profileImage().href()}" alt="" class="w-full h-full object-cover">
                            </div>
                            <div class="peer-inert:hidden">
                                <label id="uploadImageBtn" for="file" class="bg-gray-200 px-4 py-2 rounded cursor-pointer hidden">Upload Image</label>
                                <input type="file" name="file" id="file" accept="image/*" class="hidden">
                            </div>
                        </form>



                        <form id="update-details" action="${pageContext.request.contextPath}/account" method="post" class="space-y-4">
                            <input type="hidden" name="profileImageFileId" value="${account.profileImage().id()}">

                            <fieldset class="peer space-y-4 *:space-y-1 inert:opacity-90" inert>
                                <!--username-->
                                <div>
                                    <label for="username" class="block font-medium">Username</label>
                                    <input type="text" name="username" id="username" value="${account.username()}" class="w-full border border-gray-300 p-2 rounded">
                                </div>
                                <!--email-->
                                <div>
                                    <label for="email" class="block font-medium">Email</label>
                                    <input type="email" name="email" id="email" value="${account.email()}" class="w-full border border-gray-300 p-2 rounded">
                                </div>
                                <!--gender-->
                                <div>
                                    <label class="block font-medium">Gender</label>
                                    <div class="edit-mode hidden flex gap-4">
                                        <label><input type="radio" name="gender" value="MALE" ${account.gender() == "MALE" ? "checked" : ""}> Male</label>
                                        <label><input type="radio" name="gender" value="FEMALE" ${account.gender() == "FEMALE" ? "checked" : ""}> Female</label>
                                        <label><input type="radio" name="gender" value="PREFER_NOT_TO_SAY" ${account.gender() == "PREFER_NOT_TO_SAY" ? "checked" : ""}> Prefer not to say</label>
                                    </div>
                                    <div class="view-mode">
                                        <p class="w-full border border-gray-300 p-2 rounded">
                                            <c:choose>
                                                <c:when test="${account.gender() == 'MALE'}">Male</c:when>
                                                <c:when test="${account.gender() == 'FEMALE'}">Female</c:when>
                                                <c:otherwise>Prefer not to say</c:otherwise>
                                            </c:choose>
                                        </p>
                                    </div>
                                </div>
                                <!--birthday-->
                                <div>
                                    <label for="dob" class="block font-medium">Date of Birth</label>
                                    <input type="date" name="dob" id="dob" value="${account.dob()}" class="edit-mode hidden w-full border border-gray-300 p-2 rounded">
                                    <p class="view-mode w-full border border-gray-300 p-2 rounded">${account.dob()}</p>
                                </div>

                            </fieldset>

                            <div class="not-peer-inert:hidden">
                                <button type="button" onclick="toggleFormInert.call(this)" class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">Edit</button>
                            </div>
                            <div class="peer-inert:hidden space-x-2">
                                <button type="reset" onclick="toggleFormInert.call(this)" class="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600">Cancel</button>
                                <button type="submit" onclick="toggleFormInert.call(this)" class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700">Save</button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Addresses -->
                <div id="address" class="page hidden">
                    <h1 class="text-2xl font-semibold mb-4">Addresses</h1>
                    <div class="bg-white border border-gray-300 p-6 rounded-lg shadow-sm space-y-6">
                        <form id="addresses" action="${pageContext.request.contextPath}/account" method="post" class="space-y-4">
                            <input type="hidden" name="profileImageFileId" value="${account.profileImage().id()}">

                            <fieldset class="peer space-y-4 *:space-y-1 inert:opacity-90" inert>
                                <div>
                                    <label for="username" class="block font-medium">Address</label>
                                    <input type="text" name="address" id="addressDetails" value="address" class="w-full border border-gray-300 p-2 rounded">
                                </div>

                            </fieldset>

                            <div class="not-peer-inert:hidden">
                                <button type="button" onclick="toggleFormInert.call(this)" class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">Edit</button>
                            </div>
                            <div class="peer-inert:hidden space-x-2">
                                <button type="reset" onclick="toggleFormInert.call(this)" class="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600">Cancel</button>
                                <button type="submit" onclick="toggleFormInert.call(this)" class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700">Save</button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Password -->
                <div id="password" class="page hidden">
                    <h1 class="text-2xl font-semibold mb-4">Password</h1>
                    <div class="bg-white border border-gray-300 p-6 rounded-lg shadow-sm space-y-6">
                    <form onsubmit="return handleSubmit()" class="text-left">
                        <label for="oldPassword" class="block font-medium mb-1 mt-4">Old Password</label>
                        <div class="relative">
                            <input type="password" id="oldPassword" oninput="checkOldPassword()" class="w-full px-4 py-2 pr-10 border border-gray-300 rounded-md">
                            <span class="absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-500 cursor-pointer" onclick="togglePassword('oldPassword')">👁️</span>
                        </div>
                        <div id="errorMsg" class="text-sm mt-1 hidden"></div>

                        <label for="newPassword" class="block font-medium mb-1 mt-4">New Password</label>
                        <div class="relative">
                            <input type="password" id="newPassword" oninput="checkPasswordMatch()" disabled class="w-full px-4 py-2 pr-10 border border-gray-300 rounded-md">
                            <span class="absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-500 cursor-pointer" onclick="togglePassword('newPassword')">👁️</span>
                        </div>

                        <label for="confirmPassword" class="block font-medium mb-1 mt-4">Confirm Password</label>
                        <div class="relative">
                            <input type="password" id="confirmPassword" oninput="checkPasswordMatch()" disabled class="w-full px-4 py-2 pr-10 border border-gray-300 rounded-md">
                            <span class="absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-500 cursor-pointer" onclick="togglePassword('confirmPassword')">👁️</span>
                        </div>
                        <div id="matchMsg" class="text-sm mt-1 hidden"></div>

                        <input type="hidden" id="croppedImageData">

                        <button type="submit" class="mt-6 px-4 py-2 text-white bg-blue-600 hover:bg-blue-700 rounded-md w-full">Submit</button>
                        <div id="submitResult" class="mt-4 font-semibold"></div>
                    </form>
                    </div>

                </div>

                <!-- My Orders -->
                <div id="orders" class="page hidden">
                    <h1 class="text-2xl font-semibold mb-4">My Orders</h1>
                    <div class="bg-white border border-gray-300 p-6 rounded-lg shadow-sm space-y-6">
                    <p>Check your order history.</p>
                    </div>
                </div>
            </div>
        </main>

        <!-- Crop dialog -->
        <dialog id="crop-preview" class="rounded-xl p-4 backdrop:brightness-50">
            <form method="dialog">
                <img src="" alt="" class="max-w-full max-h-72 mb-4">
                <button type="reset">Cancel</button>
                <button type="button" id="cropConfirmBtn" class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700">Confirm</button>
            </form>
        </dialog>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.6.2/cropper.min.js"></script>
        <script>
            // sidebar
            const menuItems = document.querySelectorAll('.menu-item');
            const pages = document.querySelectorAll('.page');

            menuItems.forEach(item => {
                item.addEventListener('click', () => {
                    menuItems.forEach(i => i.classList.remove('bg-blue-300', 'active'));
                    item.classList.add('bg-blue-300', 'active');

                    const pageId = item.getAttribute('data-page');
                    pages.forEach(p => p.classList.add('hidden'));
                    document.getElementById(pageId).classList.remove('hidden');
                });
            });

            function toggleFormInert() {
                const form = this.closest("form");
                const fieldset = form.querySelector("fieldset");
                const uploadBtn = document.getElementById("uploadImageBtn");
                const isInert = fieldset.hasAttribute("inert");

                const editElems = form.querySelectorAll(".edit-mode");
                const viewElems = form.querySelectorAll(".view-mode");

                if (isInert) {
                    fieldset.removeAttribute("inert");
                    uploadBtn?.classList.remove("hidden");
                    editElems.forEach(e => e.classList.remove("hidden"));
                    viewElems.forEach(e => e.classList.add("hidden"));
                } else {
                    fieldset.setAttribute("inert", "");
                    uploadBtn?.classList.add("hidden");
                    editElems.forEach(e => e.classList.add("hidden"));
                    viewElems.forEach(e => e.classList.remove("hidden"));
                }
            }

            document.querySelectorAll(".edit-mode").forEach(e => e.classList.add("hidden"));
            document.getElementById("uploadImageBtn").classList.add("hidden");


            const updateImageForm = document.querySelector("#update-image");
            const displayImage = updateImageForm.querySelector("img");
            const imageInput = updateImageForm.querySelector("input[name='file']");
            const imageIdInput = document.querySelector("input[name='profileImageFileId']");
            const cropModal = document.querySelector("#crop-preview");
            const cropForm = cropModal.querySelector("form");
            const cropPreview = cropModal.querySelector("img");
            let cropper;

            imageInput.addEventListener("change", function (e) {
                const file = e.target.files[0];
                if (!file || !file.type.startsWith("image/")) return;

                const reader = new FileReader();
                reader.onload = function (e) {
                    cropPreview.onload = function () {
                        if (cropper) cropper.destroy();
                        cropper = new Cropper(cropPreview, { aspectRatio: 1, viewMode: 1 });
                        cropModal.showModal();
                    };
                    cropPreview.src = e.target.result;
                };

                reader.readAsDataURL(file);
            });

            document.getElementById("cropConfirmBtn").addEventListener("click", function () {
                const canvas = cropper.getCroppedCanvas({ width: 160, height: 160 });
                canvas.toBlob(blob => {
                    const formData = new FormData(updateImageForm);
                    formData.set("file", blob, "avatar.jpg");

                    fetch(updateImageForm.action, {
                        method: updateImageForm.method,
                        body: formData
                    })
                        .then(res => res.json())
                        .then(data => {
                            if (data) {
                                displayImage.src = data.href;
                                imageIdInput.value = data.id;
                                cropModal.close(); // 关闭 dialog
                            }
                        })
                        .catch(err => {
                            console.error("上传出错：", err);
                        });

                }, "image/jpeg");
            });



            //password logic
            function checkOldPassword() {
                const input = document.getElementById('oldPassword');
                const error = document.getElementById('errorMsg');
                const newPassword = document.getElementById('newPassword');
                const confirmPassword = document.getElementById('confirmPassword');

                if (input.value === '123456') {
                    error.classList.add('hidden');
                    newPassword.disabled = false;
                    confirmPassword.disabled = false;
                } else {
                    error.textContent = "Old password is incorrect!";
                    error.classList.remove('hidden');
                    newPassword.disabled = true;
                    confirmPassword.disabled = true;
                }
            }
            function checkPasswordMatch() {
                const newPassword = document.getElementById('newPassword');
                const confirmPassword = document.getElementById('confirmPassword');
                const matchMsg = document.getElementById('matchMsg');

                if (newPassword.value && confirmPassword.value) {
                    if (newPassword.value === confirmPassword.value) {
                        matchMsg.textContent = "✅ Passwords match";
                        matchMsg.classList.remove('text-red-500');
                        matchMsg.classList.add('text-green-600');
                    } else {
                        matchMsg.textContent = "❌ Passwords do not match";
                        matchMsg.classList.remove('text-green-600');
                        matchMsg.classList.add('text-red-500');
                    }
                    matchMsg.classList.remove('hidden');
                } else {
                    matchMsg.classList.add('hidden');
                }
            }
            function togglePassword(id) {
                const input = document.getElementById(id);
                input.type = input.type === 'password' ? 'text' : 'password';
            }
            function handleSubmit() {
                const old = document.getElementById('oldPassword');
                const newP = document.getElementById('newPassword');
                const confirm = document.getElementById('confirmPassword');
                const result = document.getElementById('submitResult');

                if (newP.value !== confirm.value) {
                    result.textContent = "❌ Passwords do not match";
                    result.classList.add('text-red-500');
                    return false;
                }

                result.textContent = "✅ Password changed successfully!";
                result.classList.remove('text-red-500');
                result.classList.add('text-green-600');
                return true;
            }
        </script>
    </jsp:body>
</webstore:base>
