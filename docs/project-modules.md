Project Modules Overview
========================

## Backend Modules

<table>
    <tr>
        <th>Category</th>
        <th>Modules</th>
        <th>Scope</th>
    </tr>
    <tr>
        <td rowspan="3">Account</td>
        <td>Account Management 🟡</td>
        <td>
            <ul>
                <li>Manage username & email & password</li>
                <li>Manage addresses</li>
                <li>Manage login settings (optional)</li>
            </ul>
        </td>
    </tr>
    <tr>
        <td>Cart 🟡</td>
        <td>
            <ul>
                <li>Add & remove products from cart</li>
                <li>View cart products</li>
                <li>Change product count</li>
                <li>Guest cart when not logged in</li>
                <li>Merges guest cart into account cart on login</li>
                <li>Checkout product in cart</li>
            </ul>
        </td>
    </tr>
    <tr>
        <td>Order 🔴</td>
        <td>
            <ul>
                <li>List order histories</li>
                <li>Show order details
                    <ul>
                        <li>Products purchased</li>
                        <li>Shipping address</li>
                        <li>Ordered date</li>
                        <li>Total paid</li>
                    </ul>
                </li>
                <li>Show order status
                    <ul>
                        <li>Arriving</li>
                        <li>Completed</li>
                        <li>Canceled (optional)</li>
                    </ul>
                </li>
                <li>Show and track product status
                    <ul>
                        <li>Ordered</li>
                        <li>Shipped</li>
                        <li>Out for delivery</li>
                        <li>Delivered</li>
                    </ul>
                </li>
            </ul>
        </td>
    </tr>
    <tr>
        <td rowspan="3">Security</td>
        <td>Account Registration 🟡</td>
        <td>
            <ul>
                <li>Minimum password requirements (12 chars, 1 capital and lowercase min)</li>
                <li>Client side input validation</li>
                <li>Server side input validation</li>
                <li>Password hashing</li>
            </ul>
        </td>
    </tr>
    <tr>
        <td>Account Login 🟡</td>
        <td>
            <ul>
                <li>Form-based login</li>
                <li>Remember me feature (optional)</li>
                <li>2FA (optional)</li>
            </ul>
        </td>
    </tr>
    <tr>
        <td>Role 🟢</td>
        <td>
            <ul>
                <li>Role-based distinction for users
                    <ul>
                        <li>User</li>
                        <li>Staff</li>
                    </ul>
                </li>
            </ul>
        </td>
    </tr>
    <tr>
        <td rowspan="3">Product</td>
        <td>Product Information 🟡</td>
        <td>
            <ul>
                <li>View product information
                    <ul>
                        <li>Name & description</li>
                        <li>Price</li>
                        <li>Stock count</li>
                        <li>Ratings</li>
                        <li>Discounts (if applicable)</li>
                    </ul>
                </li>
                <li>Add product to cart on its product page</li>
                <li>Purchase multiple quantity product at once</li>
                <li>Show delivery charge</li>
            </ul>
        </td>
    </tr>
    <tr>
        <td>Searching 🟡</td>
        <td>
            <ul>
                <li>Searching / filtering with:
                    <ul>
                        <li>name</li>
                        <li>category</li>
                        <li>brand</li>
                        <li>product id</li>
                    </ul>
                </li>
                <li>Paginated result</li>
                <li>Endless scrolling (optional)</li>
            </ul>
        </td>
    </tr>
    <tr>
        <td>Rating 🟢</td>
        <td>
            <ul>
                <li>Customer adds rating to products</li>
                <li>Allow for message with rating as comments</li>
                <li>Allow reply to comments</li>
            </ul>
        </td>
    </tr>
    <tr>
        <td rowspan="2">Payment</td>
        <td>Checkout 🟡</td>
        <td>
            <ul>
                <li>Choose shipping address</li>
                <li>Choose payment method</li>
                <li>Review checkout details
                    <ul>
                        <li>Cart</li>
                        <li>Price</li>
                        <li>Shipping address</li>
                        <li>Shipping cost</li>
                        <li>Tax cost</li>
                        <li>Discounted cost
                            <ul>
                                <li>Promotion</li>
                                <li>Voucher</li>
                            </ul>
                        </li>
                    </ul>
                </li>
            </ul>
        </td>
    </tr>
    <tr>
        <td>Payment processing 🟡</td>
        <td>
            <ul>
                <li>Mock fake payment methods</li>
                <li>Input validation for each method</li>
                <li>"Verify" payment went through</li>
                <li>Create sufficient payment record and description (Don't reveal sensitive info)</li>
            </ul>
        </td>
    </tr>
    <tr>
        <td rowspan="2">Promotion</td>
        <td>Promotion campaign 🟡</td>
        <td>
            <ul>
                <li>Products with discounted price for limited time</li>
                <li>Promotion placement in home page, header, etc.</li>
            </ul>
        </td>
    </tr>
    <tr>
        <td>Voucher</td>
        <td>
            <ul>
                TODO:
                <li>Distributed to users</li>
                <li>Has expiration</li>
            </ul>
        </td>
    </tr>
    <tr>
        <td rowspan="5">Admin</td>
        <td>Admin Panel 🟢</td>
        <td>
            <ul>
                <li>Dashboard for admin features</li>
                <li>Only allow staff & admin role users.</li>
            </ul>
        </td>
    </tr>
    <tr>
        <td>Product Management 🟢</td>
        <td>
            <ul>
                <li>Add & edit & remove product information</li>
            </ul>
        </td>
    </tr>
    <tr>
        <td>Customer Account Management 🟢</td>
        <td>
            <ul>
                <li>Add & edit & remove customer accounts</li>
            </ul>
        </td>
    </tr>
    <tr>
        <td>Staff Account Management 🟢</td>
        <td>
            <ul>
                <li>Add & edit & remove staff accounts</li>
            </ul>
        </td>
    </tr>
    <tr>
        <td>Reporting 🟡</td>
        <td>
            <ul>
                <li>Overview on business performances</li>
                <li>Examples:
                    <ul>
                        <li>Top-selling products</li>
                        <li>Low stock and out of stock products</li>
                    </ul>
                </li>
            </ul>
        </td>
    </tr>
</table>

## Frontend Modules

<table>
    <tr>
        <th>Category</th>
        <th>Modules</th>
        <th>Scope</th>
    </tr>
    <tr>
        <td rowspan="2">Page components</td>
        <td>Header</td>
        <td>
            <ul>
                <li></li>
            </ul>
        </td>
    </tr>
    <tr>
        <td>Footer</td>
        <td>
            <ul>
                <li></li>
            </ul>
        </td>
    </tr>
</table>