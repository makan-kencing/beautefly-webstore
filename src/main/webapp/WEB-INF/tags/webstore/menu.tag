<%@tag description="menubar" pageEncoding="UTF-8" %>

<div id="sidebar" class="w-[300px] bg-white p-5 border-r border-gray-300 hidden flex-shrink-0">
    <h1 class="text-3xl">Product List</h1>
    <ul>
        <li onclick="showContent('sc')">Skin Care</li>
        <li onclick="showContent('mu')">Makeup</li>
        <li onclick="showContent('bc')">Body Care</li>
        <li onclick="showContent('hc')">Hair Care</li>
        <li onclick="showContent('bt')">Beauty Tools & Devices</li>
        <li onclick="showContent('st')">Special Treatments</li>
    </ul>
</div>
<div class="content" id="contentArea">
</div>

<script>
    function toggleMenu() {
        const sidebar = document.getElementById('sidebar');
        const content = document.getElementById('contentArea');



        if (sidebar.style.display === 'block') {
            sidebar.style.display = 'none';
            content.innerHTML = '';
        } else {
            sidebar.style.display = 'block';
        }
    }

    function showContent(category) {
        const content = document.getElementById('contentArea');
        content.innerHTML = '';

        if (category === 'sc') {
            const sub = document.createElement('ul');
            sub.className = 'subcategories';
            sub.innerHTML = `
        <li onclick="showSubContent('sc_cl')">Cleansing</li>
        <li onclick="showSubContent('sc_to')">Toning</li>
        <li onclick="showSubContent('sc_mo')">Moisturizing</li>
        <li onclick="showSubContent('sc_set')">Serums & Treatments</li>
        <li onclick="showSubContent('sc_ec')">Eye Care</li>
        <li onclick="showSubContent('sc_sp')">Sun Protection</li>
        <li onclick="showSubContent('sc_spt')">Special Treatments</li>
        <li onclick="showSubContent('sc_rr')">Repair & Recovery</li>
      `;
            content.appendChild(sub);
        }
        else if (category === 'mu') {
            const sub = document.createElement('ul');
            sub.className = 'subcategories';
            sub.innerHTML = `
        <li onclick="showSubContent('mu_bm')">Base Makeup</li>
        <li onclick="showSubContent('mu_em')">Eye Makeup</li>
        <li onclick="showSubContent('mu_lm')">Lip Makeup</li>
        <li onclick="showSubContent('mu_bc')">Blush & Contouring</li>
        <li onclick="showSubContent('mu_sm')">Setting Makeup</li>
      `;
            content.appendChild(sub);
        }
        else if (category === 'bc') {
            const sub = document.createElement('ul');
            sub.className = 'subcategories';
            sub.innerHTML = `
        <li onclick="showSubContent('bc_cs')">Cleansing</li>
        <li onclick="showSubContent('bc_mt')">Moisturizing</li>
        <li onclick="showSubContent('bc_fg')">Fragrance</li>
        <li onclick="showSubContent('bc_hr')">Hair Removal</li>
        <li onclick="showSubContent('bc_wa')">Whitening & Acne Treatment</li>
      `;
            content.appendChild(sub);
        }
        else if (category === 'hc') {
            const sub = document.createElement('ul');
            sub.className = 'subcategories';
            sub.innerHTML = `
        <li onclick="showSubContent('hc_sc')">Shampoo & Conditioner</li>
        <li onclick="showSubContent('hc_ht')">Hair Treatment</li>
        <li onclick="showSubContent('hc_sl')">Styling</li>
        <li onclick="showSubContent('hc_hc')">Hair Coloring</li>
      `;
            content.appendChild(sub);
        }
        else if (category === 'bt') {
            const sub = document.createElement('ul');
            sub.className = 'subcategories';
            sub.innerHTML = `
        <li onclick="showSubContent('bt_mu')">Makeup Tools</li>
        <li onclick="showSubContent('bt_sd')">Skincare Devices</li>
        <li onclick="showSubContent('bt_hr')">Hair Removal Devices</li>
        <li onclick="showSubContent('bt_mt')">Massage Tools</li>
        <li onclick="showSubContent('bt_nc')">Nail Care Tools</li>
      `;
            content.appendChild(sub);
        }
        else if (category === 'st') {
            const sub = document.createElement('ul');
            sub.className = 'subcategories';
            sub.innerHTML = `
        <li onclick="showSubContent('st_at')">Acne Treatment</li>
        <li onclick="showSubContent('st_aa')">Anti-Aging</li>
        <li onclick="showSubContent('st_wn')">Whitening</li>
        <li onclick="showSubContent('st_ss')">Sensitive Skin Repair</li>
        <li onclick="showSubContent('st_dc')">Dark Circle Treatment</li>
      `;
            content.appendChild(sub);
        }
        else {
            renderCards(category);
        }
    }

    function showSubContent(sub) {
        const content = document.getElementById('contentArea');
        content.innerHTML = '';
        renderCards(sub);
    }

    function renderCards(category) {
        const content = document.getElementById('contentArea');

        const sc = {
            sc_cl: [
                { img: 'https://threebs.co/cdn/shop/products/cerave-hydrating-facial-cleanser-562ml-IMG1-20220509.jpg?v=1660118122', text: 'CeraVe Hydrating Facial Cleanser' },
                { img: 'https://www.laroche-posay.com.my/-/media/project/loreal/brand-sites/lrp/apac/my/products/toleriane/caring-wash/la-roche-posay-productpage-sensitive-allergic-toleriane-caring-wash-400ml-3337875545778-front.png?cx=0&amp;ch=600&amp;cy=0&amp;cw=600&hash=3342295D7647E9CBC13AE59681C05688', text: 'La Roche-Posay Toleriane Purifying Foaming Cleanser' },
                { img: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPfex0l05PS7tQlQbFya0IaMOVuRSBhRU6EQ&s', text: 'Fresh Soy Face Cleanser' },
                { img: 'https://www.kiehls.com.my/dw/image/v2/BFZM_PRD/on/demandware.static/-/Sites-kiehls-master-catalog/default/dw9ab9a786/nextgen/skin-care/face-cleansers/ultra-facial/ultra-facial-cleanser/kiehls-face-cleanser-ultra-facial-cleanser-150ml-000-3605970024192-front.jpg?sw=320&sh=320&sm=cut&sfrm=png&q=70', text: 'Kiehls Ultra Facial Cleanser' },
                { link:'#', text: 'Shiseido Perfect Whip Cleansing Foam' }
            ],
            sc_to: [
                { img: 'https://via.placeholder.com/400x300?text=For+Him+1', text: 'Smart Watches' },
                { img: 'https://via.placeholder.com/400x300?text=For+Him+2', text: 'Sleek Wallets' }
            ],
            sc_mo: [
                { img: 'https://via.placeholder.com/400x300?text=For+Kids+1', text: 'Cute Toys' },
                { img: 'https://via.placeholder.com/400x300?text=For+Kids+2', text: 'Fun Clothes' }
            ],
            sc_set: [
                { img: 'https://via.placeholder.com/400x300?text=Newborn+1', text: 'Soft Blankets' },
                { img: 'https://via.placeholder.com/400x300?text=Newborn+2', text: 'Baby Essentials' }
            ],
            sc_ec: [
                { img: 'https://via.placeholder.com/400x300?text=Newborn+1', text: 'Soft Blankets' },
                { img: 'https://via.placeholder.com/400x300?text=Newborn+2', text: 'Baby Essentials' }
            ],
            sc_sp: [
                { img: 'https://via.placeholder.com/400x300?text=Newborn+1', text: 'Soft Blankets' },
                { img: 'https://via.placeholder.com/400x300?text=Newborn+2', text: 'Baby Essentials' }
            ],
            sc_spt: [
                { img: 'https://via.placeholder.com/400x300?text=Newborn+1', text: 'Soft Blankets' },
                { img: 'https://via.placeholder.com/400x300?text=Newborn+2', text: 'Baby Essentials' }
            ],
            sc_rr: [
                { img: 'https://via.placeholder.com/400x300?text=Newborn+1', text: 'Soft Blankets' },
                { img: 'https://via.placeholder.com/400x300?text=Newborn+2', text: 'Baby Essentials' }
            ]
        };
        const mu = {
            mu_bm: [
                { img: 'https://threebs.co/cdn/shop/products/cerave-hydrating-facial-cleanser-562ml-IMG1-20220509.jpg?v=1660118122', text: 'CeraVe Hydrating Facial Cleanser' },
                { img: 'https://www.laroche-posay.com.my/-/media/project/loreal/brand-sites/lrp/apac/my/products/toleriane/caring-wash/la-roche-posay-productpage-sensitive-allergic-toleriane-caring-wash-400ml-3337875545778-front.png?cx=0&amp;ch=600&amp;cy=0&amp;cw=600&hash=3342295D7647E9CBC13AE59681C05688', text: 'La Roche-Posay Toleriane Purifying Foaming Cleanser' },
                { img: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPfex0l05PS7tQlQbFya0IaMOVuRSBhRU6EQ&s', text: 'Fresh Soy Face Cleanser' },
                { img: 'https://www.kiehls.com.my/dw/image/v2/BFZM_PRD/on/demandware.static/-/Sites-kiehls-master-catalog/default/dw9ab9a786/nextgen/skin-care/face-cleansers/ultra-facial/ultra-facial-cleanser/kiehls-face-cleanser-ultra-facial-cleanser-150ml-000-3605970024192-front.jpg?sw=320&sh=320&sm=cut&sfrm=png&q=70', text: 'Kiehls Ultra Facial Cleanser' },
                { img: 'https://shop.shiseido.com.my/cdn/shop/files/14529_S_2_1000x.jpg?v=1735660887', text: 'Shiseido Perfect Whip Cleansing Foam' }
            ],
            mu_em: [
                { img: 'https://via.placeholder.com/400x300?text=For+Him+1', text: 'Smart Watches' },
                { img: 'https://via.placeholder.com/400x300?text=For+Him+2', text: 'Sleek Wallets' }
            ],
            mu_lm: [
                { img: 'https://via.placeholder.com/400x300?text=For+Kids+1', text: 'Cute Toys' },
                { img: 'https://via.placeholder.com/400x300?text=For+Kids+2', text: 'Fun Clothes' }
            ],
            mu_bc: [
                { img: 'https://via.placeholder.com/400x300?text=Newborn+1', text: 'Soft Blankets' },
                { img: 'https://via.placeholder.com/400x300?text=Newborn+2', text: 'Baby Essentials' }
            ],
            mu_sm: [
                { img: 'https://via.placeholder.com/400x300?text=Newborn+1', text: 'Soft Blankets' },
                { img: 'https://via.placeholder.com/400x300?text=Newborn+2', text: 'Baby Essentials' }
            ]
        };

        const bc = {
            bc_cs: [
                { img: 'https://threebs.co/cdn/shop/products/cerave-hydrating-facial-cleanser-562ml-IMG1-20220509.jpg?v=1660118122', text: 'CeraVe Hydrating Facial Cleanser' },
                { img: 'https://www.laroche-posay.com.my/-/media/project/loreal/brand-sites/lrp/apac/my/products/toleriane/caring-wash/la-roche-posay-productpage-sensitive-allergic-toleriane-caring-wash-400ml-3337875545778-front.png?cx=0&amp;ch=600&amp;cy=0&amp;cw=600&hash=3342295D7647E9CBC13AE59681C05688', text: 'La Roche-Posay Toleriane Purifying Foaming Cleanser' },
                { img: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPfex0l05PS7tQlQbFya0IaMOVuRSBhRU6EQ&s', text: 'Fresh Soy Face Cleanser' },
                { img: 'https://www.kiehls.com.my/dw/image/v2/BFZM_PRD/on/demandware.static/-/Sites-kiehls-master-catalog/default/dw9ab9a786/nextgen/skin-care/face-cleansers/ultra-facial/ultra-facial-cleanser/kiehls-face-cleanser-ultra-facial-cleanser-150ml-000-3605970024192-front.jpg?sw=320&sh=320&sm=cut&sfrm=png&q=70', text: 'Kiehls Ultra Facial Cleanser' },
                { img: 'https://shop.shiseido.com.my/cdn/shop/files/14529_S_2_1000x.jpg?v=1735660887', text: 'Shiseido Perfect Whip Cleansing Foam' }
            ],
            bc_mt: [
                { img: 'https://via.placeholder.com/400x300?text=For+Him+1', text: 'Smart Watches' },
                { img: 'https://via.placeholder.com/400x300?text=For+Him+2', text: 'Sleek Wallets' }
            ],
            bc_fg: [
                { img: 'https://via.placeholder.com/400x300?text=For+Kids+1', text: 'Cute Toys' },
                { img: 'https://via.placeholder.com/400x300?text=For+Kids+2', text: 'Fun Clothes' }
            ],
            bc_hr: [
                { img: 'https://via.placeholder.com/400x300?text=Newborn+1', text: 'Soft Blankets' },
                { img: 'https://via.placeholder.com/400x300?text=Newborn+2', text: 'Baby Essentials' }
            ],
            bc_wa: [
                { img: 'https://via.placeholder.com/400x300?text=Newborn+1', text: 'Soft Blankets' },
                { img: 'https://via.placeholder.com/400x300?text=Newborn+2', text: 'Baby Essentials' }
            ]
        };

        const hc = {
            hc_sc: [
                { img: 'https://threebs.co/cdn/shop/products/cerave-hydrating-facial-cleanser-562ml-IMG1-20220509.jpg?v=1660118122', text: 'CeraVe Hydrating Facial Cleanser' },
                { img: 'https://www.laroche-posay.com.my/-/media/project/loreal/brand-sites/lrp/apac/my/products/toleriane/caring-wash/la-roche-posay-productpage-sensitive-allergic-toleriane-caring-wash-400ml-3337875545778-front.png?cx=0&amp;ch=600&amp;cy=0&amp;cw=600&hash=3342295D7647E9CBC13AE59681C05688', text: 'La Roche-Posay Toleriane Purifying Foaming Cleanser' },
                { img: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPfex0l05PS7tQlQbFya0IaMOVuRSBhRU6EQ&s', text: 'Fresh Soy Face Cleanser' },
                { img: 'https://www.kiehls.com.my/dw/image/v2/BFZM_PRD/on/demandware.static/-/Sites-kiehls-master-catalog/default/dw9ab9a786/nextgen/skin-care/face-cleansers/ultra-facial/ultra-facial-cleanser/kiehls-face-cleanser-ultra-facial-cleanser-150ml-000-3605970024192-front.jpg?sw=320&sh=320&sm=cut&sfrm=png&q=70', text: 'Kiehls Ultra Facial Cleanser' },
                { img: 'https://shop.shiseido.com.my/cdn/shop/files/14529_S_2_1000x.jpg?v=1735660887', text: 'Shiseido Perfect Whip Cleansing Foam' }
            ],
            hc_ht: [
                { img: 'https://via.placeholder.com/400x300?text=For+Him+1', text: 'Smart Watches' },
                { img: 'https://via.placeholder.com/400x300?text=For+Him+2', text: 'Sleek Wallets' }
            ],
            hc_sl: [
                { img: 'https://via.placeholder.com/400x300?text=For+Kids+1', text: 'Cute Toys' },
                { img: 'https://via.placeholder.com/400x300?text=For+Kids+2', text: 'Fun Clothes' }
            ],
            hc_hc: [
                { img: 'https://via.placeholder.com/400x300?text=Newborn+1', text: 'Soft Blankets' },
                { img: 'https://via.placeholder.com/400x300?text=Newborn+2', text: 'Baby Essentials' }
            ]
        };

        const bt = {
            bt_mu: [
                { img: 'https://threebs.co/cdn/shop/products/cerave-hydrating-facial-cleanser-562ml-IMG1-20220509.jpg?v=1660118122', text: 'CeraVe Hydrating Facial Cleanser' },
                { img: 'https://www.laroche-posay.com.my/-/media/project/loreal/brand-sites/lrp/apac/my/products/toleriane/caring-wash/la-roche-posay-productpage-sensitive-allergic-toleriane-caring-wash-400ml-3337875545778-front.png?cx=0&amp;ch=600&amp;cy=0&amp;cw=600&hash=3342295D7647E9CBC13AE59681C05688', text: 'La Roche-Posay Toleriane Purifying Foaming Cleanser' },
                { img: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPfex0l05PS7tQlQbFya0IaMOVuRSBhRU6EQ&s', text: 'Fresh Soy Face Cleanser' },
                { img: 'https://www.kiehls.com.my/dw/image/v2/BFZM_PRD/on/demandware.static/-/Sites-kiehls-master-catalog/default/dw9ab9a786/nextgen/skin-care/face-cleansers/ultra-facial/ultra-facial-cleanser/kiehls-face-cleanser-ultra-facial-cleanser-150ml-000-3605970024192-front.jpg?sw=320&sh=320&sm=cut&sfrm=png&q=70', text: 'Kiehls Ultra Facial Cleanser' },
                { img: 'https://shop.shiseido.com.my/cdn/shop/files/14529_S_2_1000x.jpg?v=1735660887', text: 'Shiseido Perfect Whip Cleansing Foam' }
            ],
            bt_sd: [
                { img: 'https://via.placeholder.com/400x300?text=For+Him+1', text: 'Smart Watches' },
                { img: 'https://via.placeholder.com/400x300?text=For+Him+2', text: 'Sleek Wallets' }
            ],
            bt_hr: [
                { img: 'https://via.placeholder.com/400x300?text=For+Kids+1', text: 'Cute Toys' },
                { img: 'https://via.placeholder.com/400x300?text=For+Kids+2', text: 'Fun Clothes' }
            ],
            bt_mt: [
                { img: 'https://via.placeholder.com/400x300?text=Newborn+1', text: 'Soft Blankets' },
                { img: 'https://via.placeholder.com/400x300?text=Newborn+2', text: 'Baby Essentials' }
            ],
            bt_nc: [
                { img: 'https://via.placeholder.com/400x300?text=Newborn+1', text: 'Soft Blankets' },
                { img: 'https://via.placeholder.com/400x300?text=Newborn+2', text: 'Baby Essentials' }
            ]
        };

        const st = {
            st_at: [
                { img: 'https://threebs.co/cdn/shop/products/cerave-hydrating-facial-cleanser-562ml-IMG1-20220509.jpg?v=1660118122', text: 'CeraVe Hydrating Facial Cleanser' },
                { img: 'https://www.laroche-posay.com.my/-/media/project/loreal/brand-sites/lrp/apac/my/products/toleriane/caring-wash/la-roche-posay-productpage-sensitive-allergic-toleriane-caring-wash-400ml-3337875545778-front.png?cx=0&amp;ch=600&amp;cy=0&amp;cw=600&hash=3342295D7647E9CBC13AE59681C05688', text: 'La Roche-Posay Toleriane Purifying Foaming Cleanser' },
                { img: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPfex0l05PS7tQlQbFya0IaMOVuRSBhRU6EQ&s', text: 'Fresh Soy Face Cleanser' },
                { img: 'https://www.kiehls.com.my/dw/image/v2/BFZM_PRD/on/demandware.static/-/Sites-kiehls-master-catalog/default/dw9ab9a786/nextgen/skin-care/face-cleansers/ultra-facial/ultra-facial-cleanser/kiehls-face-cleanser-ultra-facial-cleanser-150ml-000-3605970024192-front.jpg?sw=320&sh=320&sm=cut&sfrm=png&q=70', text: 'Kiehls Ultra Facial Cleanser' },
                { img: 'https://shop.shiseido.com.my/cdn/shop/files/14529_S_2_1000x.jpg?v=1735660887', text: 'Shiseido Perfect Whip Cleansing Foam' }
            ],
            st_aa: [
                { img: 'https://via.placeholder.com/400x300?text=For+Him+1', text: 'Smart Watches' },
                { img: 'https://via.placeholder.com/400x300?text=For+Him+2', text: 'Sleek Wallets' }
            ],
            st_wn: [
                { img: 'https://via.placeholder.com/400x300?text=For+Kids+1', text: 'Cute Toys' },
                { img: 'https://via.placeholder.com/400x300?text=For+Kids+2', text: 'Fun Clothes' }
            ],
            st_ss: [
                { img: 'https://via.placeholder.com/400x300?text=Newborn+1', text: 'Soft Blankets' },
                { img: 'https://via.placeholder.com/400x300?text=Newborn+2', text: 'Baby Essentials' }
            ],
            st_dc: [
                { img: 'https://via.placeholder.com/400x300?text=Newborn+1', text: 'Soft Blankets' },
                { img: 'https://via.placeholder.com/400x300?text=Newborn+2', text: 'Baby Essentials' }
            ]
        };

        const allData = {
            ...sc,
            ...mu,
            ...bc,
            ...hc,
            ...bt,
            ...st,

        };

        if (allData[category]) {
            allData[category].forEach(item => {
                const div = document.createElement('div');
                div.className = 'card';
                div.innerHTML = `
          <img src="${item.img}" alt="${item.text}">
          <p>${item.text}</p>
        `;
                content.appendChild(div);
            });
        }


    }
</script>


