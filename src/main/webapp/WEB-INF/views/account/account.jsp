<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="webstore" tagdir="/WEB-INF/tags/webstore" %>
<%@ taglib prefix="account" tagdir="/WEB-INF/tags/account" %>

<jsp:useBean id="account" type="com.lavacorp.beautefly.webstore.account.dto.UserAccountDetailsDTO" scope="request"/>

<c:set var="pageTitle" value="Account Details"/>

<webstore:base pageTitle="${pageTitle}">
    <main class="flex min-h-screen bg-white text-black">
        <account:sidebar pageTitle="${pageTitle}"/>

        <div class="p-5 flex-1">
            <!-- Account Details -->
            <h1 class="text-2xl font-semibold mb-4">Account Details</h1>
            <div class="bg-white border border-gray-300 p-6 rounded-lg shadow-sm space-y-6">

                <!--images-->
                <form id="update-image" action="<c:url value='/api/file/upload' />" method="post"
                      enctype="multipart/form-data" class="flex items-center gap-6">
                    <div class="w-20 h-20 rounded-full overflow-hidden border-2 border-gray-300">
                        <img src="${account.profileImage().url()}" alt="" class="w-full h-full object-cover">
                    </div>
                    <div class="peer-inert:hidden">
                        <label id="uploadImageBtn" for="file"
                               class="bg-gray-200 px-4 py-2 rounded cursor-pointer hidden">Upload Image</label>
                        <input type="file" name="file" id="file" accept="image/*" class="hidden">
                    </div>
                </form>


                <form id="update-details" action="<c:url value='/account' />" method="post"
                      class="space-y-4">
                    <input type="hidden" name="profileImageFileId" value="${account.profileImage().id()}">

                    <fieldset class="peer space-y-4 *:space-y-1 inert:opacity-90" inert>
                        <div>
                            <label for="username" class="block font-medium">Username</label>
                            <input type="text" name="username" id="username" value="${account.username()}"
                                   class="w-full border border-gray-300 p-2 rounded">
                        </div>
                        <div>
                            <label for="email" class="block font-medium">Email</label>
                            <input type="email" name="email" id="email" value="${account.email()}"
                                   class="w-full border border-gray-300 p-2 rounded">
                        </div>
                        <div>
                            <label class="block font-medium">Gender</label>
                            <div class="not-inert:hidden">
                                <p class="w-full border border-gray-300 p-2 rounded">
                                        ${account.gender().pretty()}
                                </p>
                            </div>
                            <div class="inert:hidden ml-2 my-3 flex gap-4">
                                <label>
                                    <input type="radio" name="gender"
                                           value="MALE" ${account.gender() == "MALE" ? "checked" : ""}>
                                    Male
                                </label>
                                <label>
                                    <input type="radio" name="gender"
                                           value="FEMALE" ${account.gender() == "FEMALE" ? "checked" : ""}>
                                    Female
                                </label>
                                <label>
                                    <input type="radio" name="gender"
                                           value="PREFER_NOT_TO_SAY" ${account.gender() == "PREFER_NOT_TO_SAY" ? "checked" : ""}>
                                    Prefer not to say
                                </label>
                            </div>
                        </div>
                        <div>
                            <label for="dob" class="block font-medium">Date of Birth</label>
                            <input type="date" name="dob" id="dob" value="${account.dob()}"
                                   class="w-full border border-gray-300 p-2 rounded">
                        </div>
                    </fieldset>

                    <div class="not-peer-inert:hidden">
                        <button type="button" onclick="toggleFormInert.call(this)"
                                class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">Edit
                        </button>
                    </div>
                    <div class="peer-inert:hidden space-x-2">
                        <button type="reset" onclick="toggleFormInert.call(this)"
                                class="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600">Cancel
                        </button>
                        <button type="submit" onclick="toggleFormInert.call(this)"
                                class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700">Save
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </main>

    <!-- Crop dialog -->
    <dialog id="crop-preview" class="rounded-xl p-4 backdrop:brightness-50">
        <form method="dialog">
            <img src="" alt="" class="max-w-full max-h-72 mb-4">
            <button type="reset">Cancel</button>
            <button type="submit" class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700">Confirm</button>
        </form>
    </dialog>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.6.2/cropper.min.js"></script>
    <script>
        // sidebar
        function toggleFormInert() {
            const form = this.closest("form");
            const fieldset = form.querySelector("fieldset");
            const uploadBtn = document.getElementById("uploadImageBtn");

            if (fieldset.hasAttribute("inert"))
                fieldset.removeAttribute("inert");
            else
                fieldset.setAttribute("inert", "");
        }

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
                    cropper = new Cropper(cropPreview, {aspectRatio: 1, viewMode: 1});
                    cropModal.showModal();
                };
                cropPreview.src = e.target.result;
            };

            reader.readAsDataURL(file);
        });

        cropForm.addEventListener("submit", function (e) {
            e.preventDefault();

            const canvas = cropper.getCroppedCanvas({width: 160, height: 160});

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
                        }
                    })
                    .catch(err => {
                        console.error("上传出错：", err);
                    });

            }, "image/jpeg");
        });
    </script>
</webstore:base>
