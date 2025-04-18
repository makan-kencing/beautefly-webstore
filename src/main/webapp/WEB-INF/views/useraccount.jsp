<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Account Page</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.5.13/cropper.min.css" rel="stylesheet"/>
</head>
<body class="bg-white p-10 font-sans">
<div class="max-w-md mx-auto text-center">
    <div class="w-20 h-20 rounded-full overflow-hidden mx-auto mb-3 border-2 border-gray-300">
        <img id="view-avatar" src="https://i.pravatar.cc/150?img=65" class="w-full h-full object-cover">
    </div>

    <!-- View Mode -->
    <div id="view-mode" class="text-left space-y-4">
        <div>
            <div class="font-medium text-gray-700">Name</div>
            <div id="view-name" class="mt-1 p-3 bg-gray-100 rounded-md border border-gray-300">Velda</div>
        </div>
        <div>
            <div class="font-medium text-gray-700">Phone</div>
            <div id="view-phone" class="mt-1 p-3 bg-gray-100 rounded-md border border-gray-300">012-3456789</div>
        </div>
        <div>
            <div class="font-medium text-gray-700">Email</div>
            <div id="view-email" class="mt-1 p-3 bg-gray-100 rounded-md border border-gray-300">velda@gmail.com</div>
        </div>
        <div>
            <div class="font-medium text-gray-700">Gender</div>
            <div id="view-gender" class="mt-1 p-3 bg-gray-100 rounded-md border border-gray-300">Male</div>
        </div>
    </div>

    <!-- Edit Mode -->
    <form id="edit-mode" class="text-left space-y-4 hidden" onsubmit="return saveChanges();">
        <input type="file" id="avatar-input" accept="image/*" class="text-sm mb-2">

        <input type="hidden" id="croppedImageData">

        <div>
            <label class="font-medium text-gray-700 block">Name</label>
            <input type="text" id="edit-name" value="Velda" class="mt-1 p-3 w-full bg-white border border-gray-300 rounded-md">
        </div>
        <div>
            <label class="font-medium text-gray-700 block">Phone</label>
            <input type="text" id="edit-phone" value="012-3456789" class="mt-1 p-3 w-full bg-white border border-gray-300 rounded-md">
        </div>
        <div>
            <label class="font-medium text-gray-700 block">Email</label>
            <input type="email" id="edit-email" value="velda@gmail.com" class="mt-1 p-3 w-full bg-white border border-gray-300 rounded-md">
        </div>
        <div>
            <label class="font-medium text-gray-700 block">Gender</label>
            <div class="mt-1">
                <label class="inline-flex items-center mr-4">
                    <input type="radio" name="edit-gender" value="Male" checked class="form-radio text-blue-600"> <span class="ml-2">Male</span>
                </label>
                <label class="inline-flex items-center">
                    <input type="radio" name="edit-gender" value="Female" class="form-radio text-pink-600"> <span class="ml-2">Female</span>
                </label>
            </div>
        </div>
        <div class="text-center pt-4">
            <button type="submit" class="px-5 py-2 bg-green-600 text-white rounded-md hover:bg-green-700 transition">
                Save
            </button>
        </div>
    </form>

    <button id="edit-button"
            class="mt-8 px-5 py-2 bg-blue-600 text-white rounded-md text-sm hover:bg-blue-700 transition">
        Edit
    </button>
</div>

<!-- Cropper Modal -->
<div id="cropperModal" class="hidden fixed inset-0 bg-black bg-opacity-60 flex items-center justify-center z-50 border-4 border-black">
    <div class="bg-white p-6 border-4 border-white rounded-xl text-center max-w-sm w-full" style="margin: 5px;">
        <img id="crop-preview" class="max-w-full max-h-72 mb-4">
        <button type="button" onclick="getCroppedImage()" class="bg-green-600 text-white px-4 py-2 rounded-md hover:bg-green-700">Confirm</button>
    </div>
</div>


<script src="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.5.13/cropper.min.js"></script>
<script>
    const viewMode = document.getElementById("view-mode");
    const editMode = document.getElementById("edit-mode");
    const editBtn = document.getElementById("edit-button");
    const avatarInput = document.getElementById("avatar-input");
    const viewAvatar = document.getElementById("view-avatar");
    let cropper;

    editBtn.addEventListener("click", () => {
        viewMode.classList.add("hidden");
        editMode.classList.remove("hidden");
        editBtn.classList.add("hidden");
    });

    function saveChanges() {
        document.getElementById("view-name").textContent = document.getElementById("edit-name").value;
        document.getElementById("view-phone").textContent = document.getElementById("edit-phone").value;
        document.getElementById("view-email").textContent = document.getElementById("edit-email").value;

        const gender = document.querySelector('input[name="edit-gender"]:checked').value;
        document.getElementById("view-gender").textContent = gender;

        const avatarData = document.getElementById("croppedImageData").value;
        if (avatarData) {
            viewAvatar.src = avatarData;
        }

        editMode.classList.add("hidden");
        viewMode.classList.remove("hidden");
        editBtn.classList.remove("hidden");

        return false;
    }

    avatarInput.addEventListener('change', function (event) {
        const file = event.target.files[0];
        if (file && file.type.startsWith('image/')) {
            const reader = new FileReader();
            reader.onload = function (e) {
                const img = document.getElementById('crop-preview');
                img.src = e.target.result;
                document.getElementById('cropperModal').classList.remove('hidden');

                if (cropper) cropper.destroy();
                cropper = new Cropper(img, {
                    aspectRatio: 1,
                    viewMode: 1
                });
            };
            reader.readAsDataURL(file);
        }
    });

    function getCroppedImage() {
        const canvas = cropper.getCroppedCanvas({ width: 80, height: 80 });
        const avatarURL = canvas.toDataURL();
        viewAvatar.src = avatarURL;
        document.getElementById("croppedImageData").value = avatarURL;
        document.getElementById("cropperModal").classList.add('hidden');
    }
</script>
</body>
</html>
