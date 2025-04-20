<%@tag description="webstorefooter.tag" pageEncoding="UTF-8" %>

<footer class="bg-linear-65 from-blue-300 to-pink-300 flex flex-col items-center p-5 text-white gap-2 font-bold">
    <p>${initParam["company.copyright"]}</p>
    <p>Contact Us: <a href="mailto:${initParam['company.email']}">${initParam["company.email"]}</a></p>

    <div>
        <span>Follow Us：</span>
        <ul class="flex gap-2 items-center">
            <li><a href="#"><i class="fa-brands fa-facebook"></i></a></li>
            <li><a href="#"><i class="fa-brands fa-instagram"></i></a></li>
            <li><a href="#"><i class="fa-brands fa-twitter"></i></a></li>
        </ul>
    </div>
</footer>