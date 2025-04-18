<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="webstore" tagdir="/WEB-INF/tags/webstore" %>
<jsp:useBean id="account" type="com.lavacorp.beautefly.webstore.account.dto.UserAccountDetailsDTO" scope="request"/>

<webstore:base pageTitle="Home">
    <jsp:attribute name="includeHead">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.6.2/cropper.min.css" rel="stylesheet"/>
    </jsp:attribute>

    <jsp:body>
        <main class="flex flex-col items-center justify-center p-5">
            <div class="min-w-4xl space-y-4 py-4 px-6 rounded-xl bg-gray-50">
                <div>
                    <h2 class="font-bold text-xl">My Account</h2>
                    <p>Manage your account</p>
                </div>

                <hr class="text-gray-500">

                <div class="flex py-2">
                    <form id="update-image" action="${pageContext.request.contextPath}/api/file/upload" method="post"
                          enctype="multipart/form-data"
                          class="w-[30%] flex flex-col items-center gap-4">
                        <div class="w-20 h-20 rounded-full overflow-hidden border-2 border-gray-300">
                            <img src="${account.profileImage().href()}"
                                 alt=""
                                 class="w-full h-full object-cover">
                        </div>
                        <label for="file" class="border border-gray-300 py-1 px-4 rounded text-gray-700 cursor-pointer">Upload Image</label>
                        <input type="file" name="file" id="file" accept="image/*" class="hidden">
                    </form>
                    <form id="update-details" action="${pageContext.request.contextPath}/account" method="post"
                          class="w-[70%] space-y-4">
                        <input type="hidden" name="profileImageFileId" value="${account.profileImage().id()}">

                        <fieldset class="peer space-y-4 *:space-y-1 inert:opacity-90" inert>
                            <div>
                                <label for="username" class="font-medium text-gray-700 block">Username</label>
                                <input type="text" name="username" id="username" value="${account.username()}"
                                       class="w-full p-2 px-3 inert:bg-gray-100 rounded-md border border-gray-300">
                            </div>
                            <div>
                                <label for="email" class="font-medium text-gray-700 block">Email</label>
                                <input type="email" name="email" id="email" value="${account.email()}"
                                       class="w-full p-2 px-3 inert:bg-gray-100 rounded-md border border-gray-300">
                            </div>
                            <div>
                                <label class="font-medium text-gray-700 block">Gender</label>

                                <div class="flex gap-4">
                                    <label>
                                        <input type="radio" name="gender" value="MALE"
                                               class="text-blue-600"
                                            ${account.gender() == "MALE" ? "checked" : ""}>
                                        Male
                                    </label>
                                    <label>
                                        <input type="radio" name="gender" value="FEMALE"
                                               class="text-pink-600"
                                            ${account.gender() == "FEMALE" ? "checked" : ""}>
                                        Female
                                    </label>
                                    <label>
                                        <input type="radio" name="gender" value="PREFER_NOT_TO_SAY"
                                               class="text-gray-400"
                                            ${account.gender() == "PREFER_NOT_TO_SAY" ? "checked" : ""}>
                                        Prefer not to say
                                    </label>
                                </div>
                            </div>
                            <div>
                                <label for="dob" class="font-medium text-gray-700 block">Date of Birth</label>
                                <input type="date" name="dob" id="dob" value="${account.dob()}"
                                       class="w-full p-2 px-3 inert:bg-gray-100 rounded-md border border-gray-300">
                            </div>
                        </fieldset>

                        <div class="not-peer-inert:hidden">
                            <button type="button" onclick="toggleFormInert.call(this)"
                                    class="px-5 py-2 bg-blue-400 text-white rounded-md hover:bg-blue-600 transition">
                                Edit
                            </button>
                        </div>
                        <div class="peer-inert:hidden">
                            <button type="reset" onclick="toggleFormInert.call(this)"
                                    class="px-5 py-2 bg-red-500 text-white rounded-md hover:bg-red-600 transition">
                                Cancel
                            </button>
                            <button type="submit" onclick="toggleFormInert.call(this)"
                                    class="px-5 py-2 bg-green-600 text-white rounded-md hover:bg-green-700 transition">
                                Save
                            </button>
                        </div>
                    </form>
                </div>

            </div>
        </main>

        <dialog id="crop-preview" class="rounded-xl p-4 backdrop:brightness-50">
            <form method="dialog">
                <img src="" alt="" class="max-w-full max-h-72 mb-4">

                <button type="reset">Cancel</button>
                <button type="submit"
                        class="bg-green-600 text-white px-4 py-2 rounded-md hover:bg-green-700">
                    Confirm
                </button>
            </form>
        </dialog>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.6.2/cropper.min.js"></script>
        <script>
            function toggleFormInert() {
                const form = this.closest("form");
                const fieldset = form.querySelector("fieldset");

                if (fieldset.getAttribute("inert") == null)
                    fieldset.setAttribute("inert", "");
                else
                    fieldset.removeAttribute("inert");
            }
        </script>
        <script>
            const updateImageForm = document.querySelector("form#update-image");
            const displayImage = updateImageForm.querySelector("img");
            const imageInput = updateImageForm.querySelector("input[name='file']");

            const imageIdInput = document.querySelector("input[name='profileImageFileId']")

            const cropModal = document.querySelector("dialog#crop-preview");
            const cropForm = cropModal.querySelector("form");
            const cropPreview = cropModal.querySelector("img");

            let cropper;

            async function uploadImage() {
                const formData = new FormData(this);

                const response = await fetch(this.action, {
                    method: this.method,
                    body: formData
                });

                if (!response.ok) {
                    console.error(response);
                    return;
                }

                return response.json();
            }

            imageInput.addEventListener("change", function (e) {
                const file = e.target.files[0]

                if (!file || !file.type.startsWith("image/"))
                    return;

                const reader = new FileReader();
                reader.onload = function (e) {
                    cropPreview.src = e.target.result;
                    cropModal.showModal();

                    if (cropper) cropper.destroy();
                    cropper = new Cropper(cropPreview, {
                        aspectRatio: 1,
                        viewMode: 1
                    })
                };

                reader.readAsDataURL(file);
            });

            cropForm.addEventListener("submit", function (e) {
                const canvas = cropper.getCroppedCanvas({
                    width: 160,
                    height: 160
                });
                imageInput.setAttribute("href", canvas.toDataURL());

                uploadImage.call(updateImageForm).then((data) => {
                    if (data == null) return;

                    displayImage.src = data.href;
                    imageIdInput.value = data.id;
                })
            });
        </script>
    </jsp:body>
</webstore:base>