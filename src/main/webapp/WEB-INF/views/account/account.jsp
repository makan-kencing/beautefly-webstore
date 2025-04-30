<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="webstore" tagdir="/WEB-INF/tags/webstore" %>
<%@ taglib prefix="account" tagdir="/WEB-INF/tags/account" %>

<jsp:useBean id="account" type="com.lavacorp.beautefly.webstore.account.dto.UserAccountDetailsDTO" scope="request"/>

<c:set var="pageTitle" value="Account Details"/>

<webstore:base pageTitle="${pageTitle}">
    <jsp:attribute name="includeHead">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.6.2/cropper.min.css"
              integrity="sha512-UtLOu9C7NuThQhuXXrGwx9Jb/z9zPQJctuAgNUBK3Z6kkSYT9wJ+2+dh6klS+TDBCV9kNPBbAxbVD+vCcfGPaA=="
              crossorigin="anonymous" referrerpolicy="no-referrer"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.6.2/cropper.min.js"></script>
    </jsp:attribute>

    <jsp:body>
        <main class="flex min-h-screen bg-white text-black">
            <account:sidebar pageTitle="${pageTitle}"/>

            <div class="p-5 flex-1">
                <!-- Account Details -->
                <h1 class="text-2xl font-semibold mb-4">Account Details</h1>
                <div class="bg-white border border-gray-300 p-6 rounded-lg shadow-sm space-y-6">

                    <!--images-->
                    <form action="<c:url value='/account/upload' />" method="post" enctype="multipart/form-data"
                          id="image-upload" class="flex items-center gap-6">
                        <div class="w-20 h-20 rounded-full overflow-hidden border-2 border-gray-300">
                            <img src="${account.profileImage().url()}" alt="" class="w-full h-full object-cover">
                        </div>
                        <div>
                            <label for="image" class="button-input text-gray-900">Upload Image</label>
                            <input type="file" name="image" id="image" accept="image/*" class="hidden">
                        </div>
                    </form>


                    <form action="<c:url value='/account' />" method="post" class="space-y-4">
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

                        <script>
                            function toggleFormInert() {
                                const form = this.closest("form");
                                const fieldset = form.querySelector("fieldset");

                                if (fieldset.hasAttribute("inert"))
                                    fieldset.removeAttribute("inert");
                                else
                                    fieldset.setAttribute("inert", "");
                            }
                        </script>
                    </form>
                </div>
            </div>
        </main>

        <!-- Crop dialog -->
        <dialog id="crop-preview" class="rounded-xl p-4 m-auto">
            <form method="dialog">
                <div>
                    <img src="" alt="">
                </div>
                <div class="horizontal justify-end p-4">
                    <button type="reset" class="button-bad">Cancel</button>
                    <button type="submit" class="button-good">Confirm</button>
                </div>
            </form>
        </dialog>

        <script>
            class ImageUpload {
                constructor(imageForm, previewDialog) {
                    this.imageForm = imageForm;
                    this.imageFormImage = imageForm.querySelector("img");
                    this.imageFormInput = imageForm.querySelector("input[type='file']");

                    this.previewDialog = previewDialog;
                    this.previewForm = previewDialog.querySelector("form");
                    this.previewImage = previewDialog.querySelector("img");

                    this.cropper = null;

                    this.imageFormInput.addEventListener("change", () => this.onImageAdded());
                    this.previewForm.addEventListener("submit", () => this.onCrop());
                }

                getImage() {
                    return this.imageFormInput.files[0];
                }

                onImageAdded() {
                    const file = this.getImage();

                    if (!file || !file.type.startsWith("image/"))
                        return;

                    const reader = new FileReader();
                    reader.onload = (e) => {
                        this.previewImage.src = e.target.result;
                        this.previewDialog.showModal();

                        if (this.cropper) this.cropper.destroy();

                        this.cropper = new Cropper(this.previewImage, {
                            aspectRatio: 1,
                            viewMode: 1
                        });

                    };

                    reader.readAsDataURL(file);
                }

                onCrop() {
                    const canvas = this.cropper.getCroppedCanvas({width: 160, height: 160});

                    canvas.toBlob(blob => {
                        const formData = new FormData(this.imageForm);
                        formData.set(this.imageFormInput.name, blob, this.getImage().name);

                        fetch(this.imageForm.action, {
                            method: this.imageForm.method,
                            body: formData
                        }).then(res =>
                            res.json()
                        ).then(data => {
                            if (data)
                                this.imageFormImage.src = data.href;
                        }).catch(err => {
                            console.error("上传出错：", err);
                            location.reload();
                        });
                    });
                }
            }

            const imageUpload = new ImageUpload(
                document.querySelector("form#image-upload"),
                document.querySelector("dialog#crop-preview")
            );
        </script>
    </jsp:body>

</webstore:base>
