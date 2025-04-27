<%--
  Created by IntelliJ IDEA.
  User: CheeHua
  Date: 4/25/2025
  Time: 1:15 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="webstore" tagdir="/WEB-INF/tags/webstore" %>
<%@ taglib prefix="account" tagdir="/WEB-INF/tags/account" %>


<c:set var="pageTitle" value="Checkout" />

<webstore:base pageTitle="${pageTitle}">
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <style>
            * {
                box-sizing: border-box;
            }
            html, body {
                margin: 0;
                padding: 0;
                height: 100%;
            }

            body {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }

            main {
                display: flex;
                justify-content: center;
                align-items: flex-start; /* align to top, not center screen */
                padding-top: 20px;
                flex: 1;
            }
            .content-wrapper {
                flex: 1;
                display: flex;
                flex-direction: column;
                justify-content: flex-start;
                padding-top: 20px;
            }
            .container {
                display: flex;
                max-width: 1200px;
                width: 100%;
                gap: 20px;
                margin: 0 auto;
                padding: 20px;
            }
            .left-area {
                flex: 2;
                display: flex;
                flex-direction: column;
                gap: 20px;
                /* 为了左侧区域内容整体居中 */
                justify-content: center;
            }
            .right-area {
                flex: 1;
                position: sticky;
                top: 20px;
                align-self: flex-start; /* sticky生效，且顶端对齐 */
                background: #fff;
                padding: 15px;
                border-radius: 8px;
                box-shadow: 0 0 12px rgba(0,0,0,0.05);
                height: fit-content;
                display: flex;
                flex-direction: column;
                justify-content: center;
            }
            .section {
                background: #fff;
                border-bottom: 8px solid #f5f5f5;
                padding: 15px;
                border-radius: 8px;
            }
            .section:last-child {
                border-bottom: none;
            }
            /* 商品列表 */
            .product-item {
                display: flex;
                align-items: flex-start;
                gap: 15px;
                padding-bottom: 15px;
                border-bottom: 1px solid #eee;
            }
            .product-item:last-child {
                border-bottom: none;
                padding-bottom: 0;
            }
            .product-item img {
                width: 80px;
                height: 80px;
                object-fit: cover;
                border-radius: 8px;
                flex-shrink: 0;
            }
            .product-info h4 {
                margin: 0 0 5px;
                font-weight: normal;
                font-size: 16px;
                line-height: 1.2;
            }
            .product-info .price {
                font-weight: bold;
                color: #FF5722;
            }
            /* 支付选项 */
            .payment-option-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 10px;
            }
            /* 确认按钮 */
            .place-order-btn {
                width: 100%;
                background-color: #ff5722;
                color: white;
                border: none;
                padding: 15px 0;
                border-radius: 8px;
                font-size: 16px;
                font-weight: bold;
                cursor: pointer;
                margin-top: 20px;
            }
            /* Modal 样式 */
            .modal {
                display: none;
                position: fixed;
                top: 0; left: 0; width: 100%; height: 100%;
                background: rgba(0,0,0,0.5);
                backdrop-filter: blur(5px);
                justify-content: center;
                align-items: center;
                z-index: 9999;
            }
            .modal-content {
                background: white;
                width: 100%;
                max-width: 400px;
                max-height: 90vh;
                overflow-y: auto;
                border-radius: 10px;
                display: flex;
                flex-direction: column;
            }
            .modal-header {
                display: flex;
                align-items: center;
                padding: 16px;
                border-bottom: 1px solid #eee;
            }
            .modal-header img {
                width: 24px;
                cursor: pointer;
            }
            .modal-header-title {
                margin-left: 16px;
                font-size: 20px;
                font-weight: bold;
            }
            .method, .sub-option, .standalone-option {
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 16px;
                border-bottom: 1px solid #eee;
                cursor: pointer;
                transition: background-color 0.3s;
            }
            .method img, .sub-option img, .standalone-option img {
                width: 32px;
                height: 32px;
                margin-right: 12px;
                flex-shrink: 0;
            }
            .method .left, .sub-option .left, .standalone-option .left {
                display: flex;
                align-items: center;
                flex-grow: 1;
            }
            .sub-option .left {
                padding-left: 32px;
            }
            .sub-option-text {
                display: flex;
                flex-direction: column;
            }
            .sub-option-text .title {
                font-weight: bold;
            }
            .sub-option-text .subtitle {
                font-size: 12px;
                color: #666;
            }
            .method > div:last-child {
                font-size: 18px;
                color: #999;
                transition: transform 0.3s;
                user-select: none;
            }
            .method.expanded > div:last-child {
                transform: rotate(90deg);
                color: #FF5722;
            }
            .sub-options {
                display: none;
                background: #fafafa;
            }
            .sub-option:hover, .standalone-option:hover {
                background-color: #FFEBE6;
            }
            .sub-option.selected, .standalone-option.selected {
                background-color: #FF5722;
                color: white;
            }
            .sub-option.selected .left img, .standalone-option.selected .left img {
                filter: brightness(0) invert(1);
            }
            .confirm-btn {
                margin: 16px;
                background: #FF5722;
                color: white;
                text-align: center;
                padding: 16px;
                border-radius: 8px;
                font-weight: bold;
                font-size: 16px;
                cursor: pointer;
                user-select: none;
            }
        </style>
    </head>

    <body>
    <main>
        <div class="content-wrapper">
            <div class="container">

        <!-- 左边内容 -->
        <div class="left-area">

            <!-- 地址 -->
            <div class="section">
                <strong>Ali</strong> (+60) 12-345 6789 <br />
                iuhasduihiuahuihiuh <br />
                hihihi, selangor <br />
                Kuala Selangor, Selangor, 45500
            </div>

            <!-- 商品区块 -->
            <div class="section">
                <div id="product-list">
                    <!-- 商品示例1 -->
                    <div class="product-item">
                        <img
                                src="https://down-my.img.susercontent.com/file/9db5556f3acc5c0992ed9988fc0a2fac"
                                alt="Product 1"
                        />
                        <div class="product-info">
                            <h4>Japanese Minimalist Large Capacity Crossbody N...</h4>
                            <div class="price">RM16.39</div>
                        </div>
                    </div>

                    <!-- 商品示例2 -->
                    <div class="product-item">
                        <img
                                src="https://down-my.img.susercontent.com/file/3d4d90f8da2348e1af8aff11887981e4"
                                alt="Product 2"
                        />
                        <div class="product-info">
                            <h4>Wireless Bluetooth Earbuds</h4>
                            <div class="price">RM89.00</div>
                        </div>
                    </div>

                    <!-- 商品示例3 -->
                    <div class="product-item">
                        <img
                                src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQi3Fz5_XMRRnh19vUPn-hg7s724__VY5Kxig&s"
                                alt="Product 3"
                        />
                        <div class="product-info">
                            <h4>Stainless Steel Water Bottle</h4>
                            <div class="price">RM45.50</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Payment Option -->
            <div class="section">
                <div class="payment-option-header">
                    <div>
                        <div style="font-weight: bold">Payment Option</div>
                        <div id="selected-payment" style="margin-top: 5px">
                            Online Banking - Maybank2u
                        </div>
                    </div>
                    <a
                            href="javascript:void(0);"
                            onclick="openModal()"
                            style="color: #00c2a8; font-size: 14px"
                    >View All</a
                    >
                </div>
            </div>
        </div>

        <!-- 右边付款明细 -->
        <div class="right-area">
            <!-- Payment Details -->
            <div class="section">
                <div style="font-weight: bold; margin-bottom: 10px">Payment Details</div>

                <div
                        style="display: flex; justify-content: space-between; margin-bottom: 5px"
                >
                    <div>Merchandise Subtotal</div>
                    <div id="merch-subtotal">RM150.89</div>
                </div>
                <div
                        style="display: flex; justify-content: space-between; margin-bottom: 5px"
                >
                    <div>Shipping Subtotal (excl. SST)</div>
                    <div>RM4.90</div>
                </div>
                <div
                        style="display: flex; justify-content: space-between; margin-bottom: 5px"
                >
                    <div>Shipping Fee SST</div>
                    <div>RM0.29</div>
                </div>
                <div
                        style="
            display: flex;
            justify-content: space-between;
            font-weight: bold;
            margin-top: 10px;
          "
                >
                    <div>Total Payment</div>
                    <div id="total-payment">RM156.08</div>
                </div>

                <!-- Place Order Button -->
                <button class="place-order-btn">Place Order</button>
            </div>
        </div>
    </div>
        </div>

    <!-- Modal -->
    <div id="modal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <img
                        src="https://img.icons8.com/ios-glyphs/30/000000/left.png"
                        onclick="closeModal()"
                        alt="Close"
                />
                <div class="modal-header-title">Payment Method</div>
            </div>

            <div class="payment-list">
                <div class="method" onclick="toggleSubOptions('banking-options')">
                    <div class="left">
                        <img src="https://img.icons8.com/ios-filled/50/000000/bank.png" alt="Bank" />
                        Online Banking
                    </div>
                    <div>&#x25B6;</div>
                </div>

                <div id="banking-options" class="sub-options">
                    <div class="sub-option" onclick="selectPaymentOption(this, 'Maybank')">
                        <div class="left">
                            <img
                                    src="https://img.icons8.com/color/48/ocbc-bank.png"
                                    alt="Maybank"
                            />
                            <div class="sub-option-text">
                                <div class="title">Maybank</div>
                                <div class="subtitle">Online Banking</div>
                            </div>
                        </div>
                    </div>

                    <div class="sub-option" onclick="selectPaymentOption(this, 'Public Bank')">
                        <div class="left">
                            <img
                                    src="https://img.icons8.com/color/48/alliance-bank.png"
                                    alt="Public Bank"
                            />
                            <div class="sub-option-text">
                                <div class="title">Public Bank</div>
                                <div class="subtitle">Online Banking</div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="method" onclick="toggleSubOptions('cash-options')">
                    <div class="left">
                        <img src="https://img.icons8.com/ios-filled/50/000000/money.png" alt="Cash" />
                        Cash Payment
                    </div>
                    <div>&#x25B6;</div>
                </div>

                <div id="cash-options" class="sub-options">
                    <div class="sub-option" onclick="selectPaymentOption(this, '7-Eleven')">
                        <div class="left">
                            <img src="https://img.icons8.com/color/48/7-eleven.png" alt="7-Eleven" />
                            <div class="sub-option-text">
                                <div class="title">7-Eleven</div>
                                <div class="subtitle">Cash Payment</div>
                            </div>
                        </div>
                    </div>
                </div>

                <div
                        class="standalone-option"
                        onclick="selectPaymentOption(this, 'Cash on Delivery')"
                >
                    <div class="left">
                        <img
                                src="https://img.icons8.com/ios-filled/50/000000/box--v1.png"
                                alt="Cash on Delivery"
                        />
                        <div class="sub-option-text">
                            <div class="title">Cash on Delivery</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="confirm-btn" onclick="confirmSelection()">CONFIRM</div>
        </div>
    </div>
    </main>
    </body>
    </html>

</webstore:base>

<script>
    // Modal 开关
    function openModal() {
        document.getElementById("modal").style.display = "flex";
    }
    function closeModal() {
        document.getElementById("modal").style.display = "none";
    }

    // 展开/收起子选项
    function toggleSubOptions(id) {
        const el = document.getElementById(id);
        const methodEl = el.previousElementSibling;
        const isVisible = el.style.display === "block";
        el.style.display = isVisible ? "none" : "block";
        methodEl.classList.toggle("expanded", !isVisible);
    }

    // 选择支付选项
    function selectPaymentOption(element, paymentName) {
        document
            .querySelectorAll(".sub-option.selected, .standalone-option.selected")
            .forEach((el) => {
                el.classList.remove("selected");
            });
        element.classList.add("selected");
        window.selectedPayment = paymentName;
    }

    // 确认支付选项
    function confirmSelection() {
        if (window.selectedPayment) {
            document.getElementById("selected-payment").innerText = window.selectedPayment;
        }
        closeModal();
    }
</script>

