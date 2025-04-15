CREATE OR REPLACE PROCEDURE initUser()
AS
$BODY$
DECLARE
    account_id integer;
BEGIN
    INSERT INTO account(created_at)
    VALUES (CURRENT_TIMESTAMP)
    RETURNING id INTO account_id;

    INSERT INTO user_account(id, username, email, password)
    VALUES (account_id, 'admin', 'admin@example.com',
            '$argon2id$v=19$m=66536,t=2,p=1$24Q+2G3xwbAPVZjl6oNMtQ$2NyFDc5R7+g16oYZZxukOP6EMjqcxous5qKbMlGJpmw')
    ON CONFLICT DO NOTHING;
    -- password is: "Password" (excluding quotes)

    INSERT INTO user_account_roles(user_account_id, roles)
    VALUES (account_id, 'ADMIN')
    ON CONFLICT DO NOTHING;

END;
$BODY$
    LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE initCategory()
AS
$BODY$
BEGIN
    WITH category_id AS (
        INSERT INTO category (name, description, image_url)
            VALUES ('Skincare', '',
                    'https://cdn.shopify.com/s/files/1/0070/7032/files/how-to-start-a-skincare-line-glow-oasis.jpg?v=1666895341')
            ON CONFLICT DO NOTHING
            RETURNING id),
         sub1_id AS (
             INSERT INTO category (name, description, image_url, parent_id)
                 VALUES ('Cleansing', '', '', (SELECT id FROM category_id))
                 ON CONFLICT DO NOTHING
                 RETURNING id),
         sub2_id AS (
             INSERT INTO category (name, description, image_url, parent_id)
                 VALUES ('Toning', '', '', (SELECT id FROM category_id))
                 ON CONFLICT DO NOTHING
                 RETURNING id),
         sub3_id AS (
             INSERT INTO category (name, description, image_url, parent_id)
                 VALUES ('Moisturizing', '', '', (SELECT id FROM category_id))
                 ON CONFLICT DO NOTHING
                 RETURNING id),
         sub4_id AS (
             INSERT INTO category (name, description, image_url, parent_id)
                 VALUES ('Serum & Treatments', '', '', (SELECT id FROM category_id))
                 ON CONFLICT DO NOTHING
                 RETURNING id),
         sub5_id AS (
             INSERT INTO category (name, description, image_url, parent_id)
                 VALUES ('Eye Care', '', '', (SELECT id FROM category_id))
                 ON CONFLICT DO NOTHING
                 RETURNING id),
         sub6_id AS (
             INSERT INTO category (name, description, image_url, parent_id)
                 VALUES ('Sun Protection', '', '', (SELECT id FROM category_id))
                 ON CONFLICT DO NOTHING
                 RETURNING id),
         sub7_id AS (
             INSERT INTO category (name, description, image_url, parent_id)
                 VALUES ('Special Treatments', '', '', (SELECT id FROM category_id))
                 ON CONFLICT DO NOTHING
                 RETURNING id),
         sub8_id AS (
             INSERT INTO category (name, description, image_url, parent_id)
                 VALUES ('Repair & Recovery', '', '', (SELECT id FROM category_id))
                 ON CONFLICT DO NOTHING
                 RETURNING id)
    INSERT
    INTO category(name, description, image_url, parent_id)
    VALUES ('Facial Cleanser', '', '', (SELECT id FROM sub1_id)),
           ('Cleansing Oil', '', '', (SELECT id FROM sub1_id)),
           ('Micellar Water', '', '', (SELECT id FROM sub1_id)),
           ('Cleansing Foam', '', '', (SELECT id FROM sub1_id)),
           ('Toner', '', '', (SELECT id FROM sub2_id)),
           ('Facial Mist', '', '', (SELECT id FROM sub2_id)),
           ('Essence Water', '', '', (SELECT id FROM sub2_id)),
           ('Lotion', '', '', (SELECT id FROM sub3_id)),
           ('Face Cream', '', '', (SELECT id FROM sub3_id)),
           ('Gel', '', '', (SELECT id FROM sub3_id)),
           ('Brightening Serum', '', '', (SELECT id FROM sub4_id)),
           ('Anti-aging Serum', '', '', (SELECT id FROM sub4_id)),
           ('Repairing Serum', '', '', (SELECT id FROM sub4_id)),
           ('Eye Cream', '', '', (SELECT id FROM sub5_id)),
           ('Eye Serum', '', '', (SELECT id FROM sub5_id)),
           ('Sunscreen', '', '', (SELECT id FROM sub6_id)),
           ('Sunblock Spray', '', '', (SELECT id FROM sub6_id)),
           ('Acne Treatment', '', '', (SELECT id FROM sub7_id)),
           ('Exfoliators', '', '', (SELECT id FROM sub7_id)),
           ('Sheet Masks', '', '', (SELECT id FROM sub7_id)),
           ('Clay Masks', '', '', (SELECT id FROM sub7_id)),
           ('Peel-off Masks', '', '', (SELECT id FROM sub7_id)),
           ('After-Sun Repair', '', '', (SELECT id FROM sub8_id)),
           ('Sensitive Skin Repair', '', '', (SELECT id FROM sub8_id))
    ON CONFLICT DO NOTHING;

    WITH category_id AS (
        INSERT INTO category (name, description, image_url)
            VALUES ('Makeup', '',
                    'https://t4.ftcdn.net/jpg/02/73/55/33/360_F_273553300_sBBxIPpLSn5iC5vC8FwzFh6BJDKvUeaC.jpg')
            ON CONFLICT DO NOTHING
            RETURNING id),
         sub1_id AS (
             INSERT INTO category (name, description, image_url, parent_id)
                 VALUES ('Base Makeup', '', '', (SELECT id FROM category_id))
                 ON CONFLICT DO NOTHING
                 RETURNING id),
         sub2_id AS (
             INSERT INTO category (name, description, image_url, parent_id)
                 VALUES ('Eye Makeup', '', '', (SELECT id FROM category_id))
                 ON CONFLICT DO NOTHING
                 RETURNING id),
         sub3_id AS (
             INSERT INTO category (name, description, image_url, parent_id)
                 VALUES ('Lip Makeup', '', '', (SELECT id FROM category_id))
                 ON CONFLICT DO NOTHING
                 RETURNING id),
         sub4_id AS (
             INSERT INTO category (name, description, image_url, parent_id)
                 VALUES ('Blush & Contourin', '', '', (SELECT id FROM category_id))
                 ON CONFLICT DO NOTHING
                 RETURNING id),
         sub5_id AS (
             INSERT INTO category (name, description, image_url, parent_id)
                 VALUES ('Setting Makeup', '', '', (SELECT id FROM category_id))
                 ON CONFLICT DO NOTHING
                 RETURNING id)
    INSERT
    INTO category(name, description, image_url, parent_id)
    VALUES ('Foundation', '', '', (SELECT id FROM sub1_id)),
           ('BB Cream', '', '', (SELECT id FROM sub1_id)),
           ('Cushion Compact', '', '', (SELECT id FROM sub1_id)),
           ('Concealer', '', '', (SELECT id FROM sub1_id)),
           ('Setting Powder', '', '', (SELECT id FROM sub1_id)),
           ('Eyeshadow', '', '', (SELECT id FROM sub2_id)),
           ('Eyeliner', '', '', (SELECT id FROM sub2_id)),
           ('Mascara', '', '', (SELECT id FROM sub2_id)),
           ('Eyebrow Pencil', '', '', (SELECT id FROM sub2_id)),
           ('Lipstick', '', '', (SELECT id FROM sub3_id)),
           ('Lip Gloss', '', '', (SELECT id FROM sub3_id)),
           ('Lip Balm', '', '', (SELECT id FROM sub3_id)),
           ('Lip Liner', '', '', (SELECT id FROM sub3_id)),
           ('Blush', '', '', (SELECT id FROM sub4_id)),
           ('Contour Powder', '', '', (SELECT id FROM sub4_id)),
           ('Highlighter', '', '', (SELECT id FROM sub4_id)),
           ('Nose Shadow', '', '', (SELECT id FROM sub4_id)),
           ('Setting Spray', '', '', (SELECT id FROM sub5_id)),
           ('Oil-Control Powder', '', '', (SELECT id FROM sub5_id))
    ON CONFLICT DO NOTHING;

    WITH category_id AS (
        INSERT INTO category (name, description, image_url)
            VALUES ('Body Care', '',
                    'https://www.everkindnz.com/cdn/shop/files/everkind-bodycare-that-is-caring-by-nature-mobile-hero-home-page-white-roses-double-compressed-1024px_1600x.jpg?v=1711690743')
            ON CONFLICT DO NOTHING
            RETURNING id),
         sub1_id AS (
             INSERT INTO category (name, description, image_url, parent_id)
                 VALUES ('Body Cleansing', '', '', (SELECT id FROM category_id))
                 ON CONFLICT DO NOTHING
                 RETURNING id),
         sub2_id AS (
             INSERT INTO category (name, description, image_url, parent_id)
                 VALUES ('Moisturizing', '', '', (SELECT id FROM category_id))
                 ON CONFLICT DO NOTHING
                 RETURNING id),
         sub3_id AS (
             INSERT INTO category (name, description, image_url, parent_id)
                 VALUES ('Fragrance', '', '', (SELECT id FROM category_id))
                 ON CONFLICT DO NOTHING
                 RETURNING id),
         sub4_id AS (
             INSERT INTO category (name, description, image_url, parent_id)
                 VALUES ('Hair Removal', '', '', (SELECT id FROM category_id))
                 ON CONFLICT DO NOTHING
                 RETURNING id),
         sub5_id AS (
             INSERT INTO category (name, description, image_url, parent_id)
                 VALUES ('Whitening & Acne Treatment', '', '', (SELECT id FROM category_id))
                 ON CONFLICT DO NOTHING
                 RETURNING id)
    INSERT
    INTO category(name, description, image_url, parent_id)
    VALUES ('Body Wash', '', '', (SELECT id FROM sub1_id)),
           ('Soap', '', '', (SELECT id FROM sub1_id)),
           ('Body Scrub', '', '', (SELECT id FROM sub1_id)),
           ('Body Lotion', '', '', (SELECT id FROM sub2_id)),
           ('Hand Cream', '', '', (SELECT id FROM sub2_id)),
           ('Body Oil', '', '', (SELECT id FROM sub2_id)),
           ('Perfume', '', '', (SELECT id FROM sub3_id)),
           ('Body Mist', '', '', (SELECT id FROM sub3_id)),
           ('Hair Removal Cream', '', '', (SELECT id FROM sub4_id)),
           ('Razor', '', '', (SELECT id FROM sub4_id)),
           ('Body Whitening Lotion', '', '', (SELECT id FROM sub5_id)),
           ('Back Acne Spray', '', '', (SELECT id FROM sub5_id))
    ON CONFLICT DO NOTHING;

    WITH category_id AS (
        INSERT INTO category (name, description, image_url)
            VALUES ('Hair Care', '',
                    'https://hourshaircare.com/cdn/shop/files/find_your_ritual_img.jpg?v=1712143676')
            ON CONFLICT DO NOTHING
            RETURNING id),
         sub1_id AS (
             INSERT INTO category (name, description, image_url, parent_id)
                 VALUES ('Shampoo & Conditioner', '', '', (SELECT id FROM category_id))
                 ON CONFLICT DO NOTHING
                 RETURNING id),
         sub2_id AS (
             INSERT INTO category (name, description, image_url, parent_id)
                 VALUES ('Hair Treatment', '', '', (SELECT id FROM category_id))
                 ON CONFLICT DO NOTHING
                 RETURNING id),
         sub3_id AS (
             INSERT INTO category (name, description, image_url, parent_id)
                 VALUES ('Styling', '', '', (SELECT id FROM category_id))
                 ON CONFLICT DO NOTHING
                 RETURNING id),
         sub4_id AS (
             INSERT INTO category (name, description, image_url, parent_id)
                 VALUES ('Hair Coloring', '', '', (SELECT id FROM category_id))
                 ON CONFLICT DO NOTHING
                 RETURNING id)
    INSERT
    INTO category(name, description, image_url, parent_id)
    VALUES ('Shampoo', '', '', (SELECT id FROM sub1_id)),
           ('Conditioner', '', '', (SELECT id FROM sub1_id)),
           ('Hair Mask', '', '', (SELECT id FROM sub2_id)),
           ('Hair Oil', '', '', (SELECT id FROM sub2_id)),
           ('Scalp Care Serum', '', '', (SELECT id FROM sub2_id)),
           ('Hair Spray', '', '', (SELECT id FROM sub3_id)),
           ('Hair Wax', '', '', (SELECT id FROM sub3_id)),
           ('Curling Mousse', '', '', (SELECT id FROM sub3_id)),
           ('Hair Straightening Cream', '', '', (SELECT id FROM sub3_id)),
           ('Hair Dye', '', '', (SELECT id FROM sub4_id)),
           ('Bleach', '', '', (SELECT id FROM sub4_id))
    ON CONFLICT DO NOTHING;


    WITH category_id AS (
        INSERT INTO category (name, description, image_url)
            VALUES ('Beauty Tools & Devices', '',
                    'https://img.freepik.com/free-photo/top-view-still-life-assortment-nail-care-products_23-2148974551.jpg')
            ON CONFLICT DO NOTHING
            RETURNING id),
         sub1_id AS (
             INSERT INTO category (name, description, image_url, parent_id)
                 VALUES ('Makeup Tools', '', '', (SELECT id FROM category_id))
                 ON CONFLICT DO NOTHING
                 RETURNING id),
         sub2_id AS (
             INSERT INTO category (name, description, image_url, parent_id)
                 VALUES ('Skincare Devices', '', '', (SELECT id FROM category_id))
                 ON CONFLICT DO NOTHING
                 RETURNING id),
         sub3_id AS (
             INSERT INTO category (name, description, image_url, parent_id)
                 VALUES ('Hair Removal Devices', '', '', (SELECT id FROM category_id))
                 ON CONFLICT DO NOTHING
                 RETURNING id),
         sub4_id AS (
             INSERT INTO category (name, description, image_url, parent_id)
                 VALUES ('Massage Tools', '', '', (SELECT id FROM category_id))
                 ON CONFLICT DO NOTHING
                 RETURNING id),
         sub5_id AS (
             INSERT INTO category (name, description, image_url, parent_id)
                 VALUES ('Nail Care Tools', '', '', (SELECT id FROM category_id))
                 ON CONFLICT DO NOTHING
                 RETURNING id)
    INSERT
    INTO category(name, description, image_url, parent_id)
    VALUES ('Makeup Brushes', '', '', (SELECT id FROM sub1_id)),
           ('Beauty Sponge', '', '', (SELECT id FROM sub1_id)),
           ('Powder Puff', '', '', (SELECT id FROM sub1_id)),
           ('Eyelash Curler', '', '', (SELECT id FROM sub1_id)),
           ('Facial Cleansing Brush', '', '', (SELECT id FROM sub2_id)),
           ('Facial Steamer', '', '', (SELECT id FROM sub2_id)),
           ('LED Beauty Device', '', '', (SELECT id FROM sub2_id)),
           ('Home-use Hair Removal Device', '', '', (SELECT id FROM sub3_id)),
           ('Razor', '', '', (SELECT id FROM sub3_id)),
           ('Face Slimming Device', '', '', (SELECT id FROM sub4_id)),
           ('Roller Massager', '', '', (SELECT id FROM sub4_id)),
           ('Gua Sha Tool', '', '', (SELECT id FROM sub4_id)),
           ('Nail Polish', '', '', (SELECT id FROM sub5_id)),
           ('Nail Lamp', '', '', (SELECT id FROM sub5_id)),
           ('Manicure Set', '', '', (SELECT id FROM sub5_id))
    ON CONFLICT DO NOTHING;


    WITH category_id AS (
        INSERT INTO category (name, description, image_url)
            VALUES ('Special Treatment', '',
                    'https://cdn.prod.website-files.com/63ee8aa635ba278b3ee2d76a/66b0d9d9b17b539efeca321f_66b0d98d0bd07e791ead732b_3.jpeg')
            ON CONFLICT DO NOTHING
            RETURNING id),
         sub1_id AS (
             INSERT INTO category (name, description, image_url, parent_id)
                 VALUES ('Acne Treatment', '', '', (SELECT id FROM category_id))
                 ON CONFLICT DO NOTHING
                 RETURNING id),
         sub2_id AS (
             INSERT INTO category (name, description, image_url, parent_id)
                 VALUES ('Anti-Aging', '', '', (SELECT id FROM category_id))
                 ON CONFLICT DO NOTHING
                 RETURNING id),
         sub3_id AS (
             INSERT INTO category (name, description, image_url, parent_id)
                 VALUES ('Whitening', '', '', (SELECT id FROM category_id))
                 ON CONFLICT DO NOTHING
                 RETURNING id),
         sub4_id AS (
             INSERT INTO category (name, description, image_url, parent_id)
                 VALUES ('Sensitive Skin Repair', '', '', (SELECT id FROM category_id))
                 ON CONFLICT DO NOTHING
                 RETURNING id),
         sub5_id AS (
             INSERT INTO category (name, description, image_url, parent_id)
                 VALUES ('Dark Circle Treatment', '', '', (SELECT id FROM category_id))
                 ON CONFLICT DO NOTHING
                 RETURNING id)
    INSERT
    INTO category(name, description, image_url, parent_id)
    VALUES ('Acne Gel', '', '', (SELECT id FROM sub1_id)),
           ('Pimple Patch', '', '', (SELECT id FROM sub1_id)),
           ('Anti-wrinkle Serum', '', '', (SELECT id FROM sub2_id)),
           ('Firming Cream', '', '', (SELECT id FROM sub2_id)),
           ('Brightening Serum', '', '', (SELECT id FROM sub3_id)),
           ('Dark Spot Corrector', '', '', (SELECT id FROM sub3_id)),
           ('Soothing Repair Cream', '', '', (SELECT id FROM sub4_id)),
           ('Sensitive Skin Protection Cream', '', '', (SELECT id FROM sub4_id)),
           ('Eye Mask', '', '', (SELECT id FROM sub5_id)),
           ('Eye Serum', '', '', (SELECT id FROM sub5_id))
    ON CONFLICT DO NOTHING;
END;
$BODY$
    LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE initProduct()
AS
$BODY$
BEGIN
    INSERT INTO product(name, description, brand, unit_price, unit_cost, release_date, category_id, stock_count)
    VALUES ('CeraVe Hydrating Facial Cleanser', 'Gentle cleanser with ceramides & hyaluronic acid.', 'CeraVe', '18.99', '7.68', '2023-05-10', (SELECT id FROM category WHERE name = 'Facial Cleanser'), random(1, 20)),
            ('La Roche-Posay Toleriane Purifying Foaming Cleanser', 'Soap-free cleanser for sensitive skin.', 'La Roche-Posay', '22.50', '12.74', '2023-07-18', (SELECT id FROM category WHERE name = 'Facial Cleanser'), random(1, 20)),
            ('Fresh Soy Face Cleanser', 'pH-balanced facial cleanser with amino acids.', 'Fresh', '27.00', '16.06', '2023-09-02', (SELECT id FROM category WHERE name = 'Facial Cleanser'), random(1, 20)),
            ('Kiehl’s Ultra Facial Cleanser', 'Mild foaming cleanser with squalane.', 'Kiehl’s', '32.99', '18.55', '2023-10-25', (SELECT id FROM category WHERE name = 'Facial Cleanser'), random(1, 20)),
            ('Shiseido Perfect Whip Cleansing Foam', 'Rich foaming cleanser for deep cleansing.', 'Shiseido', '38.00', '21.64', '2023-12-08', (SELECT id FROM category WHERE name = 'Facial Cleanser'), random(1, 20)),
            ('DHC Deep Cleansing Oil', 'Olive oil-based cleansing oil for waterproof makeup.', 'DHC', '20.99', '13.49', '2023-06-05', (SELECT id FROM category WHERE name = 'Cleansing Oil'), random(1, 20)),
            ('Shu Uemura Ultime8∞ Sublime Beauty Cleansing Oil', 'Luxurious oil cleanser with 8 botanical oils.', 'Shu Uemura', '25.00', '17.07', '2023-08-15', (SELECT id FROM category WHERE name = 'Cleansing Oil'), random(1, 20)),
            ('Kose Softymo Speedy Cleansing Oil', 'Lightweight cleansing oil for quick removal.', 'Kose', '30.50', '18.58', '2023-09-30', (SELECT id FROM category WHERE name = 'Cleansing Oil'), random(1, 20)),
            ('Tatcha Pure One Step Camellia Cleansing Oil', 'Japanese camellia oil-infused facial cleanser.', 'Tatcha', '36.99', '16.90', '2023-11-12', (SELECT id FROM category WHERE name = 'Cleansing Oil'), random(1, 20)),
            ('Hada Labo Gokujyun Cleansing Oil', 'Deep hydration cleansing oil with hyaluronic acid.', 'Hada Labo', '42.00', '22.94', '2024-01-05', (SELECT id FROM category WHERE name = 'Cleansing Oil'), random(1, 20)),
            ('Bioderma Sensibio H2O Micellar Water', 'Gentle micellar water for sensitive skin.', 'Bioderma', '15.99', '8.25', '2023-05-22', (SELECT id FROM category WHERE name = 'Micellar Water'), random(1, 20)),
            ('Garnier SkinActive Micellar Cleansing Water', 'Removes makeup & dirt in one step.', 'Garnier', '19.50', '7.92', '2023-07-10', (SELECT id FROM category WHERE name = 'Micellar Water'), random(1, 20)),
            ('Simple Kind to Skin Micellar Cleansing Water', 'Fragrance-free micellar water for sensitive skin.', 'Simple', '23.00', '13.35', '2023-09-05', (SELECT id FROM category WHERE name = 'Micellar Water'), random(1, 20)),
            ('La Roche-Posay Micellar Cleansing Water', 'Micellar water with thermal spring water.', 'La Roche-Posay', '28.99', '17.73', '2023-10-20', (SELECT id FROM category WHERE name = 'Micellar Water'), random(1, 20)),
            ('Caudalie Vinoclean Micellar Cleansing Water', 'Gentle micellar water with organic grape water.', 'Caudalie', '34.00', '20.72', '2023-12-02', (SELECT id FROM category WHERE name = 'Micellar Water'), random(1, 20)),
            ('Innisfree Jeju Volcanic Pore Cleansing Foam', 'Deep pore cleansing foam with volcanic clusters.', 'Innisfree', '17.99', '17.99', '2023-06-12', (SELECT id FROM category WHERE name = 'Cleansing Foam'), random(1, 20)),
            ('Etude House Baking Powder Pore Cleansing Foam', 'Micro-baking powder for deep pore cleansing.', 'Etude House', '21.50', '11.94', '2023-08-22', (SELECT id FROM category WHERE name = 'Cleansing Foam'), random(1, 20)),
            ('Sulwhasoo Gentle Cleansing Foam', 'Herbal-infused foam cleanser for smooth skin.', 'Sulwhasoo', '26.00', '12.64', '2023-09-28', (SELECT id FROM category WHERE name = 'Cleansing Foam'), random(1, 20)),
            ('Dr. Jart+ Dermaclear Micro Foam', 'Oxygenating cleanser with hydrogen water.', 'Dr. Jart+', '30.99', '20.13', '2023-11-18', (SELECT id FROM category WHERE name = 'Cleansing Foam'), random(1, 20)),
            ('AmorePacific Treatment Cleansing Foam', 'Rich, hydrating cleansing foam with botanical extracts.', 'AmorePacific', '37.00', '24.63', '2024-01-10', (SELECT id FROM category WHERE name = 'Cleansing Foam'), random(1, 20)),
            ('Thayers Witch Hazel Toner', 'Alcohol-free toner with rose water.', 'Thayers', '19.99', '12.82', '2023-05-15', (SELECT id FROM category WHERE name = 'Toner'), random(1, 20)),
            ('Kiehl’s Calendula Herbal Extract Toner', 'Soothing toner with calendula petals.', 'Kiehl’s', '24.50', '11.67', '2023-07-03', (SELECT id FROM category WHERE name = 'Toner'), random(1, 20)),
            ('SK-II Facial Treatment Clear Lotion', 'Clarifying toner with Pitera essence.', 'SK-II', '29.00', '15.85', '2023-08-21', (SELECT id FROM category WHERE name = 'Toner'), random(1, 20)),
            ('La Roche-Posay Effaclar Clarifying Solution', 'Acne-fighting toner with salicylic acid.', 'La Roche-Posay', '34.99', '24.31', '2023-10-07', (SELECT id FROM category WHERE name = 'Toner'), random(1, 20)),
            ('Pixi Glow Tonic', 'Exfoliating toner with glycolic acid.', 'Pixi', '39.99', '20.96', '2023-12-01', (SELECT id FROM category WHERE name = 'Toner'), random(1, 20)),
            ('Evian Facial Spray', 'Hydrating mineral water mist.', 'Evian', '16.99', '7.58', '2023-05-28', (SELECT id FROM category WHERE name = 'Facial Mist'), random(1, 20)),
            ('Caudalie Grape Water Mist', 'Refreshing organic grape water spray.', 'Caudalie', '20.50', '11.93', '2023-07-12', (SELECT id FROM category WHERE name = 'Facial Mist'), random(1, 20)),
            ('Heritage Store Rosewater & Glycerin Spray', 'Hydrating rosewater facial mist.', 'Heritage Store', '25.00', '17.11', '2023-09-10', (SELECT id FROM category WHERE name = 'Facial Mist'), random(1, 20)),
            ('Mario Badescu Facial Spray', 'Aloe, herbs & rosewater mist for hydration.', 'Mario Badescu', '30.99', '15.34', '2023-10-29', (SELECT id FROM category WHERE name = 'Facial Mist'), random(1, 20)),
            ('Tatcha Luminous Dewy Skin Mist', 'Ultra-fine mist for glowing skin.', 'Tatcha', '35.50', '22.27', '2023-12-15', (SELECT id FROM category WHERE name = 'Facial Mist'), random(1, 20)),
            ('SK-II Facial Treatment Essence', 'Hydrating essence with Pitera.', 'SK-II', '21.99', '9.36', '2023-06-10', (SELECT id FROM category WHERE name = 'Essence Water'), random(1, 20)),
            ('Missha Time Revolution First Treatment Essence', 'Brightening & hydrating essence.', 'Missha', '26.50', '11.64', '2023-08-05', (SELECT id FROM category WHERE name = 'Essence Water'), random(1, 20)),
            ('IOPE Bio Essence Intensive Conditioning', 'Korean essence with fermented ingredients.', 'IOPE', '31.00', '13.07', '2023-09-22', (SELECT id FROM category WHERE name = 'Essence Water'), random(1, 20)),
            ('Sulwhasoo First Care Activating Serum', 'Traditional herbal essence for nourishment.', 'Sulwhasoo', '37.99', '16.21', '2023-11-10', (SELECT id FROM category WHERE name = 'Essence Water'), random(1, 20)),
            ('Laneige Water Bank Hydro Essence', 'Deep hydration essence for plump skin.', 'Laneige', '42.50', '27.04', '2024-01-05', (SELECT id FROM category WHERE name = 'Essence Water'), random(1, 20)),
            ('CeraVe Daily Moisturizing Lotion', 'Lightweight lotion with ceramides & hyaluronic acid.', 'CeraVe', '18.99', '11.25', '2023-05-20', (SELECT id FROM category WHERE name = 'Lotion'), random(1, 20)),
            ('Aveeno Daily Moisturizing Lotion', 'Oat-based lotion for hydration.', 'Aveeno', '22.50', '10.83', '2023-07-08', (SELECT id FROM category WHERE name = 'Lotion'), random(1, 20)),
            ('Eucerin Advanced Repair Lotion', 'Intensive repair lotion for dry skin.', 'Eucerin', '27.00', '17.15', '2023-09-02', (SELECT id FROM category WHERE name = 'Lotion'), random(1, 20)),
            ('NIVEA Essentially Enriched Lotion', 'Deep moisture lotion with almond oil.', 'NIVEA', '31.99', '18.35', '2023-10-18', (SELECT id FROM category WHERE name = 'Lotion'), random(1, 20)),
            ('Vaseline Intensive Care Lotion', 'Fast-absorbing lotion for soft skin.', 'Vaseline', '36.50', '21.48', '2023-12-10', (SELECT id FROM category WHERE name = 'Lotion'), random(1, 20)),
            ('Kiehl’s Ultra Facial Cream', '24-hour hydration face cream.', 'Kiehl’s', '24.99', '17.33', '2023-05-30', (SELECT id FROM category WHERE name = 'Face Cream'), random(1, 20)),
            ('La Mer Crème de la Mer', 'Luxury moisturizing cream with Miracle Broth™.', 'La Mer', '29.50', '11.81', '2023-07-15', (SELECT id FROM category WHERE name = 'Face Cream'), random(1, 20)),
            ('Drunk Elephant Lala Retro Whipped Cream', 'Whipped texture face cream with six oils.', 'Drunk Elephant', '33.99', '22.98', '2023-09-12', (SELECT id FROM category WHERE name = 'Face Cream'), random(1, 20)),
            ('Olay Regenerist Micro-Sculpting Cream', 'Anti-aging face cream with peptides.', 'Olay', '38.50', '24.84', '2023-10-25', (SELECT id FROM category WHERE name = 'Face Cream'), random(1, 20)),
            ('Tatcha The Dewy Skin Cream', 'Rich cream for dewy, plump skin.', 'Tatcha', '42.99', '18.17', '2023-12-18', (SELECT id FROM category WHERE name = 'Face Cream'), random(1, 20)),
            ('Neutrogena Hydro Boost Water Gel', 'Lightweight gel with hyaluronic acid.', 'Neutrogena', '19.50', '10.56', '2023-06-10', (SELECT id FROM category WHERE name = 'Gel'), random(1, 20)),
            ('Belif The True Cream Aqua Bomb', 'Cooling gel moisturizer for hydration.', 'Belif', '23.99', '12.08', '2023-08-02', (SELECT id FROM category WHERE name = 'Gel'), random(1, 20)),
            ('Clinique Moisture Surge 100H', 'Gel-cream for long-lasting hydration.', 'Clinique', '28.50', '17.61', '2023-09-20', (SELECT id FROM category WHERE name = 'Gel'), random(1, 20)),
            ('Laneige Water Bank Blue Hyaluronic Gel', 'Deep moisture gel with blue hyaluronic acid.', 'Laneige', '32.99', '14.53', '2023-11-15', (SELECT id FROM category WHERE name = 'Gel'), random(1, 20)),
            ('Dr.Jart+ Cicapair Tiger Grass Gel Cream', 'Soothing gel cream for sensitive skin.', 'Dr.Jart+', '37.50', '22.98', '2024-01-05', (SELECT id FROM category WHERE name = 'Gel'), random(1, 20)),
            ('Ole Henriksen Truth Serum', 'Vitamin C serum for brightening & firming.', 'Ole Henriksen', '32.99', '17.66', '2023-05-20', (SELECT id FROM category WHERE name = 'Brightening Serum'), random(1, 20)),
            ('Skinceuticals C E Ferulic', 'Advanced brightening serum with antioxidants.', 'Skinceuticals', '45.50', '28.37', '2023-07-08', (SELECT id FROM category WHERE name = 'Brightening Serum'), random(1, 20)),
            ('Glow Recipe Pineapple-C Bright Serum', 'Pineapple extract brightening serum.', 'Glow Recipe', '39.99', '23.28', '2023-09-02', (SELECT id FROM category WHERE name = 'Brightening Serum'), random(1, 20)),
            ('Tatcha Violet-C Brightening Serum', 'Japanese beauty serum with vitamin C.', 'Tatcha', '50.99', '24.03', '2023-10-12', (SELECT id FROM category WHERE name = 'Brightening Serum'), random(1, 20)),
            ('Drunk Elephant C-Firma Fresh Day Serum', 'Brightening serum with vitamin C & ferulic acid.', 'Drunk Elephant', '41.50', '25.94', '2023-11-25', (SELECT id FROM category WHERE name = 'Brightening Serum'), random(1, 20)),
            ('Estée Lauder Advanced Night Repair', 'Anti-aging serum for youthful skin.', 'Estée Lauder', '55.00', '26.08', '2023-05-30', (SELECT id FROM category WHERE name = 'Anti-aging Serum'), random(1, 20)),
            ('Lancôme Génifique Youth Activating Serum', 'Probiotic extract anti-aging serum.', 'Lancôme', '62.50', '33.92', '2023-07-15', (SELECT id FROM category WHERE name = 'Anti-aging Serum'), random(1, 20)),
            ('Drunk Elephant A-Passioni Retinol Cream', 'Retinol-based anti-aging treatment.', 'Drunk Elephant', '49.99', '23.89', '2023-09-12', (SELECT id FROM category WHERE name = 'Anti-aging Serum'), random(1, 20)),
            ('Sunday Riley Luna Retinol Sleeping Night Oil', 'Blue tansy & retinol for anti-aging.', 'Sunday Riley', '69.99', '36.37', '2023-10-20', (SELECT id FROM category WHERE name = 'Anti-aging Serum'), random(1, 20)),
            ('Murad Retinol Youth Renewal Serum', 'Anti-aging serum with retinol & peptides.', 'Murad', '58.75', '32.27', '2023-12-01', (SELECT id FROM category WHERE name = 'Anti-aging Serum'), random(1, 20)),
            ('Kiehl''s Midnight Recovery Concentrate', 'Nighttime facial oil for skin repair.', 'Kiehl''s', '42.99', '25.62', '2023-06-10', (SELECT id FROM category WHERE name = 'Repairing Serum'), random(1, 20)),
            ('La Roche-Posay Cicaplast B5 Serum', 'Soothing & repairing serum for sensitive skin.', 'La Roche-Posay', '47.50', '28.56', '2023-08-02', (SELECT id FROM category WHERE name = 'Repairing Serum'), random(1, 20)),
            ('Clarins Double Serum', 'Intensive anti-aging & repairing treatment.', 'Clarins', '53.00', '33.87', '2023-09-20', (SELECT id FROM category WHERE name = 'Repairing Serum'), random(1, 20)),
            ('The Ordinary Buffet + Copper Peptides 1%', 'Peptide-rich serum for skin repair.', 'The Ordinary', '38.99', '19.70', '2023-10-15', (SELECT id FROM category WHERE name = 'Repairing Serum'), random(1, 20)),
            ('First Aid Beauty Ultra Repair Hydrating Serum', 'Repairing serum for dry & damaged skin.', 'First Aid Beauty', '44.25', '21.94', '2023-11-30', (SELECT id FROM category WHERE name = 'Repairing Serum'), random(1, 20)),
            ('Kiehl''s Creamy Eye Treatment with Avocado', 'Hydrating eye cream with avocado oil.', 'Kiehl''s', '48.99', '23.69', '2023-06-15', (SELECT id FROM category WHERE name = 'Eye Cream'), random(1, 20)),
            ('Estée Lauder Advanced Night Repair Eye Supercharged Gel-Creme', 'Anti-aging eye cream for dark circles.', 'Estée Lauder', '55.25', '29.30', '2023-08-05', (SELECT id FROM category WHERE name = 'Eye Cream'), random(1, 20)),
            ('CeraVe Eye Repair Cream', 'Gentle eye cream for hydration & repair.', 'CeraVe', '39.50', '24.41', '2023-09-10', (SELECT id FROM category WHERE name = 'Eye Cream'), random(1, 20)),
            ('La Mer The Eye Concentrate', 'Luxurious eye cream for wrinkles & dark circles.', 'La Mer', '60.75', '38.99', '2023-10-22', (SELECT id FROM category WHERE name = 'Eye Cream'), random(1, 20)),
            ('Clinique All About Eyes', 'Lightweight eye cream to reduce puffiness.', 'Clinique', '42.99', '24.67', '2023-11-30', (SELECT id FROM category WHERE name = 'Eye Cream'), random(1, 20)),
            ('Shiseido Ultimune Eye Power Infusing Eye Concentrate', 'Strengthening & firming eye serum.', 'Shiseido', '52.00', '30.46', '2023-07-01', (SELECT id FROM category WHERE name = 'Eye Serum'), random(1, 20)),
            ('Lancôme Advanced Génifique Yeux Light-Pearl Eye Serum', 'Brightening & anti-aging eye serum.', 'Lancôme', '58.50', '27.53', '2023-08-20', (SELECT id FROM category WHERE name = 'Eye Serum'), random(1, 20)),
            ('The Ordinary Caffeine Solution 5% + EGCG', 'Depuffing eye serum with caffeine.', 'The Ordinary', '45.99', '27.53', '2023-09-15', (SELECT id FROM category WHERE name = 'Eye Serum'), random(1, 20)),
            ('Tatcha The Silk Peony Melting Eye Cream', 'Anti-aging eye serum with silk extracts.', 'Tatcha', '63.25', '35.91', '2023-10-28', (SELECT id FROM category WHERE name = 'Eye Serum'), random(1, 20)),
            ('Drunk Elephant Shaba Complex Firming Eye Serum', 'Eye serum for wrinkles & hydration.', 'Drunk Elephant', '49.75', '30.05', '2023-12-05', (SELECT id FROM category WHERE name = 'Eye Serum'), random(1, 20)),
            ('SunShield Ultra Sunscreen SPF 50', 'Lightweight, broad-spectrum protection.', 'SunShield', '32.99', '19.20', '2023-05-10', (SELECT id FROM category WHERE name = 'Sunscreen'), random(1, 20)),
            ('Mamaearth Vitamin C Daily Glow Sunscreen for Sun Protection & Glow', 'Hydrating sunscreen with vitamin C.', 'Mamaearth', '35.50', '20.75', '2023-06-15', (SELECT id FROM category WHERE name = 'Sunscreen'), random(1, 20)),
            ('AquaGlow Moisturizing Sunscreen SPF 55', 'Water-resistant sunscreen with aloe vera.', 'AquaGlow', '38.25', '21.90', '2023-07-05', (SELECT id FROM category WHERE name = 'Sunscreen'), random(1, 20)),
            ('DermaCare Advanced Sunscreen SPF 60', 'Dermatologist-recommended, non-comedogenic.', 'DermaCare', '40.99', '23.50', '2023-08-12', (SELECT id FROM category WHERE name = 'Sunscreen'), random(1, 20)),
            ('Neutrogena® Purescreen+™ Mineral UV Tint Face Liquid Sunscreen', '100% mineral-based, suitable for sensitive skin.', 'Neutrogena', '42.75', '25.00', '2023-09-20', (SELECT id FROM category WHERE name = 'Sunscreen'), random(1, 20)),
            ('BreezeMist Sunblock Spray SPF 50', 'Quick-absorbing mist with water resistance.', 'BreezeMist', '39.80', '22.40', '2023-05-25', (SELECT id FROM category WHERE name = 'Sunblock Spray'), random(1, 20)),
            ('CoolWave Sunblock Spray SPF 60', 'Refreshing cooling effect with aloe vera.', 'CoolWave', '45.50', '24.90', '2023-06-30', (SELECT id FROM category WHERE name = 'Sunblock Spray'), random(1, 20)),
            ('UltraDefend Sunblock Spray SPF 55', 'Sweat-proof formula for outdoor activities.', 'UltraDefend', '48.75', '26.75', '2023-07-18', (SELECT id FROM category WHERE name = 'Sunblock Spray'), random(1, 20)),
            ('GlowMist Sunblock Spray SPF 50', 'Lightweight, oil-free mist for daily use.', 'GlowMist', '41.99', '23.25', '2023-08-22', (SELECT id FROM category WHERE name = 'Sunblock Spray'), random(1, 20)),
            ('SunGuard Sport Sunblock Spray SPF 65', 'Long-lasting protection for active lifestyles.', 'SunGuard', '50.25', '28.00', '2023-09-28', (SELECT id FROM category WHERE name = 'Sunblock Spray'), random(1, 20)),
            ('La Roche-Posay Effaclar Duo+', 'Acne treatment with niacinamide & salicylic acid.', 'La Roche-Posay', '29.99', '15.49', '2023-06-10', (SELECT id FROM category WHERE name = 'Acne Treatment'), random(1, 20)),
            ('Paula''s Choice 2% BHA Liquid Exfoliant', 'Salicylic acid acne treatment for blackheads.', 'Paula''s Choice', '34.50', '18.70', '2023-07-15', (SELECT id FROM category WHERE name = 'Acne Treatment'), random(1, 20)),
            ('The Ordinary Niacinamide 10% + Zinc 1%', 'Oil control & acne solution serum.', 'The Ordinary', '12.99', '6.25', '2023-08-20', (SELECT id FROM category WHERE name = 'Acne Treatment'), random(1, 20)),
            ('CeraVe Acne Control Gel', 'Acne gel with AHA/BHA for clearer skin.', 'CeraVe', '24.99', '13.75', '2023-09-05', (SELECT id FROM category WHERE name = 'Acne Treatment'), random(1, 20)),
            ('COSRX AC Collection Acne Patch', 'Hydrocolloid patches for acne healing.', 'COSRX', '8.99', '4.25', '2023-10-18', (SELECT id FROM category WHERE name = 'Acne Treatment'), random(1, 20)),
            ('Drunk Elephant T.L.C. Sukari Babyfacial', 'AHA/BHA exfoliating mask for smooth skin.', 'Drunk Elephant', '68.00', '37.40', '2023-06-25', (SELECT id FROM category WHERE name = 'Exfoliators'), random(1, 20)),
            ('The Ordinary Glycolic Acid 7% Toning Solution', 'Glycolic acid exfoliator for bright skin.', 'The Ordinary', '12.99', '6.75', '2023-07-30', (SELECT id FROM category WHERE name = 'Exfoliators'), random(1, 20)),
            ('Paula''s Choice Skin Perfecting 8% AHA Gel', 'AHA exfoliant for glowing skin.', 'Paula''s Choice', '32.50', '17.99', '2023-08-12', (SELECT id FROM category WHERE name = 'Exfoliators'), random(1, 20)),
            ('Tatcha The Rice Polish Foaming Enzyme Powder', 'Enzyme-based gentle exfoliator.', 'Tatcha', '65.00', '35.25', '2023-09-27', (SELECT id FROM category WHERE name = 'Exfoliators'), random(1, 20)),
            ('Wishful Yo Glow Enzyme Scrub', 'Pineapple & papaya enzyme exfoliator.', 'Huda Beauty', '39.99', '21.99', '2023-11-10', (SELECT id FROM category WHERE name = 'Exfoliators'), random(1, 20)),
            ('Dr.Jart+ Dermask Vital Hydra Solution', 'Hydrating & soothing sheet mask.', 'Dr.Jart+', '6.99', '3.20', '2023-06-05', (SELECT id FROM category WHERE name = 'Sheet Masks'), random(1, 20)),
            ('SK-II Facial Treatment Mask', 'Luxury brightening & firming mask.', 'SK-II', '20.00', '11.50', '2023-07-18', (SELECT id FROM category WHERE name = 'Sheet Masks'), random(1, 20)),
            ('Mediheal N.M.F. Intensive Hydrating Mask', 'Deep hydration sheet mask.', 'Mediheal', '2.99', '1.50', '2023-08-25', (SELECT id FROM category WHERE name = 'Sheet Masks'), random(1, 20)),
            ('Tatcha Luminous Dewy Skin Mask', 'Moisturizing & brightening sheet mask.', 'Tatcha', '12.00', '6.25', '2023-09-12', (SELECT id FROM category WHERE name = 'Sheet Masks'), random(1, 20)),
            ('Innisfree My Real Squeeze Mask', 'Natural ingredient sheet mask.', 'Innisfree', '1.99', '1.00', '2023-10-08', (SELECT id FROM category WHERE name = 'Sheet Masks'), random(1, 20)),
            ('Innisfree Super Volcanic Pore Clay Mask', 'Deep cleansing & oil control.', 'Innisfree', '15.99', '8.75', '2023-06-17', (SELECT id FROM category WHERE name = 'Clay Masks'), random(1, 20)),
            ('Aztec Secret Indian Healing Clay', 'Bentonite clay mask for deep pore cleansing.', 'Aztec Secret', '12.00', '6.99', '2023-07-20', (SELECT id FROM category WHERE name = 'Clay Masks'), random(1, 20)),
            ('GlamGlow SuperMud Clearing Treatment', 'Charcoal-infused clay mask.', 'GlamGlow', '60.00', '34.50', '2023-08-30', (SELECT id FROM category WHERE name = 'Clay Masks'), random(1, 20)),
            ('Fresh Umbrian Clay Purifying Mask', 'Purifying clay mask for oily skin.', 'Fresh', '58.00', '32.99', '2023-09-22', (SELECT id FROM category WHERE name = 'Clay Masks'), random(1, 20)),
            ('Tata Harper Purifying Mask', 'Detoxifying & pore-refining mask.', 'Tata Harper', '72.00', '39.75', '2023-11-03', (SELECT id FROM category WHERE name = 'Clay Masks'), random(1, 20)),
            ('Boscia Luminizing Black Mask', 'Detoxifying & brightening peel-off mask.', 'Boscia', '34.00', '18.75', '2023-06-15', (SELECT id FROM category WHERE name = 'Peel-off Masks'), random(1, 20)),
            ('GlamGlow GravityMud Firming Treatment', 'Peel-off mask for firming skin.', 'GlamGlow', '60.00', '34.99', '2023-07-29', (SELECT id FROM category WHERE name = 'Peel-off Masks'), random(1, 20)),
            ('Freeman Renewing Cucumber Peel-Off Mask', 'Cooling & refreshing face mask.', 'Freeman', '5.99', '3.00', '2023-08-10', (SELECT id FROM category WHERE name = 'Peel-off Masks'), random(1, 20)),
            ('Shills Purifying Black Peel-off Mask', 'Charcoal deep cleansing mask.', 'Shills', '14.50', '7.99', '2023-09-14', (SELECT id FROM category WHERE name = 'Peel-off Masks'), random(1, 20)),
            ('Perricone MD Chlorophyll Detox Mask', 'Detoxifying & anti-aging peel-off mask.', 'Perricone MD', '55.00', '29.25', '2023-10-25', (SELECT id FROM category WHERE name = 'Peel-off Masks'), random(1, 20)),
            ('Bioderma Photoderm After Sun', 'Soothing lotion for sun-exposed skin.', 'Bioderma', '19.99', '10.75', '2023-06-20', (SELECT id FROM category WHERE name = 'After-Sun Repair'), random(1, 20)),
            ('Aloe Vera Gel 100% Pure', 'Hydrating & cooling gel for sunburn relief.', 'Nature Republic', '8.99', '4.50', '2023-07-05', (SELECT id FROM category WHERE name = 'After-Sun Repair'), random(1, 20)),
            ('Lancaster Sun Sensitive After Sun Balm', 'Repairing & moisturizing after-sun balm.', 'Lancaster', '35.00', '18.50', '2023-08-12', (SELECT id FROM category WHERE name = 'After-Sun Repair'), random(1, 20)),
            ('Hawaiian Tropic Silk Hydration After Sun', 'Soothing & hydrating aloe lotion.', 'Hawaiian Tropic', '12.99', '6.99', '2023-09-07', (SELECT id FROM category WHERE name = 'After-Sun Repair'), random(1, 20)),
            ('Clarins After Sun Soothing Balm', 'Anti-aging after-sun care.', 'Clarins', '38.00', '20.99', '2023-10-18', (SELECT id FROM category WHERE name = 'After-Sun Repair'), random(1, 20)),
            ('La Roche-Posay Cicaplast Baume B5', 'Multi-purpose soothing balm for sensitive skin.', 'La Roche-Posay', '16.99', '9.25', '2023-06-22', (SELECT id FROM category WHERE name = 'Sensitive Skin Repair'), random(1, 20)),
            ('Avene Cicalfate+ Restorative Cream', 'Skin recovery cream for irritation & sensitivity.', 'Avene', '28.00', '14.99', '2023-07-14', (SELECT id FROM category WHERE name = 'Sensitive Skin Repair'), random(1, 20)),
            ('Dr.Jart+ Cicapair Tiger Grass Cream', 'Calming cream for redness & sensitivity.', 'Dr.Jart+', '49.00', '26.75', '2023-08-21', (SELECT id FROM category WHERE name = 'Sensitive Skin Repair'), random(1, 20)),
            ('First Aid Beauty Ultra Repair Cream', 'Intense hydration for sensitive skin.', 'First Aid Beauty', '38.00', '20.50', '2023-09-09', (SELECT id FROM category WHERE name = 'Sensitive Skin Repair'), random(1, 20)),
            ('Eucerin Advanced Repair Cream', 'Deep moisturizing cream for sensitive & dry skin.', 'Eucerin', '13.99', '7.50', '2023-10-28', (SELECT id FROM category WHERE name = 'Sensitive Skin Repair'), random(1, 20)),
            ('Estée Lauder Double Wear Stay-in-Place Foundation', 'Long-wear, full-coverage foundation', 'Estée Lauder', '48.00', '24.00', '1997-06-12', (SELECT id FROM category WHERE name = 'Foundation'), random(1, 20)),
            ('Fenty Beauty Pro Filt''r Soft Matte Longwear Foundation', 'Oil-free, soft matte finish foundation', 'Fenty Beauty', '40.00', '20.00', '2017-09-08', (SELECT id FROM category WHERE name = 'Foundation'), random(1, 20)),
            ('Dior Forever Skin Glow Foundation', 'Luminous, hydrating foundation', 'Dior', '55.00', '27.50', '2019-01-10', (SELECT id FROM category WHERE name = 'Foundation'), random(1, 20)),
            ('Maybelline Fit Me Matte + Poreless Foundation', 'Lightweight, mattifying drugstore foundation', 'Maybelline', '8.99', '4.50', '2015-02-05', (SELECT id FROM category WHERE name = 'Foundation'), random(1, 20)),
            ('Giorgio Armani Luminous Silk Foundation', 'Lightweight, radiant finish foundation', 'Giorgio Armani', '69.00', '34.50', '2000-09-20', (SELECT id FROM category WHERE name = 'Foundation'), random(1, 20)),
            ('Missha M Perfect Cover BB Cream SPF 42', 'Korean multi-purpose BB cream with SPF', 'Missha', '22.00', '11.00', '2005-05-15', (SELECT id FROM category WHERE name = 'BB Cream'), random(1, 20)),
            ('Dr. Jart+ Premium Beauty Balm SPF 45', 'Lightweight, skin-care infused BB cream', 'Dr. Jart+', '42.00', '21.00', '2010-07-01', (SELECT id FROM category WHERE name = 'BB Cream'), random(1, 20)),
            ('Erborian BB Crème au Ginseng', 'Korean BB cream with skin-smoothing effect', 'Erborian', '44.00', '22.00', '2018-03-12', (SELECT id FROM category WHERE name = 'BB Cream'), random(1, 20)),
            ('Maybelline Dream Fresh BB Cream', 'Hydrating, sheer-coverage BB cream', 'Maybelline', '8.99', '4.50', '2012-06-28', (SELECT id FROM category WHERE name = 'BB Cream'), random(1, 20)),
            ('Clinique Age Defense BB Cream SPF 30', 'Anti-aging BB cream with SPF', 'Clinique', '39.00', '19.50', '2013-04-18', (SELECT id FROM category WHERE name = 'BB Cream'), random(1, 20)),
            ('LANEIGE Neo Cushion Matte SPF 42', 'Lightweight, matte cushion foundation', 'LANEIGE', '38.00', '19.00', '2020-07-15', (SELECT id FROM category WHERE name = 'Cushion Compact'), random(1, 20)),
            ('YSL Le Cushion Encre de Peau', 'Luxury cushion foundation with a radiant finish', 'YSL', '72.00', '36.00', '2017-10-22', (SELECT id FROM category WHERE name = 'Cushion Compact'), random(1, 20)),
            ('Hera Black Cushion SPF 34', 'High-coverage, semi-matte cushion foundation', 'Hera', '49.00', '24.50', '2018-06-30', (SELECT id FROM category WHERE name = 'Cushion Compact'), random(1, 20)),
            ('Clio Kill Cover Founwear Cushion XP', 'Long-lasting cushion foundation with full coverage', 'Clio', '29.00', '14.50', '2016-08-08', (SELECT id FROM category WHERE name = 'Cushion Compact'), random(1, 20)),
            ('Dior Forever Perfect Cushion SPF 35', 'High-end, glow-enhancing cushion foundation', 'Dior', '65.00', '32.50', '2019-05-01', (SELECT id FROM category WHERE name = 'Cushion Compact'), random(1, 20)),
            ('Tarte Shape Tape Concealer', 'Full-coverage, long-lasting concealer', 'Tarte', '31.00', '15.50', '2016-09-16', (SELECT id FROM category WHERE name = 'Concealer'), random(1, 20)),
            ('NARS Radiant Creamy Concealer', 'Medium-to-full coverage hydrating concealer', 'NARS', '32.00', '16.00', '2013-02-14', (SELECT id FROM category WHERE name = 'Concealer'), random(1, 20)),
            ('Maybelline Instant Age Rewind Concealer', 'Drugstore favorite for brightening under eyes', 'Maybelline', '10.99', '5.50', '2010-05-23', (SELECT id FROM category WHERE name = 'Concealer'), random(1, 20)),
            ('Fenty Beauty Pro Filt''r Instant Retouch Concealer', 'Lightweight, soft matte concealer', 'Fenty Beauty', '30.00', '15.00', '2018-12-26', (SELECT id FROM category WHERE name = 'Concealer'), random(1, 20)),
            ('Huda Beauty Overachiever Concealer', 'High-pigment, long-wear concealer', 'Huda Beauty', '30.00', '15.00', '2019-04-05', (SELECT id FROM category WHERE name = 'Concealer'), random(1, 20)),
            ('Laura Mercier Translucent Loose Setting Powder', 'Cult-favorite, finely milled loose powder', 'Laura Mercier', '43.00', '21.50', '2005-03-10', (SELECT id FROM category WHERE name = 'Setting Powder'), random(1, 20)),
            ('RCMA No-Color Powder', 'Professional-grade, lightweight setting powder', 'RCMA', '14.00', '7.00', '2016-07-21', (SELECT id FROM category WHERE name = 'Setting Powder'), random(1, 20)),
            ('Fenty Beauty Pro Filt''r Instant Retouch Setting Powder', 'Soft matte finish loose setting powder', 'Fenty Beauty', '36.00', '18.00', '2019-01-10', (SELECT id FROM category WHERE name = 'Setting Powder'), random(1, 20)),
            ('Maybelline Fit Me Loose Finishing Powder', 'Affordable, oil-controlling setting powder', 'Maybelline', '8.99', '4.50', '2017-10-15', (SELECT id FROM category WHERE name = 'Setting Powder'), random(1, 20)),
            ('Charlotte Tilbury Airbrush Flawless Finish Powder', 'Blurring, silky-smooth pressed powder', 'Charlotte Tilbury', '48.00', '24.00', '2016-06-01', (SELECT id FROM category WHERE name = 'Setting Powder'), random(1, 20)),
            ('Urban Decay Naked3 Eyeshadow Palette', 'Warm rose-hued neutral eyeshadow palette', 'Urban Decay', '54.00', '27.00', '2013-12-01', (SELECT id FROM category WHERE name = 'Eyeshadow'), random(1, 20)),
            ('Anastasia Beverly Hills Modern Renaissance', 'Highly pigmented, warm-toned eyeshadow palette', 'ABH', '55.00', '27.50', '2016-06-03', (SELECT id FROM category WHERE name = 'Eyeshadow'), random(1, 20)),
            ('Huda Beauty Nude Obsessions Palette', 'Compact nude-toned eyeshadow palette', 'Huda Beauty', '29.00', '14.50', '2019-10-13', (SELECT id FROM category WHERE name = 'Eyeshadow'), random(1, 20)),
            ('Pat McGrath Mothership V: Bronze Seduction', 'Luxurious high-pigment eyeshadow palette', 'Pat McGrath Labs', '128.00', '64.00', '2018-09-07', (SELECT id FROM category WHERE name = 'Eyeshadow'), random(1, 20)),
            ('Natasha Denona Biba Palette', 'High-end neutral-toned everyday palette', 'Natasha Denona', '129.00', '64.50', '2019-04-10', (SELECT id FROM category WHERE name = 'Eyeshadow'), random(1, 20)),
            ('Stila Stay All Day Waterproof Liquid Eyeliner', 'Long-wear waterproof liquid eyeliner', 'Stila', '24.00', '12.00', '2010-06-15', (SELECT id FROM category WHERE name = 'Eyeliner'), random(1, 20)),
            ('Kat Von D Tattoo Liner', 'High-precision, smudge-proof liquid eyeliner', 'KVD Beauty', '23.00', '11.50', '2015-07-20', (SELECT id FROM category WHERE name = 'Eyeliner'), random(1, 20)),
            ('Maybelline Eye Studio Master Precise Liquid Eyeliner', 'Drugstore precision liquid liner', 'Maybelline', '8.99', '4.50', '2012-05-18', (SELECT id FROM category WHERE name = 'Eyeliner'), random(1, 20)),
            ('Fenty Beauty Flyliner Longwear Liquid Eyeliner', 'Highly pigmented, flexible-tip liquid eyeliner', 'Fenty Beauty', '24.00', '12.00', '2018-07-06', (SELECT id FROM category WHERE name = 'Eyeliner'), random(1, 20)),
            ('NYX Epic Ink Liner', 'Affordable, long-lasting felt-tip liner', 'NYX', '10.00', '5.00', '2017-08-14', (SELECT id FROM category WHERE name = 'Eyeliner'), random(1, 20)),
            ('Too Faced Better Than Sex Mascara', 'Volumizing and lengthening mascara', 'Too Faced', '28.00', '14.00', '2013-10-02', (SELECT id FROM category WHERE name = 'Mascara'), random(1, 20)),
            ('Benefit They''re Real! Lengthening Mascara', 'Long-lasting, lifting mascara', 'Benefit', '29.00', '14.50', '2011-06-25', (SELECT id FROM category WHERE name = 'Mascara'), random(1, 20)),
            ('L''Oréal Lash Paradise Mascara', 'Drugstore dupe of Better Than Sex', 'L''Oréal', '11.99', '6.00', '2017-04-10', (SELECT id FROM category WHERE name = 'Mascara'), random(1, 20)),
            ('Maybelline Lash Sensational Mascara', 'Drugstore-favorite volumizing mascara', 'Maybelline', '10.99', '5.50', '2015-01-15', (SELECT id FROM category WHERE name = 'Mascara'), random(1, 20)),
            ('Pat McGrath Labs FetishEyes Mascara', 'High-end, ultra-black dramatic mascara', 'Pat McGrath Labs', '30.00', '15.00', '2019-02-22', (SELECT id FROM category WHERE name = 'Mascara'), random(1, 20)),
            ('Anastasia Beverly Hills Brow Wiz', 'Ultra-slim, precision eyebrow pencil', 'ABH', '25.00', '12.50', '2013-05-10', (SELECT id FROM category WHERE name = 'Eyebrow Pencil'), random(1, 20)),
            ('Benefit Precisely, My Brow Pencil', 'Waterproof, fine-tip eyebrow pencil', 'Benefit', '25.00', '12.50', '2016-04-22', (SELECT id FROM category WHERE name = 'Eyebrow Pencil'), random(1, 20)),
            ('NYX Micro Brow Pencil', 'Affordable, ultra-thin drugstore brow pencil', 'NYX', '12.00', '6.00', '2015-02-18', (SELECT id FROM category WHERE name = 'Eyebrow Pencil'), random(1, 20)),
            ('Fenty Beauty Brow MVP Ultra Fine Brow Pencil & Styler', 'Precision brow pencil with brush', 'Fenty Beauty', '22.00', '11.00', '2019-08-23', (SELECT id FROM category WHERE name = 'Eyebrow Pencil'), random(1, 20)),
            ('Maybelline Total Temptation Eyebrow Definer Pencil', 'Soft, blendable eyebrow pencil', 'Maybelline', '7.99', '4.00', '2018-01-12', (SELECT id FROM category WHERE name = 'Eyebrow Pencil'), random(1, 20)),
            ('MAC Matte Lipstick - Ruby Woo', 'Iconic matte red lipstick', 'MAC', '23.00', '11.50', '1999-04-15', (SELECT id FROM category WHERE name = 'Lipstick'), random(1, 20)),
            ('Dior Rouge Dior Lipstick', 'Long-lasting, hydrating lipstick', 'Dior', '42.00', '21.00', '2016-09-12', (SELECT id FROM category WHERE name = 'Lipstick'), random(1, 20)),
            ('Charlotte Tilbury Matte Revolution Lipstick - Pillow Talk', 'Cult-favorite nude-pink lipstick', 'Charlotte Tilbury', '35.00', '17.50', '2017-10-01', (SELECT id FROM category WHERE name = 'Lipstick'), random(1, 20)),
            ('Maybelline SuperStay Matte Ink', 'Drugstore long-wear matte liquid lipstick', 'Maybelline', '11.99', '6.00', '2017-06-10', (SELECT id FROM category WHERE name = 'Lipstick'), random(1, 20)),
            ('YSL Rouge Pur Couture Lipstick', 'Luxurious, satin-finish lipstick', 'YSL', '45.00', '22.50', '2013-11-25', (SELECT id FROM category WHERE name = 'Lipstick'), random(1, 20)),
            ('Fenty Beauty Gloss Bomb Universal Lip Luminizer', 'High-shine, non-sticky lip gloss', 'Fenty Beauty', '20.00', '10.00', '2017-09-08', (SELECT id FROM category WHERE name = 'Lip Gloss'), random(1, 20)),
            ('Dior Addict Lip Glow Oil', 'Hydrating, tinted lip oil gloss', 'Dior', '40.00', '20.00', '2020-01-20', (SELECT id FROM category WHERE name = 'Lip Gloss'), random(1, 20)),
            ('Glossier Lip Gloss', 'Crystal-clear, smooth lip gloss', 'Glossier', '15.00', '7.50', '2018-05-14', (SELECT id FROM category WHERE name = 'Lip Gloss'), random(1, 20)),
            ('NYX Butter Gloss', 'Affordable, creamy-texture lip gloss', 'NYX', '6.00', '3.00', '2014-07-10', (SELECT id FROM category WHERE name = 'Lip Gloss'), random(1, 20)),
            ('Pat McGrath Lust: Gloss', 'High-shine, luxe lip gloss', 'Pat McGrath Labs', '29.00', '14.50', '2019-03-18', (SELECT id FROM category WHERE name = 'Lip Gloss'), random(1, 20)),
            ('Laneige Lip Sleeping Mask', 'Overnight hydrating lip balm', 'Laneige', '24.00', '12.00', '2018-01-25', (SELECT id FROM category WHERE name = 'Lip Balm'), random(1, 20)),
            ('Fresh Sugar Lip Treatment SPF 15', 'Tinted, nourishing lip balm', 'Fresh', '26.00', '13.00', '2012-09-10', (SELECT id FROM category WHERE name = 'Lip Balm'), random(1, 20)),
            ('Burt’s Bees Beeswax Lip Balm', '100% natural classic lip balm', 'Burt’s Bees', '4.00', '2.00', '1991-06-15', (SELECT id FROM category WHERE name = 'Lip Balm'), random(1, 20)),
            ('NIVEA Smoothness Lip Care SPF 15', 'Affordable, everyday lip balm', 'NIVEA', '3.50', '1.75', '2008-11-05', (SELECT id FROM category WHERE name = 'Lip Balm'), random(1, 20)),
            ('Eos Super Soft Shea Lip Balm', 'Organic, shea butter-infused lip balm', 'Eos', '4.50', '2.25', '2015-08-30', (SELECT id FROM category WHERE name = 'Lip Balm'), random(1, 20)),
            ('Charlotte Tilbury Lip Cheat - Pillow Talk', 'Perfect nude-pink lip liner', 'Charlotte Tilbury', '25.00', '12.50', '2017-10-01', (SELECT id FROM category WHERE name = 'Lip Liner'), random(1, 20)),
            ('MAC Lip Pencil - Spice', 'Classic, creamy-texture lip liner', 'MAC', '24.00', '12.00', '1994-05-08', (SELECT id FROM category WHERE name = 'Lip Liner'), random(1, 20)),
            ('NYX Slim Lip Pencil', 'Affordable, smooth lip liner', 'NYX', '5.00', '2.50', '2013-06-20', (SELECT id FROM category WHERE name = 'Lip Liner'), random(1, 20)),
            ('Huda Beauty Lip Contour 2.0', 'Long-wear, waterproof lip liner', 'Huda Beauty', '19.00', '9.50', '2021-06-05', (SELECT id FROM category WHERE name = 'Lip Liner'), random(1, 20)),
            ('Pat McGrath PermaGel Ultra Lip Pencil', 'High-pigment, ultra-creamy lip liner', 'Pat McGrath Labs', '29.00', '14.50', '2019-03-18', (SELECT id FROM category WHERE name = 'Lip Liner'), random(1, 20)),
            ('NARS Blush - Orgasm', 'Iconic peachy-pink blush with gold shimmer', 'NARS', '32.00', '16.00', '1999-06-15', (SELECT id FROM category WHERE name = 'Blush'), random(1, 20)),
            ('Milani Baked Blush - Luminoso', 'Affordable warm peach-toned blush', 'Milani', '10.99', '5.50', '2012-08-20', (SELECT id FROM category WHERE name = 'Blush'), random(1, 20)),
            ('MAC Powder Blush - Melba', 'Matte soft coral-peach blush', 'MAC', '28.00', '14.00', '2005-03-10', (SELECT id FROM category WHERE name = 'Blush'), random(1, 20)),
            ('Benefit Cosmetics Benetint', 'Sheer rosy liquid blush & lip tint', 'Benefit', '24.00', '12.00', '2001-07-05', (SELECT id FROM category WHERE name = 'Blush'), random(1, 20)),
            ('Patrick Ta Monochrome Moment Blush', 'Silky, natural finish pressed powder blush', 'Patrick Ta', '32.00', '16.00', '2019-09-10', (SELECT id FROM category WHERE name = 'Blush'), random(1, 20)),
            ('Kevyn Aucoin The Sculpting Powder', 'Cult-favorite cool-toned contour powder', 'Kevyn Aucoin', '48.00', '24.00', '2010-02-25', (SELECT id FROM category WHERE name = 'Contour Powder'), random(1, 20)),
            ('Fenty Beauty Match Stix Matte Contour Stick', 'Cream-to-powder matte contour stick', 'Fenty Beauty', '28.00', '14.00', '2017-09-08', (SELECT id FROM category WHERE name = 'Contour Powder'), random(1, 20)),
            ('Charlotte Tilbury Filmstar Bronze & Glow', 'High-end contour & highlight duo', 'Charlotte Tilbury', '68.00', '34.00', '2014-10-15', (SELECT id FROM category WHERE name = 'Contour Powder'), random(1, 20)),
            ('NYX Professional Makeup Wonder Stick', 'Affordable dual-ended contour & highlight stick', 'NYX', '14.00', '7.00', '2015-03-20', (SELECT id FROM category WHERE name = 'Contour Powder'), random(1, 20)),
            ('KVD Beauty Shade + Light Contour Palette', 'Multi-shade powder contour palette', 'KVD Beauty', '50.00', '25.00', '2015-07-30', (SELECT id FROM category WHERE name = 'Contour Powder'), random(1, 20)),
            ('BECCA Shimmering Skin Perfector - Champagne Pop', 'Best-selling golden-peach highlighter', 'BECCA', '38.00', '19.00', '2015-07-02', (SELECT id FROM category WHERE name = 'Highlighter'), random(1, 20)),
            ('Fenty Beauty Killawatt Freestyle Highlighter - Trophy Wife', 'Ultra-metallic gold highlighter', 'Fenty Beauty', '38.00', '19.00', '2017-09-08', (SELECT id FROM category WHERE name = 'Highlighter'), random(1, 20)),
            ('Anastasia Beverly Hills Amrezy Highlighter', 'Limited-edition gold-toned highlighter', 'ABH', '28.00', '14.00', '2018-02-14', (SELECT id FROM category WHERE name = 'Highlighter'), random(1, 20)),
            ('Hourglass Ambient Lighting Powder', 'Soft-focus, natural glow highlighter', 'Hourglass', '48.00', '24.00', '2013-05-01', (SELECT id FROM category WHERE name = 'Highlighter'), random(1, 20)),
            ('Rare Beauty Positive Light Liquid Luminizer', 'Lightweight, buildable liquid highlighter', 'Rare Beauty', '25.00', '12.50', '2020-09-03', (SELECT id FROM category WHERE name = 'Highlighter'), random(1, 20)),
            ('oo Cool For School Artclass By Rodin Shading', 'Popular Korean 3-shade contour powder', 'Too Cool For School', '17.00', '8.50', '2015-06-12', (SELECT id FROM category WHERE name = 'Nose Shadow'), random(1, 20)),
            ('Etude House Play 101 Stick Contour Duo', 'Affordable Korean cream contour stick', 'Etude House', '14.00', '7.00', '2016-03-08', (SELECT id FROM category WHERE name = 'Nose Shadow'), random(1, 20)),
            ('Canmake Nose Shadow Powder', 'Japanese light & natural nose contour powder', 'Canmake', '12.00', '6.00', '2014-09-20', (SELECT id FROM category WHERE name = 'Nose Shadow'), random(1, 20)),
            ('Huda Beauty Tantour Contour & Bronzer Cream', 'Creamy, blendable contour for nose & face', 'Huda Beauty', '30.00', '15.00', '2019-05-17', (SELECT id FROM category WHERE name = 'Nose Shadow'), random(1, 20)),
            ('Charlotte Tilbury Hollywood Contour Wand', 'Liquid contouring for sculpted nose & cheeks', 'Charlotte Tilbury', '42.00', '21.00', '2018-01-29', (SELECT id FROM category WHERE name = 'Nose Shadow'), random(1, 20)),
            ('Urban Decay All Nighter Long-Lasting Makeup Setting Spray', 'Best-selling, long-wear setting spray', 'Urban Decay', '36.00', '18.00', '2010-05-12', (SELECT id FROM category WHERE name = 'Setting Spray'), random(1, 20)),
            ('MAC Prep + Prime Fix+', 'Hydrating & refreshing setting spray', 'MAC', '31.00', '15.50', '2003-08-20', (SELECT id FROM category WHERE name = 'Setting Spray'), random(1, 20)),
            ('Charlotte Tilbury Airbrush Flawless Setting Spray', 'Lightweight, smoothing setting spray', 'Charlotte Tilbury', '38.00', '19.00', '2020-07-20', (SELECT id FROM category WHERE name = 'Setting Spray'), random(1, 20)),
            ('NYX Professional Makeup Matte Finish Setting Spray', 'Affordable, mattifying setting spray', 'NYX', '10.00', '5.00', '2013-04-15', (SELECT id FROM category WHERE name = 'Setting Spray'), random(1, 20)),
            ('Milani Make It Last Setting Spray', 'Drugstore long-wear setting spray', 'Milani', '12.00', '6.00', '2017-06-10', (SELECT id FROM category WHERE name = 'Setting Spray'), random(1, 20)),
            ('Laura Mercier Translucent Loose Setting Powder', 'Iconic oil-control, soft-focus loose powder', 'Laura Mercier', '43.00', '21.50', '2006-09-25', (SELECT id FROM category WHERE name = 'Oil-Control Powder'), random(1, 20)),
            ('RCMA No-Color Powder', 'Lightweight, professional-grade oil-control powder', 'RCMA', '14.00', '7.00', '2015-02-14', (SELECT id FROM category WHERE name = 'Oil-Control Powder'), random(1, 20)),
            ('Innisfree No-Sebum Mineral Powder', 'Popular Korean oil-absorbing powder', 'Innisfree', '8.00', '4.00', '2008-07-30', (SELECT id FROM category WHERE name = 'Oil-Control Powder'), random(1, 20)),
            ('Fenty Beauty Pro Filt’r Instant Retouch Setting Powder', 'Silky, oil-free loose setting powder', 'Fenty Beauty', '36.00', '18.00', '2018-12-26', (SELECT id FROM category WHERE name = 'Oil-Control Powder'), random(1, 20)),
            ('Maybelline Fit Me Loose Finishing Powder', 'Affordable, lightweight loose powder', 'Maybelline', '9.99', '5.00', '2017-08-10', (SELECT id FROM category WHERE name = 'Oil-Control Powder'), random(1, 20)),
            ('Dove Deep Moisture Body Wash', 'Gentle, hydrating body wash with NutriumMoisture™', 'Dove', '7.99', '4.00', '2015-03-10', (SELECT id FROM category WHERE name = 'Body Wash'), random(1, 20)),
            ('Olay Ultra Moisture Body Wash with Shea Butter', 'Nourishing body wash with shea butter', 'Olay', '8.99', '4.50', '2017-06-15', (SELECT id FROM category WHERE name = 'Body Wash'), random(1, 20)),
            ('Aveeno Daily Moisturizing Body Wash', 'Soothing oat-based body wash for dry skin', 'Aveeno', '9.99', '5.00', '2012-08-20', (SELECT id FROM category WHERE name = 'Body Wash'), random(1, 20)),
            ('The Body Shop British Rose Shower Gel', 'Floral-scented, gentle cleansing shower gel', 'The Body Shop', '12.00', '6.00', '2016-09-05', (SELECT id FROM category WHERE name = 'Body Wash'), random(1, 20)),
            ('Neutrogena Rainbath Refreshing Shower Gel', 'Classic fresh-scented, moisturizing body wash', 'Neutrogena', '11.49', '5.75', '2010-05-25', (SELECT id FROM category WHERE name = 'Body Wash'), random(1, 20)),
            ('Dove Beauty Bar - Original', 'Moisturizing beauty bar with 1/4 moisturizing cream', 'Dove', '3.99', '2.00', '1957-09-01', (SELECT id FROM category WHERE name = 'Soap'), random(1, 20)),
            ('L’Occitane Shea Butter Extra-Gentle Soap', 'Luxurious, shea butter-infused soap bar', 'L’Occitane', '12.00', '6.00', '2005-02-20', (SELECT id FROM category WHERE name = 'Soap'), random(1, 20)),
            ('Dr. Bronner’s Pure-Castile Bar Soap - Lavender', 'Organic, multi-use natural soap bar', 'Dr. Bronner’s', '5.99', '3.00', '2014-04-10', (SELECT id FROM category WHERE name = 'Soap'), random(1, 20)),
            ('Irish Spring Original Deodorant Soap', 'Fresh-scented, antibacterial deodorant soap', 'Irish Spring', '4.49', '2.25', '1972-11-15', (SELECT id FROM category WHERE name = 'Soap'), random(1, 20)),
            ('Lush Honey I Washed The Kids Soap', 'Handmade, honey-scented moisturizing soap', 'Lush', '8.00', '4.00', '2003-06-25', (SELECT id FROM category WHERE name = 'Soap'), random(1, 20)),
            ('Tree Hut Shea Sugar Scrub - Moroccan Rose', 'Exfoliating sugar scrub with essential oils', 'Tree Hut', '10.99', '5.50', '2018-04-15', (SELECT id FROM category WHERE name = 'Body Scrub'), random(1, 20)),
            ('Frank Body Original Coffee Scrub', 'Caffeine-infused exfoliating body scrub', 'Frank Body', '16.95', '8.50', '2014-07-20', (SELECT id FROM category WHERE name = 'Body Scrub'), random(1, 20)),
            ('Herbivore Coco Rose Exfoliating Body Scrub', 'Hydrating, coconut oil & rose-based scrub', 'Herbivore', '36.00', '18.00', '2017-02-05', (SELECT id FROM category WHERE name = 'Body Scrub'), random(1, 20)),
            ('The Body Shop Coconut Exfoliating Cream Body Scrub', 'Creamy, nourishing coconut scrub', 'The Body Shop', '24.00', '12.00', '2016-10-12', (SELECT id FROM category WHERE name = 'Body Scrub'), random(1, 20)),
            ('Lush Ocean Salt Face and Body Scrub', 'Handmade, sea salt & lime-infused exfoliator', 'Lush', '22.00', '11.00', '2011-09-30', (SELECT id FROM category WHERE name = 'Body Scrub'), random(1, 20)),
            ('CeraVe Daily Moisturizing Lotion', 'Lightweight, non-greasy moisturizer with ceramides', 'CeraVe', '14.99', '7.50', '2005-06-20', (SELECT id FROM category WHERE name = 'Body Lotion'), random(1, 20)),
            ('NIVEA Essentially Enriched Body Lotion', 'Deeply nourishing body lotion with almond oil', 'NIVEA', '8.99', '4.50', '2010-09-10', (SELECT id FROM category WHERE name = 'Body Lotion'), random(1, 20)),
            ('Aveeno Daily Moisturizing Lotion', 'Oat-based, fragrance-free body moisturizer', 'Aveeno', '9.99', '5.00', '2002-04-15', (SELECT id FROM category WHERE name = 'Body Lotion'), random(1, 20)),
            ('The Body Shop Almond Milk Body Butter', 'Rich, hydrating body butter for sensitive skin', 'The Body Shop', '24.00', '12.00', '2017-10-05', (SELECT id FROM category WHERE name = 'Body Lotion'), random(1, 20)),
            ('Vaseline Intensive Care Cocoa Radiant Lotion', 'Cocoa butter-infused deep moisture lotion', 'Vaseline', '7.99', '4.00', '2013-08-25', (SELECT id FROM category WHERE name = 'Body Lotion'), random(1, 20)),
            ('L’Occitane Shea Butter Hand Cream', 'Best-selling, ultra-rich shea butter hand cream', 'L’Occitane', '29.00', '14.50', '2001-11-20', (SELECT id FROM category WHERE name = 'Hand Cream'), random(1, 20)),
            ('Neutrogena Norwegian Formula Hand Cream', 'Glycerin-rich, fast-absorbing hand cream', 'Neutrogena', '5.99', '3.00', '1972-03-10', (SELECT id FROM category WHERE name = 'Hand Cream'), random(1, 20)),
            ('Eucerin Advanced Repair Hand Cream', 'Dermatologist-recommended, fragrance-free hand cream', 'Eucerin', '6.99', '3.50', '2015-06-30', (SELECT id FROM category WHERE name = 'Hand Cream'), random(1, 20)),
            ('The Body Shop Hemp Hand Protector', 'Intensive moisture hand cream for very dry skin', 'The Body Shop', '20.00', '10.00', '2012-09-05', (SELECT id FROM category WHERE name = 'Hand Cream'), random(1, 20)),
            ('Chanel La Crème Main Hand Cream', 'Luxurious, brightening and anti-aging hand cream', 'Chanel', '50.00', '25.00', '2017-12-15', (SELECT id FROM category WHERE name = 'Hand Cream'), random(1, 20)),
            ('Bio-Oil Skincare Oil', 'Best-selling, scar and stretch mark treatment oil', 'Bio-Oil', '14.99', '7.50', '2002-05-22', (SELECT id FROM category WHERE name = 'Body Oil'), random(1, 20)),
            ('Neutrogena Body Oil, Light Sesame Formula', 'Lightweight, fast-absorbing sesame body oil', 'Neutrogena', '11.99', '6.00', '1982-07-15', (SELECT id FROM category WHERE name = 'Body Oil'), random(1, 20)),
            ('Palmer’s Cocoa Butter Formula Moisturizing Body Oil', 'Cocoa butter-infused, deeply nourishing body oil', 'Palmer’s', '8.99', '4.50', '2011-10-08', (SELECT id FROM category WHERE name = 'Body Oil'), random(1, 20)),
            ('L’Occitane Almond Supple Skin Oil', 'Luxurious, almond-based firming body oil', 'L’Occitane', '50.00', '25.00', '2015-03-12', (SELECT id FROM category WHERE name = 'Body Oil'), random(1, 20)),
            ('Nuxe Huile Prodigieuse Multi-Purpose Dry Oil', 'Iconic French multi-use oil for face, body & hair', 'Nuxe', '45.00', '22.50', '1991-09-10', (SELECT id FROM category WHERE name = 'Body Oil'), random(1, 20)),
            ('Chanel No. 5 Eau de Parfum', 'Iconic floral-aldehyde fragrance', 'Chanel', '160.00', '80.00', '1921-05-05', (SELECT id FROM category WHERE name = 'Perfume'), random(1, 20)),
            ('Dior J''adore Eau de Parfum', 'Luxurious floral-fruity fragrance', 'Dior', '135.00', '67.50', '1999-10-15', (SELECT id FROM category WHERE name = 'Perfume'), random(1, 20)),
            ('Yves Saint Laurent Black Opium Eau de Parfum', 'Addictive coffee & vanilla scent', 'YSL', '130.00', '65.00', '2014-08-20', (SELECT id FROM category WHERE name = 'Perfume'), random(1, 20)),
            ('Gucci Bloom Eau de Parfum', 'Elegant white floral fragrance', 'Gucci', '138.00', '69.00', '2017-06-10', (SELECT id FROM category WHERE name = 'Perfume'), random(1, 20)),
            ('Tom Ford Black Orchid Eau de Parfum', 'Mysterious, sensual oriental fragrance', 'Tom Ford', '180.00', '90.00', '2006-11-20', (SELECT id FROM category WHERE name = 'Perfume'), random(1, 20)),
            ('Victoria’s Secret Bombshell Fragrance Mist', 'Best-selling fruity floral body mist', 'Victoria’s Secret', '25.00', '12.50', '2010-05-10', (SELECT id FROM category WHERE name = 'Body Mist'), random(1, 20)),
            ('Bath & Body Works Japanese Cherry Blossom Fine Fragrance Mist', 'Classic floral body mist', 'Bath & Body Works', '16.50', '8.25', '2006-03-15', (SELECT id FROM category WHERE name = 'Body Mist'), random(1, 20)),
            ('Sol de Janeiro Brazilian Crush Cheirosa 62 Body Fragrance Mist', 'Warm vanilla & pistachio scent', 'Sol de Janeiro', '38.00', '19.00', '2017-09-25', (SELECT id FROM category WHERE name = 'Body Mist'), random(1, 20)),
            ('The Body Shop White Musk Fragrance Mist', 'Soft, musky body spray', 'The Body Shop', '20.00', '10.00', '1981-04-10', (SELECT id FROM category WHERE name = 'Body Mist'), random(1, 20)),
            ('Ariana Grande Cloud Body Mist', 'Sweet, cozy gourmand fragrance mist', 'Ariana Grande', '20.00', '10.00', '2018-12-05', (SELECT id FROM category WHERE name = 'Body Mist'), random(1, 20)),
            ('Veet Gel Hair Removal Cream - Sensitive Skin', 'Aloe vera & vitamin E-infused depilatory cream', 'Veet', '8.99', '4.50', '2015-07-10', (SELECT id FROM category WHERE name = 'Body Cleansing'), random(1, 20)),
            ('Nair Hair Remover Moisturizing Cream', 'Effective & hydrating hair removal cream', 'Nair', '7.99', '4.00', '2013-05-22', (SELECT id FROM category WHERE name = 'Body Cleansing'), random(1, 20)),
            ('Sally Hansen Hair Remover Cream for Face & Body', 'Gentle depilatory cream for sensitive areas', 'Sally Hansen', '9.99', '5.00', '2016-09-18', (SELECT id FROM category WHERE name = 'Body Cleansing'), random(1, 20)),
            ('Olay Smooth Finish Facial Hair Removal Duo', '2-step gentle facial hair remover', 'Olay', '25.00', '12.50', '2018-04-05', (SELECT id FROM category WHERE name = 'Body Cleansing'), random(1, 20)),
            ('Avon Skin So Soft Fresh & Smooth Hair Removal Cream', 'Moisturizing hair remover with jojoba oil', 'Avon', '10.00', '5.00', '2014-10-30', (SELECT id FROM category WHERE name = 'Body Cleansing'), random(1, 20)),
            ('Gillette Venus Extra Smooth Razor', '5-blade razor for a close, smooth shave', 'Gillette', '12.99', '6.50', '2001-06-15', (SELECT id FROM category WHERE name = 'Razor'), random(1, 20)),
            ('Schick Hydro Silk 5 Razor', 'Hydrating razor with skin guards', 'Schick', '11.99', '6.00', '2012-08-25', (SELECT id FROM category WHERE name = 'Razor'), random(1, 20)),
            ('BIC Soleil Bella Disposable Razor', '4-blade disposable razor with moisture strip', 'BIC', '6.99', '3.50', '2015-03-10', (SELECT id FROM category WHERE name = 'Razor'), random(1, 20)),
            ('Flamingo Razor for Women', 'Sleek, ergonomic razor with aloe-infused strip', 'Flamingo', '9.00', '4.50', '2018-11-12', (SELECT id FROM category WHERE name = 'Razor'), random(1, 20)),
            ('Billie Razor Starter Kit', 'Hypoallergenic, nickel-free razor with magnetic holder', 'Billie', '10.00', '5.00', '2019-09-05', (SELECT id FROM category WHERE name = 'Razor'), random(1, 20)),
            ('NIVEA Extra Whitening Cell Repair Body Lotion', 'Brightening lotion with 50x Vitamin C', 'NIVEA', '12.99', '6.50', '2016-07-10', (SELECT id FROM category WHERE name = 'Body Whitening Lotion'), random(1, 20)),
            ('Vaseline Healthy White UV Lightening Lotion', 'Skin-lightening lotion with micro-droplets of Vaseline jelly', 'Vaseline', '10.99', '5.50', '2015-04-22', (SELECT id FROM category WHERE name = 'Body Whitening Lotion'), random(1, 20)),
            ('Hada Labo Premium Whitening Lotion', 'Deep hydration & brightening with tranexamic acid', 'Hada Labo', '18.99', '9.50', '2018-06-18', (SELECT id FROM category WHERE name = 'Body Whitening Lotion'), random(1, 20)),
            ('Olay White Radiance UV Whitening Body Lotion', 'Advanced brightening formula with SPF', 'Olay', '15.99', '8.00', '2017-09-05', (SELECT id FROM category WHERE name = 'Body Whitening Lotion'), random(1, 20)),
            ('Snow White Milky Pack by Secret Key', 'Instant tone-up brightening body cream', 'Secret Key', '14.00', '7.00', '2014-11-20', (SELECT id FROM category WHERE name = 'Body Whitening Lotion'), random(1, 20)),
            ('Paula’s Choice Clear Back & Body Acne Spray', '2% Salicylic Acid treatment for body acne', 'Paula’s Choice', '27.00', '13.50', '2019-03-15', (SELECT id FROM category WHERE name = 'Back Acne Spray'), random(1, 20)),
            ('Murad Clarifying Body Spray', 'Antibacterial back acne spray with salicylic acid', 'Murad', '44.00', '22.00', '2020-05-10', (SELECT id FROM category WHERE name = 'Back Acne Spray'), random(1, 20)),
            ('Neutrogena Body Clear Body Spray', 'Salicylic acid acne treatment for body', 'Neutrogena', '12.99', '6.50', '2016-08-25', (SELECT id FROM category WHERE name = 'Back Acne Spray'), random(1, 20)),
            ('Replenix Acne Solutions Gly/Sal 10-2 Body Spray', 'Clinical-strength glycolic & salicylic acid formula', 'Replenix', '35.00', '17.50', '2021-07-05', (SELECT id FROM category WHERE name = 'Back Acne Spray'), random(1, 20)),
            ('Proactiv Clear Zone Body Acne Treatment Spray', 'Fast-drying, non-sticky back acne solution', 'Proactiv', '32.00', '16.00', '2018-10-12', (SELECT id FROM category WHERE name = 'Back Acne Spray'), random(1, 20)),
            ('L''Oreal Paris Elvive Total Repair 5 Shampoo', 'Strengthening & repairing formula', 'L''Oreal Paris', '5.99', '3.00', '2017-06-15', (SELECT id FROM category WHERE name = 'Shampoo'), random(1, 20)),
            ('Pantene Pro-V Daily Moisture Renewal Shampoo', 'Hydrating shampoo for dry hair', 'Pantene', '6.99', '3.50', '2015-08-10', (SELECT id FROM category WHERE name = 'Shampoo'), random(1, 20)),
            ('Head & Shoulders Classic Clean Shampoo', 'Anti-dandruff & scalp refreshing', 'Head & Shoulders', '7.99', '4.00', '2013-05-22', (SELECT id FROM category WHERE name = 'Shampoo'), random(1, 20)),
            ('OGX Coconut Milk Shampoo', 'Sulfate-free nourishing formula', 'OGX', '8.99', '4.50', '2016-09-18', (SELECT id FROM category WHERE name = 'Shampoo'), random(1, 20)),
            ('Redken Extreme Shampoo', 'Strengthens damaged & brittle hair', 'Redken', '25.00', '12.50', '2018-04-05', (SELECT id FROM category WHERE name = 'Shampoo'), random(1, 20)),
            ('Olaplex No.5 Bond Maintenance Conditioner', 'Repairs & strengthens damaged hair', 'Olaplex', '28.00', '14.00', '2019-02-10', (SELECT id FROM category WHERE name = 'Conditioner'), random(1, 20)),
            ('Herbal Essences Bio:Renew Argan Oil Conditioner', 'Moisturizing & sulfate-free', 'Herbal Essences', '6.50', '3.25', '2017-05-12', (SELECT id FROM category WHERE name = 'Conditioner'), random(1, 20)),
            ('Aussie 3 Minute Miracle Moist Conditioner', 'Deep hydration for dry hair', 'Aussie', '4.99', '2.50', '2016-03-20', (SELECT id FROM category WHERE name = 'Conditioner'), random(1, 20)),
            ('Kérastase Nutritive Lait Vital Conditioner', 'Lightweight nourishment for normal to dry hair', 'Kérastase', '38.00', '19.00', '2020-07-01', (SELECT id FROM category WHERE name = 'Conditioner'), random(1, 20)),
            ('TRESemmé Moisture Rich Conditioner', 'Salon-quality hydration', 'TRESemmé', '5.99', '3.00', '2014-09-08', (SELECT id FROM category WHERE name = 'Conditioner'), random(1, 20)),
            ('Moroccanoil Intense Hydrating Mask', 'Deep conditioning with argan oil', 'Moroccanoil', '35.00', '17.50', '2016-07-10', (SELECT id FROM category WHERE name = 'Hair Mask'), random(1, 20)),
            ('Briogeo Don''t Despair, Repair! Deep Conditioning Mask', 'Strengthens & restores damaged hair', 'Briogeo', '36.00', '18.00', '2018-06-22', (SELECT id FROM category WHERE name = 'Hair Mask'), random(1, 20)),
            ('Garnier Fructis Smoothing Treat 1-Minute Hair Mask', 'Quick hydrating treatment', 'Garnier', '7.99', '4.00', '2019-04-10', (SELECT id FROM category WHERE name = 'Hair Mask'), random(1, 20)),
            ('Kérastase Resistance Masque Therapiste', 'Deep repair for extremely damaged hair', 'Kérastase', '60.00', '30.00', '2021-05-15', (SELECT id FROM category WHERE name = 'Hair Mask'), random(1, 20)),
            ('Christophe Robin Regenerating Mask with Prickly Pear Seed Oil', 'Restores softness & shine', 'Christophe Robin', '69.00', '34.50', '2020-09-20', (SELECT id FROM category WHERE name = 'Hair Mask'), random(1, 20)),
            ('Moroccanoil Treatment Original', 'Lightweight argan oil-infused', 'Moroccanoil', '44.00', '22.00', '2015-12-05', (SELECT id FROM category WHERE name = 'Hair Oil'), random(1, 20)),
            ('The Ordinary Multi-Peptide Serum for Hair Density', 'Nourishing scalp treatment', 'The Ordinary', '20.00', '10.00', '2019-09-05', (SELECT id FROM category WHERE name = 'Hair Oil'), random(1, 20)),
            ('Kérastase Elixir Ultime L’Huile Originale', 'Enhances shine & smoothness', 'Kérastase', '50.00', '25.00', '2016-04-15', (SELECT id FROM category WHERE name = 'Hair Oil'), random(1, 20)),
            ('Redken All Soft Argan-6 Oil', 'Hydrates & protects dry hair', 'Redken', '30.00', '15.00', '2017-10-08', (SELECT id FROM category WHERE name = 'Hair Oil'), random(1, 20)),
            ('L''Oreal Paris Extraordinary Oil', 'Non-greasy formula for silky hair', 'L''Oreal Paris', '7.99', '4.00', '2018-02-20', (SELECT id FROM category WHERE name = 'Hair Oil'), random(1, 20)),
            ('The Ordinary Multi-Peptide Serum for Hair Density', 'Lightweight formula for fuller hair', 'The Ordinary', '20.00', '10.00', '2019-09-05', (SELECT id FROM category WHERE name = 'Scalp Care Serum'), random(1, 20)),
            ('Kérastase Specifique Stimuliste Scalp Serum', 'Stimulates hair growth & scalp health', 'Kérastase', '55.00', '27.50', '2018-11-22', (SELECT id FROM category WHERE name = 'Scalp Care Serum'), random(1, 20)),
            ('Aveda Invati Advanced Scalp Revitalizer', 'Reduces hair thinning & nourishes roots', 'Aveda', '65.00', '32.50', '2017-06-10', (SELECT id FROM category WHERE name = 'Scalp Care Serum'), random(1, 20)),
            ('Briogeo Scalp Revival Charcoal + Tea Tree Serum', 'Detoxifies & soothes itchy scalp', 'Briogeo', '32.00', '16.00', '2020-03-15', (SELECT id FROM category WHERE name = 'Scalp Care Serum'), random(1, 20)),
            ('L''Oreal Professionnel Serioxyl Denser Hair Serum', 'Strengthens hair fibers & prevents breakage', 'L''Oreal Professionnel', '35.00', '17.50', '2019-07-08', (SELECT id FROM category WHERE name = 'Scalp Care Serum'), random(1, 20)),
            ('TRESemmé TRES Two Extra Hold Hair Spray', 'Strong hold without stickiness', 'TRESemmé', '6.99', '3.50', '2015-04-12', (SELECT id FROM category WHERE name = 'Hair Spray'), random(1, 20)),
            ('L''Oreal Paris Elnett Satin Hairspray', 'Fine mist for flexible hold', 'L''Oreal Paris', '12.99', '6.50', '2016-08-22', (SELECT id FROM category WHERE name = 'Hair Spray'), random(1, 20)),
            ('Kenra Volume Spray 25', 'Humidity-resistant & ultra-strong hold', 'Kenra', '18.00', '9.00', '2017-11-18', (SELECT id FROM category WHERE name = 'Hair Spray'), random(1, 20)),
            ('Garnier Fructis Style Sleek & Shine Anti-Humidity Hairspray', 'Controls frizz & adds shine', 'Garnier', '7.99', '4.00', '2019-06-30', (SELECT id FROM category WHERE name = 'Hair Spray'), random(1, 20)),
            ('Moroccanoil Luminous Hairspray Medium', 'Weightless hold with argan oil', 'Moroccanoil', '24.00', '12.00', '2020-02-25', (SELECT id FROM category WHERE name = 'Hair Spray'), random(1, 20)),
            ('Gatsby Moving Rubber Spiky Edge', 'Strong hold & matte finish', 'Gatsby', '10.00', '5.00', '2016-03-15', (SELECT id FROM category WHERE name = 'Hair Wax'), random(1, 20)),
            ('American Crew Fiber Wax', 'High hold & low shine', 'American Crew', '18.99', '9.50', '2017-09-20', (SELECT id FROM category WHERE name = 'Hair Wax'), random(1, 20)),
            ('Uppercut Deluxe Pomade', 'Classic style with medium shine', 'Uppercut Deluxe', '20.00', '10.00', '2018-12-01', (SELECT id FROM category WHERE name = 'Hair Wax'), random(1, 20)),
            ('Hanz de Fuko Claymation', 'Hybrid clay-wax with extreme hold', 'Hanz de Fuko', '23.00', '11.50', '2019-05-22', (SELECT id FROM category WHERE name = 'Hair Wax'), random(1, 20)),
            ('Redken Brews Wax Pomade', 'Flexible texture with medium control', 'Redken', '15.99', '8.00', '2020-07-10', (SELECT id FROM category WHERE name = 'Hair Wax'), random(1, 20)),
            ('John Frieda Frizz Ease Curl Reviver Mousse', 'Defines curls & adds volume', 'John Frieda', '9.99', '5.00', '2015-10-05', (SELECT id FROM category WHERE name = 'Curling Mousse'), random(1, 20)),
            ('Moroccanoil Curl Control Mousse', 'Lightweight & frizz-free curls', 'Moroccanoil', '28.00', '14.00', '2017-08-12', (SELECT id FROM category WHERE name = 'Curling Mousse'), random(1, 20)),
            ('TRESemmé Flawless Curls Mousse', 'Extra hold for bouncy curls', 'TRESemmé', '7.99', '4.00', '2018-06-18', (SELECT id FROM category WHERE name = 'Curling Mousse'), random(1, 20)),
            ('DevaCurl Frizz-Free Volumizing Foam', 'Moisturizes & enhances natural curls', 'DevaCurl', '26.00', '13.00', '2019-04-08', (SELECT id FROM category WHERE name = 'Curling Mousse'), random(1, 20)),
            ('Pantene Pro-V Curl Defining Mousse', 'Long-lasting curls without crunch', 'Pantene', '6.99', '3.50', '2020-09-10', (SELECT id FROM category WHERE name = 'Curling Mousse'), random(1, 20)),
            ('Schwarzkopf Glatt Hair Straightening Cream', 'Permanent straightening formula', 'Schwarzkopf', '20.00', '10.00', '2016-11-15', (SELECT id FROM category WHERE name = 'Hair Straightening Cream'), random(1, 20)),
            ('L''Oreal X-Tenso Moisturist Straightening Cream', 'Soft, smooth straight hair', 'L''Oreal Professionnel', '25.00', '12.50', '2017-07-22', (SELECT id FROM category WHERE name = 'Hair Straightening Cream'), random(1, 20)),
            ('Wella Straighten It Neutralizing Cream', 'Professional salon-grade formula', 'Wella', '28.00', '14.00', '2018-05-05', (SELECT id FROM category WHERE name = 'Hair Straightening Cream'), random(1, 20)),
            ('Matrix Opti-Smooth Permanent Straightening Cream', 'Heat-activated for sleek results', 'Matrix', '30.00', '15.00', '2019-08-30', (SELECT id FROM category WHERE name = 'Hair Straightening Cream'), random(1, 20)),
            ('Shiseido Crystallizing Straight Cream', 'Intense straightening & anti-frizz', 'Shiseido', '35.00', '17.50', '2020-10-12', (SELECT id FROM category WHERE name = 'Hair Straightening Cream'), random(1, 20)),
            ('L''Oreal Paris Excellence Crème Hair Dye', 'Long-lasting color with deep conditioning', 'L''Oreal Paris', '9.99', '5.00', '2013-07-05', (SELECT id FROM category WHERE name = 'Hair Dye'), random(1, 20)),
            ('Garnier Nutrisse Nourishing Hair Color Creme', 'Enriched with avocado oil', 'Garnier', '8.99', '4.50', '2015-10-15', (SELECT id FROM category WHERE name = 'Hair Dye'), random(1, 20)),
            ('Revlon Colorsilk Beautiful Color Hair Dye', 'Ammonia-free permanent color', 'Revlon', '7.99', '4.00', '2016-12-05', (SELECT id FROM category WHERE name = 'Hair Dye'), random(1, 20)),
            ('Manic Panic Semi-Permanent Hair Color', 'Vegan, bold colors', 'Manic Panic', '14.99', '7.50', '2020-09-25', (SELECT id FROM category WHERE name = 'Hair Dye'), random(1, 20)),
            ('Schwarzkopf Keratin Color Permanent Hair Color', 'Keratin-infused for extra care', 'Schwarzkopf', '12.99', '6.50', '2019-03-10', (SELECT id FROM category WHERE name = 'Hair Dye'), random(1, 20)),
            ('Schwarzkopf Professional BlondMe Bleach', 'High-performance lightening', 'Schwarzkopf', '30.00', '15.00', '2019-05-18', (SELECT id FROM category WHERE name = 'Bleach'), random(1, 20)),
            ('L''Oreal Quick Blue Powder Bleach', 'Fast & effective lifting', 'L''Oreal Paris', '25.00', '12.50', '2018-06-05', (SELECT id FROM category WHERE name = 'Bleach'), random(1, 20)),
            ('Manic Panic Flash Lightning Bleach Kit', 'DIY hair bleaching', 'Manic Panic', '14.99', '7.50', '2020-08-10', (SELECT id FROM category WHERE name = 'Bleach'), random(1, 20)),
            ('Wella Blondor Multi Blonde Powder Lightener', 'Professional-level bleaching', 'Wella', '35.00', '17.50', '2021-04-15', (SELECT id FROM category WHERE name = 'Bleach'), random(1, 20)),
            ('Ion Color Brilliance Bright White Creme Lightener', 'Gentle conditioning bleach', 'Ion', '12.00', '6.00', '2017-11-25', (SELECT id FROM category WHERE name = 'Bleach'), random(1, 20)),
            ('Real Techniques Everyday Essential Set', 'Multi-use makeup brush set', 'Real Techniques', '19.99', '10.00', '2018-04-15', (SELECT id FROM category WHERE name = 'Makeup Brushes'), random(1, 20)),
            ('Sigma Beauty Essential Kit', 'High-quality professional brush set', 'Sigma Beauty', '79.00', '39.50', '2019-07-22', (SELECT id FROM category WHERE name = 'Makeup Brushes'), random(1, 20)),
            ('Morphe X Jaclyn Hill Brush Set', '24-piece brush collection', 'Morphe', '99.00', '49.50', '2017-10-05', (SELECT id FROM category WHERE name = 'Makeup Brushes'), random(1, 20)),
            ('Zoeva Rose Golden Brush Set', 'Luxurious, rose-gold design brushes', 'Zoeva', '89.00', '44.50', '2016-12-18', (SELECT id FROM category WHERE name = 'Makeup Brushes'), random(1, 20)),
            ('MAC 217S Blending Brush', 'Iconic eye blending brush', 'MAC', '26.00', '13.00', '2020-05-30', (SELECT id FROM category WHERE name = 'Makeup Brushes'), random(1, 20)),
            ('Beautyblender Original', 'Soft, high-quality blending sponge', 'Beautyblender', '20.00', '10.00', '2017-03-20', (SELECT id FROM category WHERE name = 'Beauty Sponge'), random(1, 20)),
            ('Real Techniques Miracle Complexion Sponge', 'Affordable, latex-free sponge', 'Real Techniques', '6.99', '3.50', '2018-06-25', (SELECT id FROM category WHERE name = 'Beauty Sponge'), random(1, 20)),
            ('JUNO & Co. Microfiber Velvet Sponge', 'Dual-layered for smooth finish', 'JUNO & Co.', '6.00', '3.00', '2019-09-15', (SELECT id FROM category WHERE name = 'Beauty Sponge'), random(1, 20)),
            ('Fenty Beauty Precision Makeup Sponge', '3-edge design for precision blending', 'Fenty Beauty', '16.00', '8.00', '2020-01-12', (SELECT id FROM category WHERE name = 'Beauty Sponge'), random(1, 20)),
            ('e.l.f. Total Face Sponge', 'Affordable & soft sponge', 'e.l.f.', '5.00', '2.50', '2021-04-10', (SELECT id FROM category WHERE name = 'Beauty Sponge'), random(1, 20)),
            ('Laura Mercier Velour Puff', 'Ultra-soft, luxurious setting puff', 'Laura Mercier', '16.00', '8.00', '2016-08-05', (SELECT id FROM category WHERE name = 'Powder Puff'), random(1, 20)),
            ('RCMA Powder Puff', 'Ideal for loose powder application', 'RCMA', '8.00', '4.00', '2017-09-10', (SELECT id FROM category WHERE name = 'Powder Puff'), random(1, 20)),
            ('Givenchy Prisme Libre Puff', 'Specially designed for loose powder', 'Givenchy', '15.00', '7.50', '2018-11-22', (SELECT id FROM category WHERE name = 'Powder Puff'), random(1, 20)),
            ('Chanel Poudre Universelle Libre Puff', 'Premium puff for soft application', 'Chanel', '20.00', '10.00', '2019-06-30', (SELECT id FROM category WHERE name = 'Powder Puff'), random(1, 20)),
            ('Beautyblender Power Pocket Puff', 'Dual-sided, innovative powder puff', 'Beautyblender', '15.00', '7.50', '2020-02-25', (SELECT id FROM category WHERE name = 'Powder Puff'), random(1, 20)),
            ('Shu Uemura Eyelash Curler', 'Iconic, award-winning curler', 'Shu Uemura', '25.00', '12.50', '2016-05-18', (SELECT id FROM category WHERE name = 'Eyelash Curler'), random(1, 20)),
            ('Shiseido Eyelash Curler', 'Designed for Asian eye shapes', 'Shiseido', '22.00', '11.00', '2017-08-25', (SELECT id FROM category WHERE name = 'Eyelash Curler'), random(1, 20)),
            ('Kevyn Aucoin The Eyelash Curler', 'Wide curve for full lash curling', 'Kevyn Aucoin', '21.00', '10.50', '2018-11-30', (SELECT id FROM category WHERE name = 'Eyelash Curler'), random(1, 20)),
            ('Tweezerman Classic Lash Curler', 'Classic, stainless steel curler', 'Tweezerman', '15.00', '7.50', '2019-10-05', (SELECT id FROM category WHERE name = 'Eyelash Curler'), random(1, 20)),
            ('Tarte Picture Perfect Eyelash Curler', 'Stylish, ergonomic design', 'Tarte', '18.00', '9.00', '2020-07-12', (SELECT id FROM category WHERE name = 'Eyelash Curler'), random(1, 20)),
            ('BEURER FC 45 Facial Brush Cleaner', 'Electric facial brush that cleans up to 4 times more thoroughly than manual cleansing.', 'BEURER', '268.00', '111.67', '2021-06-21', (SELECT id FROM category WHERE name = 'Facial Cleansing Brush'), random(1, 20)),
            ('FOREO LUNA™ fofo Facial Cleansing Brush', '2-in-1 smart cleansing device that analyzes your skin and creates a personalized skincare routine.', 'FOREO', '290.88', '135.92', '2024-11-11', (SELECT id FROM category WHERE name = 'Facial Cleansing Brush'), random(1, 20)),
            ('Pobling Electric Pore Sonic Vibration Facial Cleansing Brush', 'Designed for sensitive skin with 0.05mm soft fibers and 10000 sonic vibrations per minute.', 'Pobling', '8.50', '3.75', '2024-01-01', (SELECT id FROM category WHERE name = 'Facial Cleansing Brush'), random(1, 20)),
            ('Foreo Luna Facial Cleansing Brush', 'Tailored according to skin type with long battery life and app connectivity.', 'Foreo', '772.20', '319.81', '2024-01-01', (SELECT id FROM category WHERE name = 'Facial Cleansing Brush'), random(1, 20)),
            ('4 in 1 Electric Facial Cleansing Brush', 'Includes deep cleansing brush, silicone brush, facial massager, and pointed brush.', 'Unspecified', '73.51', '31.30', '2024-01-01', (SELECT id FROM category WHERE name = 'Facial Cleansing Brush'), random(1, 20)),
            ('Project E Beauty Sensa Nano Ionic Facial Steamer', 'Unclogs pores, detoxifies, and hydrates the skin using nano-ionic steam technology.', 'Project E Beauty', '351.00', '197.10', '2024-01-01', (SELECT id FROM category WHERE name = 'Facial Steamer'), random(1, 20)),
            ('Panasonic EH-SA31 Facial Steamer', 'Utilizes nano-ionic technology for intense skin hydration and deep cleansing.', 'Panasonic', '599.00', '367.50', '2021-02-25', (SELECT id FROM category WHERE name = 'Facial Steamer'), random(1, 20)),
            ('KINGA Nano Ionic Facial Steamer', 'Provides quick steam technology for deep pore cleansing and skin rejuvenation.', 'KINGA', '230.00', '99.41', '2022-10-10', (SELECT id FROM category WHERE name = 'Facial Steamer'), random(1, 20)),
            ('Lonove Facial Steamer', 'Compact home-use steamer designed for effective skin hydration and detoxification.', 'Lonove', '180.00', '81.12', '2021-08-15', (SELECT id FROM category WHERE name = 'Facial Steamer'), random(1, 20)),
            ('Vanity Planet Aira Ionic Facial Steamer', 'Detoxifies and hydrates the skin, promoting a clearer and healthier complexion.', 'Vanity Planet', '320.00', '183.48', '2023-03-30', (SELECT id FROM category WHERE name = 'Facial Steamer'), random(1, 20)),
            ('Project E Beauty LightAura Plus LED Face & Neck Mask', '7-color LED light therapy mask designed for face and neck treatment.', 'Project E Beauty', '878.00', '354.49', '2024-01-01', (SELECT id FROM category WHERE name = 'LED Beauty Device'), random(1, 20)),
            ('Project E Beauty LumaGlow Red & Blue LED Light Therapy Wand', 'Handheld device offering red and blue LED light therapy for anti-aging and acne treatment.', 'Project E Beauty', '659.00', '378.09', '2024-01-01', (SELECT id FROM category WHERE name = 'LED Beauty Device'), random(1, 20)),
            ('Project E Beauty Lumamask Pro LED Light Therapy Face Mask', 'Provides anti-aging benefits with red and infrared light, and anti-acne treatment with blue light.', 'Project E Beauty', '615.00', '288.94', '2024-01-01', (SELECT id FROM category WHERE name = 'LED Beauty Device'), random(1, 20)),
            ('Project E Beauty LightAura Flex LED Face Mask', 'Flexible LED mask targeting fine lines and acne with multiple light settings.', 'Project E Beauty', '1317.00', '699.30', '2024-01-01', (SELECT id FROM category WHERE name = 'LED Beauty Device'), random(1, 20)),
            ('Project E Beauty LumaLux Dome Face & Body LED Light Therapy Device', 'Full-body rejuvenation device featuring 7-color LED and infrared light therapy.', 'Project E Beauty', '2194.00', '1361.89', '2024-01-01', (SELECT id FROM category WHERE name = 'LED Beauty Device'), random(1, 20)),
            ('Philips Lumea Prestige IPL', 'Advanced IPL hair removal', 'Philips', '399.00', '199.50', '2019-05-10', (SELECT id FROM category WHERE name = 'Home-use Hair Removal Device'), random(1, 20)),
            ('Braun Silk-Expert Pro 5', 'IPL technology for smooth skin', 'Braun', '349.00', '174.50', '2020-08-15', (SELECT id FROM category WHERE name = 'Home-use Hair Removal Device'), random(1, 20)),
            ('SmoothSkin Pure IPL Hair Removal', 'Fast & effective hair reduction', 'SmoothSkin', '279.00', '139.50', '2018-07-22', (SELECT id FROM category WHERE name = 'Home-use Hair Removal Device'), random(1, 20)),
            ('Remington iLIGHT Pro Plus Quartz', 'Professional-grade IPL device', 'Remington', '249.00', '124.50', '2017-11-30', (SELECT id FROM category WHERE name = 'Home-use Hair Removal Device'), random(1, 20)),
            ('Tria Beauty Hair Removal Laser 4X', 'FDA-cleared at-home laser device', 'Tria Beauty', '449.00', '224.50', '2021-03-25', (SELECT id FROM category WHERE name = 'Home-use Hair Removal Device'), random(1, 20)),
            ('Gillette Venus Extra Smooth Razor', '5-blade razor with moisture ribbon for a smooth and comfortable shave.', 'Gillette', '19.99', '9.03', '2022-05-14', (SELECT id FROM category WHERE name = 'Razor'), random(1, 20)),
            ('Schick Hydro Silk 5 Razor for Women', 'Hydrating razor infused with serum for a smooth glide.', 'Schick', '25.50', '15.70', '2023-09-18', (SELECT id FROM category WHERE name = 'Razor'), random(1, 20)),
            ('BIC Soleil Sensitive Advanced Disposable Razor', 'Designed for sensitive skin with aloe-enriched lubricating strips.', 'BIC', '15.00', '8.17', '2021-11-20', (SELECT id FROM category WHERE name = 'Razor'), random(1, 20)),
            ('Harry''s Truman Razor with Blade Refills', 'Precision-engineered razor with ergonomic grip and smooth shave technology.', 'Harry''s', '34.99', '22.57', '2024-02-10', (SELECT id FROM category WHERE name = 'Razor'), random(1, 20)),
            ('Dorco Pace 6 Plus Razor', '6-blade razor with lubricating strip for an irritation-free shave.', 'Dorco', '29.99', '17.38', '2023-06-05', (SELECT id FROM category WHERE name = 'Razor'), random(1, 20)),
            ('NuFACE Trinity Facial Toning Device', 'Advanced microcurrent device to lift and tone the face.', 'NuFACE', '199.99', '130.88', '2023-05-12', (SELECT id FROM category WHERE name = 'Face Slimming Device'), random(1, 20)),
            ('FOREO BEAR Microcurrent Facial Toning Device', 'Anti-aging tool that stimulates skin with microcurrents.', 'FOREO', '349.99', '210.31', '2022-10-22', (SELECT id FROM category WHERE name = 'Face Slimming Device'), random(1, 20)),
            ('ZIIP Halo Facial Device', 'Uses nano-current and microcurrent technology to improve skin elasticity.', 'ZIIP', '259.00', '158.81', '2024-01-15', (SELECT id FROM category WHERE name = 'Face Slimming Device'), random(1, 20)),
            ('YAMAN Medi Lift Plus Facial Device', 'Japanese beauty device that targets facial muscles for lifting effect.', 'YAMAN', '189.00', '88.76', '2023-07-08', (SELECT id FROM category WHERE name = 'Face Slimming Device'), random(1, 20)),
            ('CurrentBody Skin LED Face Mask', 'Uses LED light therapy to rejuvenate skin and reduce wrinkles.', 'CurrentBody', '299.00', '169.21', '2023-09-28', (SELECT id FROM category WHERE name = 'Face Slimming Device'), random(1, 20)),
            ('ReFa CARAT Face Roller', 'Platinum-coated, waterproof face roller for skin lifting.', 'ReFa', '45.99', '27.09', '2023-04-05', (SELECT id FROM category WHERE name = 'Roller Massager'), random(1, 20)),
            ('Jillian Dempsey Gold Sculpting Bar', '24k gold vibrating beauty tool for contouring and sculpting.', 'Jillian Dempsey', '39.50', '26.90', '2022-12-10', (SELECT id FROM category WHERE name = 'Roller Massager'), random(1, 20)),
            ('Skin Gym Face Sculptor Beauty Roller', 'Double-ended roller for lymphatic drainage and face lifting.', 'Skin Gym', '59.99', '38.44', '2023-06-25', (SELECT id FROM category WHERE name = 'Roller Massager'), random(1, 20)),
            ('Herbivore Jade De-Puffing Face Roller', 'Traditional jade roller to soothe and massage the skin.', 'Herbivore', '65.00', '39.33', '2023-11-18', (SELECT id FROM category WHERE name = 'Roller Massager'), random(1, 20)),
            ('Mount Lai Rose Quartz Facial Roller', 'Cooling and calming roller made of rose quartz.', 'Mount Lai', '75.00', '38.64', '2024-02-03', (SELECT id FROM category WHERE name = 'Roller Massager'), random(1, 20)),
            ('Herbivore Jade Gua Sha', 'Traditional jade gua sha tool for facial massage and sculpting.', 'Herbivore', '25.99', '12.33', '2023-08-14', (SELECT id FROM category WHERE name = 'Gua Sha Tool'), random(1, 20)),
            ('Mount Lai Rose Quartz Gua Sha Tool', 'Smooth gua sha tool for lifting and firming skin.', 'Mount Lai', '19.99', '13.18', '2022-11-30', (SELECT id FROM category WHERE name = 'Gua Sha Tool'), random(1, 20)),
            ('Skin Gym Bian Stone Gua Sha', 'Special Bian stone tool designed for deeper facial massage.', 'Skin Gym', '35.00', '16.21', '2023-09-12', (SELECT id FROM category WHERE name = 'Gua Sha Tool'), random(1, 20)),
            ('Sacheu Stainless Steel Gua Sha', 'Non-porous, anti-bacterial gua sha made of stainless steel.', 'Sacheu', '28.50', '12.89', '2023-12-05', (SELECT id FROM category WHERE name = 'Gua Sha Tool'), random(1, 20)),
            ('Odacité Crystal Contour Gua Sha', 'Luxurious gua sha tool made from blue sodalite crystal.', 'Odacité', '22.00', '11.63', '2024-01-20', (SELECT id FROM category WHERE name = 'Gua Sha Tool'), random(1, 20)),
            ('OPI Nail Lacquer - Bubble Bath', 'Classic nude pink nail polish with a long-lasting formula.', 'OPI', '9.99', '5.18', '2023-06-15', (SELECT id FROM category WHERE name = 'Nail Polish'), random(1, 20)),
            ('Essie Gel Couture - Sheer Fantasy', 'High-shine gel-like nail polish with no UV lamp needed.', 'Essie', '12.50', '7.29', '2023-09-10', (SELECT id FROM category WHERE name = 'Nail Polish'), random(1, 20)),
            ('Sally Hansen Miracle Gel - Red Eye', 'Long-wear, chip-resistant nail polish with gel finish.', 'Sally Hansen', '15.00', '10.28', '2024-01-05', (SELECT id FROM category WHERE name = 'Nail Polish'), random(1, 20)),
            ('Deborah Lippmann Gel Lab Pro - Naked', 'Healthy gel alternative, enriched with biotin and keratin.', 'Deborah Lippmann', '18.99', '12.68', '2023-12-20', (SELECT id FROM category WHERE name = 'Nail Polish'), random(1, 20)),
            ('Chanel Le Vernis - Ballerina', 'High-quality, chip-resistant nail polish in a luxury formula.', 'Chanel', '22.00', '14.76', '2024-03-02', (SELECT id FROM category WHERE name = 'Nail Polish'), random(1, 20)),
            ('SUNUV SUN2C UV LED Nail Lamp', '48W LED lamp for fast and professional gel curing.', 'SUNUV', '59.99', '25.81', '2023-05-20', (SELECT id FROM category WHERE name = 'Nail Lamp'), random(1, 20)),
            ('MelodySusie UV Nail Lamp 54W', 'High-power LED curing lamp with smart sensors.', 'MelodySusie', '45.00', '22.93', '2023-07-12', (SELECT id FROM category WHERE name = 'Nail Lamp'), random(1, 20)),
            ('Gelish 18G Professional LED Lamp', 'High-end nail lamp with fast and even curing.', 'Gelish', '75.00', '51.75', '2023-08-28', (SELECT id FROM category WHERE name = 'Nail Lamp'), random(1, 20)),
            ('Makartt Professional Nail Lamp 60W', 'Salon-grade nail lamp with adjustable curing time.', 'Makartt', '89.99', '60.12', '2023-10-14', (SELECT id FROM category WHERE name = 'Nail Lamp'), random(1, 20)),
            ('LKE 36W UV LED Nail Lamp', 'Affordable and compact LED nail curing lamp.', 'LKE', '99.99', '41.54', '2024-02-10', (SELECT id FROM category WHERE name = 'Nail Lamp'), random(1, 20)),
            ('Tweezerman Mini Nail Rescue Kit', 'Travel-sized manicure kit with high-quality tools.', 'Tweezerman', '25.99', '17.14', '2023-09-25', (SELECT id FROM category WHERE name = 'Manicure Set'), random(1, 20)),
            ('Revlon Manicure Essentials Set', 'Basic manicure set with nail clippers, file, and buffer.', 'Revlon', '35.50', '24.68', '2023-12-18', (SELECT id FROM category WHERE name = 'Manicure Set'), random(1, 20)),
            ('Three Seven (777) 9-Piece Manicure Kit', 'Stainless steel professional manicure tool set.', 'Three Seven', '45.00', '19.50', '2023-10-07', (SELECT id FROM category WHERE name = 'Manicure Set'), random(1, 20)),
            ('FAMILIFE 11-Piece Manicure Set', 'Premium stainless steel nail care kit with leather case.', 'FAMILIFE', '55.99', '34.03', '2024-01-30', (SELECT id FROM category WHERE name = 'Manicure Set'), random(1, 20)),
            ('Keiby Citom Professional 18-Piece Set', 'Complete nail and grooming set for professional use.', 'Keiby Citom', '65.00', '37.03', '2024-02-15', (SELECT id FROM category WHERE name = 'Manicure Set'), random(1, 20)),
            ('La Roche-Posay Effaclar Duo+', 'Acne treatment gel with niacinamide & salicylic acid.', 'La Roche-Posay', '14.99', '7.13', '2023-06-15', (SELECT id FROM category WHERE name = 'Acne Gel'), random(1, 20)),
            ('Paula’s Choice 2% BHA Gel', 'Salicylic acid-based gel for exfoliating and treating acne.', 'Paula’s Choice', '18.50', '10.00', '2023-08-21', (SELECT id FROM category WHERE name = 'Acne Gel'), random(1, 20)),
            ('Murad Rapid Relief Acne Spot Treatment', 'Fast-acting acne gel with 2% salicylic acid.', 'Murad', '22.00', '12.17', '2023-10-05', (SELECT id FROM category WHERE name = 'Acne Gel'), random(1, 20)),
            ('COSRX AC Collection Acne Patch Gel', 'Calming and repairing gel for inflamed acne.', 'COSRX', '25.99', '14.60', '2023-12-10', (SELECT id FROM category WHERE name = 'Acne Gel'), random(1, 20)),
            ('Drunk Elephant A-Passioni Retinol Gel', 'Retinol-infused gel for acne-prone skin.', 'Drunk Elephant', '30.00', '17.01', '2024-02-05', (SELECT id FROM category WHERE name = 'Acne Gel'), random(1, 20)),
            ('COSRX Acne Pimple Master Patch', 'Hydrocolloid patches for overnight acne healing.', 'COSRX', '8.99', '4.80', '2023-05-20', (SELECT id FROM category WHERE name = 'Pimple Patch'), random(1, 20)),
            ('Hero Mighty Patch Original', 'Thin and effective acne patches for day and night use.', 'Hero Cosmetics', '12.00', '5.01', '2023-07-12', (SELECT id FROM category WHERE name = 'Pimple Patch'), random(1, 20)),
            ('Rael Beauty Miracle Patch', 'Invisible, ultra-thin hydrocolloid patches.', 'Rael Beauty', '15.50', '7.25', '2023-09-28', (SELECT id FROM category WHERE name = 'Pimple Patch'), random(1, 20)),
            ('Nexcare Acne Absorbing Covers', 'Absorbs pus and protects against bacteria.', 'Nexcare', '19.99', '11.51', '2023-11-15', (SELECT id FROM category WHERE name = 'Pimple Patch'), random(1, 20)),
            ('ZitSticka Killa Kit', 'Microdart pimple patches with salicylic acid.', 'ZitSticka', '24.00', '13.91', '2024-01-10', (SELECT id FROM category WHERE name = 'Pimple Patch'), random(1, 20)),
            ('Estée Lauder Advanced Night Repair', 'Anti-aging serum with hyaluronic acid and peptides.', 'Estée Lauder', '35.99', '22.75', '2023-06-10', (SELECT id FROM category WHERE name = 'Anti-wrinkle Serum'), random(1, 20)),
            ('Olay Regenerist Wrinkle Serum', 'Hydrating and firming serum with niacinamide.', 'Olay', '42.50', '19.70', '2023-08-18', (SELECT id FROM category WHERE name = 'Anti-wrinkle Serum'), random(1, 20)),
            ('Lancôme Rénergie H.C.F. Triple Serum', 'Multi-action serum targeting wrinkles, dark spots & volume loss.', 'Lancôme', '50.00', '30.08', '2023-10-02', (SELECT id FROM category WHERE name = 'Anti-wrinkle Serum'), random(1, 20)),
            ('Drunk Elephant A-Shaba Complex', 'Retinol and antioxidant-infused wrinkle-fighting serum.', 'Drunk Elephant', '58.99', '32.25', '2023-12-20', (SELECT id FROM category WHERE name = 'Anti-wrinkle Serum'), random(1, 20)),
            ('Shiseido Benefiance Wrinkle Smoothing Serum', 'Smoothing and anti-aging serum for youthful skin.', 'Shiseido', '65.00', '28.06', '2024-02-14', (SELECT id FROM category WHERE name = 'Anti-wrinkle Serum'), random(1, 20)),
            ('L''Oréal Paris Revitalift Firming Cream', 'Hydrating & firming cream with pro-retinol.', 'L''Oréal Paris', '38.99', '23.95', '2023-07-05', (SELECT id FROM category WHERE name = 'Firming Cream'), random(1, 20)),
            ('Neutrogena Rapid Firming Peptide Cream', 'Peptide-infused cream for skin tightening.', 'Neutrogena', '45.00', '23.94', '2023-09-12', (SELECT id FROM category WHERE name = 'Firming Cream'), random(1, 20)),
            ('StriVectin TL Advanced Tightening Cream', 'Anti-aging firming cream for sagging skin.', 'StriVectin', '55.50', '37.85', '2023-11-28', (SELECT id FROM category WHERE name = 'Firming Cream'), random(1, 20)),
            ('Clarins Extra-Firming Day Cream', 'Anti-wrinkle and skin-firming day moisturizer.', 'Clarins', '63.99', '42.88', '2024-01-08', (SELECT id FROM category WHERE name = 'Firming Cream'), random(1, 20)),
            ('Sisley Supremÿa La Nuit Firming Cream', 'Luxurious anti-aging cream for lifting and firming.', 'Sisley', '75.00', '43.49', '2024-03-05', (SELECT id FROM category WHERE name = 'Firming Cream'), random(1, 20)),
            ('Kiehl’s Clearly Corrective Dark Spot Solution', 'Brightening serum with activated vitamin C.', 'Kiehl’s', '29.99', '18.35', '2023-06-22', (SELECT id FROM category WHERE name = 'Brightening Serum'), random(1, 20)),
            ('Caudalie Vinoperfect Radiance Serum', 'Anti-dark spot brightening serum.', 'Caudalie', '35.50', '19.04', '2023-08-15', (SELECT id FROM category WHERE name = 'Brightening Serum'), random(1, 20)),
            ('Tatcha Violet-C Brightening Serum', 'Vitamin C & AHAs for radiant skin.', 'Tatcha', '45.00', '28.58', '2023-09-30', (SELECT id FROM category WHERE name = 'Brightening Serum'), random(1, 20)),
            ('Drunk Elephant C-Firma Fresh Day Serum', 'Brightening and firming vitamin C serum.', 'Drunk Elephant', '52.99', '35.06', '2023-11-12', (SELECT id FROM category WHERE name = 'Brightening Serum'), random(1, 20)),
            ('Sunday Riley C.E.O. 15% Vitamin C Brightening Serum', 'Anti-aging and brightening serum with vitamin C.', 'Sunday Riley', '60.00', '33.76', '2024-01-20', (SELECT id FROM category WHERE name = 'Brightening Serum'), random(1, 20)),
            ('Murad Rapid Dark Spot Correcting Serum', 'Targets hyperpigmentation and dark spots.', 'Murad', '32.99', '13.29', '2023-07-05', (SELECT id FROM category WHERE name = 'Dark Spot Corrector'), random(1, 20)),
            ('Olay Luminous Tone Perfecting Treatment', 'Brightening formula for even skin tone.', 'Olay', '40.00', '22.64', '2023-09-10', (SELECT id FROM category WHERE name = 'Dark Spot Corrector'), random(1, 20)),
            ('Eucerin Anti-Pigment Dark Spot Corrector', 'Reduces dark spots and prevents reappearance.', 'Eucerin', '48.50', '26.40', '2023-10-28', (SELECT id FROM category WHERE name = 'Dark Spot Corrector'), random(1, 20)),
            ('Clinique Even Better Clinical Radical Dark Spot Corrector', 'Corrects uneven skin tone with CL302 Complex.', 'Clinique', '55.99', '31.03', '2023-12-15', (SELECT id FROM category WHERE name = 'Dark Spot Corrector'), random(1, 20)),
            ('Lancôme Clarifique Pro-Solution', 'Intensive dark spot remover with PHA & niacinamide.', 'Lancôme', '65.00', '45.19', '2024-02-08', (SELECT id FROM category WHERE name = 'Dark Spot Corrector'), random(1, 20)),
            ('La Roche-Posay Cicaplast Baume B5', 'Multi-purpose soothing balm with panthenol.', 'La Roche-Posay', '28.99', '12.71', '2023-06-18', (SELECT id FROM category WHERE name = 'Dark Spot Corrector'), random(1, 20)),
            ('Avene Cicalfate+ Restorative Cream', 'Intensive repair cream for damaged skin.', 'Avene', '34.50', '20.77', '2023-08-02', (SELECT id FROM category WHERE name = 'Dark Spot Corrector'), random(1, 20)),
            ('Bioderma Cicabio Soothing Repair Cream', 'Skin barrier repair cream with copper & zinc.', 'Bioderma', '42.00', '23.83', '2023-09-25', (SELECT id FROM category WHERE name = 'Dark Spot Corrector'), random(1, 20)),
            ('First Aid Beauty Ultra Repair Cream', 'Hydrating & soothing cream for dry skin.', 'First Aid Beauty', '50.99', '23.55', '2023-11-10', (SELECT id FROM category WHERE name = 'Dark Spot Corrector'), random(1, 20)),
            ('Dr. Jart+ Cicapair Tiger Grass Cream', 'Calming cream for redness & sensitive skin.', 'Dr. Jart+', '59.00', '25.98', '2024-01-15', (SELECT id FROM category WHERE name = 'Dark Spot Corrector'), random(1, 20)),
            ('Cetaphil Redness Relieving Night Moisturizer', 'Protects sensitive skin & reduces redness.', 'Cetaphil', '30.99', '12.85', '2023-07-08', (SELECT id FROM category WHERE name = 'Sensitive Skin Protection Cream'), random(1, 20)),
            ('Eucerin Q10 Anti-Wrinkle Face Cream', 'Fragrance-free protection for sensitive skin.', 'Eucerin', '38.00', '18.83', '2023-09-20', (SELECT id FROM category WHERE name = 'Sensitive Skin Protection Cream'), random(1, 20)),
            ('Vanicream Moisturizing Skin Cream', 'Dermatologist-tested for ultra-sensitive skin.', 'Vanicream', '46.50', '29.51', '2023-11-05', (SELECT id FROM category WHERE name = 'Sensitive Skin Protection Cream'), random(1, 20)),
            ('Toleriane Double Repair Face Moisturizer', 'Strengthens & protects sensitive skin barrier.', 'La Roche-Posay', '54.99', '32.44', '2024-01-28', (SELECT id FROM category WHERE name = 'Sensitive Skin Protection Cream'), random(1, 20)),
            ('Clinique Redness Solutions Daily Relief Cream', 'Lightweight cream for skin redness & irritation.', 'Clinique', '63.00', '25.62', '2024-03-10', (SELECT id FROM category WHERE name = 'Sensitive Skin Protection Cream'), random(1, 20)),
            ('LANEIGE Eye Sleeping Mask', 'Hydrating overnight eye mask for puffy eyes.', 'LANEIGE', '25.99', '13.04', '2023-06-10', (SELECT id FROM category WHERE name = 'Eye Mask'), random(1, 20)),
            ('Shiseido Benefiance WrinkleResist24 Eye Mask', 'Anti-aging eye mask with retinol.', 'Shiseido', '32.50', '15.04', '2023-08-05', (SELECT id FROM category WHERE name = 'Eye Mask'), random(1, 20)),
            ('SK-II Signs Eye Mask', 'Intensive hydration & brightening eye mask.', 'SK-II', '39.00', '24.21', '2023-09-18', (SELECT id FROM category WHERE name = 'Eye Mask'), random(1, 20)),
            ('Estee Lauder Advanced Night Repair Eye Mask', 'Rejuvenating & repairing eye mask treatment.', 'Estee Lauder', '45.99', '25.37', '2023-11-02', (SELECT id FROM category WHERE name = 'Eye Mask'), random(1, 20)),
            ('Patchology FlashPatch Rejuvenating Eye Gels', 'Cooling & de-puffing under-eye gel patches.', 'Patchology', '55.00', '29.94', '2024-01-12', (SELECT id FROM category WHERE name = 'Eye Mask'), random(1, 20)),
            ('Kiehl’s Powerful-Strength Line-Reducing Eye Serum', 'Vitamin C-infused eye serum for dark circles.', 'Kiehl’s', '28.99', '14.20', '2023-07-08', (SELECT id FROM category WHERE name = 'Eye Serum'), random(1, 20)),
            ('La Roche-Posay Redermic R Eyes', 'Anti-aging eye serum with retinol.', 'La Roche-Posay', '36.00', '16.94', '2023-09-15', (SELECT id FROM category WHERE name = 'Eye Serum'), random(1, 20)),
            ('Drunk Elephant Shaba Complex Eye Serum', 'Firming & smoothing peptide-rich eye serum.', 'Drunk Elephant', '44.50', '25.12', '2023-10-28', (SELECT id FROM category WHERE name = 'Eye Serum'), random(1, 20)),
            ('Sunday Riley Auto Correct Brightening Eye Cream', 'Brightening & de-puffing eye serum.', 'Sunday Riley', '52.99', '36.62', '2023-12-20', (SELECT id FROM category WHERE name = 'Eye Serum'), random(1, 20)),
            ('Tatcha The Silk Peony Melting Eye Cream', 'Anti-aging & ultra-nourishing eye treatment.', 'Tatcha', '60.00', '31.33', '2024-02-08', (SELECT id FROM category WHERE name = 'Eye Serum'), random(1, 20))
    ON CONFLICT DO NOTHING;

    INSERT INTO product_image_urls(product_id, image_urls)
    VALUES ((SELECT id FROM product WHERE name = 'CeraVe Hydrating Facial Cleanser' AND release_date = '2023-05-10'), 'https://threebs.co/cdn/shop/products/cerave-hydrating-facial-cleanser-562ml-IMG1-20220509.jpg?v=1660118122'),
            ((SELECT id FROM product WHERE name = 'La Roche-Posay Toleriane Purifying Foaming Cleanser' AND release_date = '2023-07-18'), 'https://www.laroche-posay.com.my/-/media/project/loreal/brand-sites/lrp/apac/my/products/toleriane/caring-wash/la-roche-posay-productpage-sensitive-allergic-toleriane-caring-wash-400ml-3337875545778-front.png?cx=0&amp;ch=600&amp;cy=0&amp;cw=600&hash=3342295D7647E9CBC13AE59681C05688'),
            ((SELECT id FROM product WHERE name = 'Fresh Soy Face Cleanser' AND release_date = '2023-09-02'), 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPfex0l05PS7tQlQbFya0IaMOVuRSBhRU6EQ&s'),
            ((SELECT id FROM product WHERE name = 'Kiehl’s Ultra Facial Cleanser' AND release_date = '2023-10-25'), 'https://www.kiehls.com.my/dw/image/v2/BFZM_PRD/on/demandware.static/-/Sites-kiehls-master-catalog/default/dw9ab9a786/nextgen/skin-care/face-cleansers/ultra-facial/ultra-facial-cleanser/kiehls-face-cleanser-ultra-facial-cleanser-150ml-000-3605970024192-front.jpg?sw=320&sh=320&sm=cut&sfrm=png&q=70'),
            ((SELECT id FROM product WHERE name = 'Shiseido Perfect Whip Cleansing Foam' AND release_date = '2023-12-08'), 'https://shop.shiseido.com.my/cdn/shop/files/14529_S_2_1000x.jpg?v=1735660887'),
            ((SELECT id FROM product WHERE name = 'DHC Deep Cleansing Oil' AND release_date = '2023-06-05'), 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcTtATnnxVXeSqFbVS6BWiY-ua9UdLnEnscGdToyj38PyPFyTe8tbAfcvpo5bNQGgnQvXffcV8B3jgZ7285IP72HDUBEESQPlnYCdlmtUE9pFGk61HbgO5hi&usqp=CAE'),
            ((SELECT id FROM product WHERE name = 'Shu Uemura Ultime8∞ Sublime Beauty Cleansing Oil' AND release_date = '2023-08-15'), 'https://www.shuuemura.com.my/www/product-content/botanicoil-indulging-plant-based-cleansing-oil/images/co-pd6.png?v=2'),
            ((SELECT id FROM product WHERE name = 'Kose Softymo Speedy Cleansing Oil' AND release_date = '2023-09-30'), 'https://m.media-amazon.com/images/I/61SwtLoqMSL.jpg'),
            ((SELECT id FROM product WHERE name = 'Tatcha Pure One Step Camellia Cleansing Oil' AND release_date = '2023-11-12'), 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSndf97XePHBohkhoxTBgjg2-wunDi9BW2doQ&s'),
            ((SELECT id FROM product WHERE name = 'Hada Labo Gokujyun Cleansing Oil' AND release_date = '2024-01-05'), 'https://hadalabo.com.my/img/2ab67433-0e27-49c1-bae4-ae833fe37f17/hydrating-oil-lg.png?fm=png&q=80&fit=max&crop=1855%2C2334%2C0%2C0'),
            ((SELECT id FROM product WHERE name = 'Bioderma Sensibio H2O Micellar Water' AND release_date = '2023-05-22'), 'https://medias.watsons.com.my/publishing/WTCMY-75573-side-zoom.jpg?version=1718365981'),
            ((SELECT id FROM product WHERE name = 'Garnier SkinActive Micellar Cleansing Water' AND release_date = '2023-07-10'), 'https://i5.walmartimages.com/seo/Garnier-SkinActive-Micellar-Cleansing-Water-All-in-1-Makeup-Remover-Adult-3-4-fl-oz_03c5f896-f38b-4507-81b8-8066c381e6ff.e54b775e6fc5486f63d965d7021ae3c1.png'),
            ((SELECT id FROM product WHERE name = 'Simple Kind to Skin Micellar Cleansing Water' AND release_date = '2023-09-05'), 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4dVWM7COpjJo_EXZ1BFgQXToRo_Z7n8ZnfQ&s'),
            ((SELECT id FROM product WHERE name = 'La Roche-Posay Micellar Cleansing Water' AND release_date = '2023-10-20'), 'https://www.laroche-posay.us/dw/image/v2/AANG_PRD/on/demandware.static/-/Sites-acd-laroche-posay-master-catalog/default/dw3508f26e/img/micellarwaterultra/toleriane/Toleriane-Micellar-Water_400ml_Front_1500x1500.jpg'),
            ((SELECT id FROM product WHERE name = 'Caudalie Vinoclean Micellar Cleansing Water' AND release_date = '2023-12-02'), 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQO0UjOYlFS0N5AGjAfjOwQbsB0ih6RSdZRlw&s'),
            ((SELECT id FROM product WHERE name = 'Innisfree Jeju Volcanic Pore Cleansing Foam' AND release_date = '2023-06-12'), 'https://www.innisfree.my/media/catalog/product/1/3/131174441_volcanic_bha_pore_cleansing_foam_bm.jpg'),
            ((SELECT id FROM product WHERE name = 'Etude House Baking Powder Pore Cleansing Foam' AND release_date = '2023-08-22'), 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWwhi4A03AkijbM40k0aq_3WwWwHTU2WYpUQ&s'),
            ((SELECT id FROM product WHERE name = 'Sulwhasoo Gentle Cleansing Foam' AND release_date = '2023-09-28'), 'https://my.sulwhasoo.com/cdn/shop/files/Sws_Thumbnail_Gentle-Cleansing-Foam-200ml.jpg?v=1693547619'),
            ((SELECT id FROM product WHERE name = 'Dr. Jart+ Dermaclear Micro Foam' AND release_date = '2023-11-18'), 'https://m.media-amazon.com/images/I/51v-dr9HggL.jpg'),
            ((SELECT id FROM product WHERE name = 'AmorePacific Treatment Cleansing Foam' AND release_date = '2024-01-10'), 'https://m.media-amazon.com/images/I/51yi0T3cdYL.jpg'),
            ((SELECT id FROM product WHERE name = 'Thayers Witch Hazel Toner' AND release_date = '2023-05-15'), 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzArrYT5g91rhbcw1CgaEFBCqwpK6ZumY09g&s'),
            ((SELECT id FROM product WHERE name = 'Kiehl’s Calendula Herbal Extract Toner' AND release_date = '2023-07-03'), 'https://www.kiehls.com.my/dw/image/v2/BFZM_PRD/on/demandware.static/-/Sites-kiehls-master-catalog/default/dw1ec19660/nextgen/skin-care/face-toners/calendula/calendula-herbal-extract-alcohol-free-toner/kiehls-toner-calendula-herbal-extract-toner-alcohol-free-125ml-000-3700194700324-front.png'),
            ((SELECT id FROM product WHERE name = 'SK-II Facial Treatment Clear Lotion' AND release_date = '2023-08-21'), 'https://www.sogo.com.my/cdn/shop/files/SK-IIFacialTreatmentClearLotion160ml.jpg?v=1727247037'),
            ((SELECT id FROM product WHERE name = 'La Roche-Posay Effaclar Clarifying Solution' AND release_date = '2023-10-07'), 'https://down-my.img.susercontent.com/file/9db5556f3acc5c0992ed9988fc0a2fac'),
            ((SELECT id FROM product WHERE name = 'Pixi Glow Tonic' AND release_date = '2023-12-01'), 'https://www.pixibeauty.com/cdn/shop/products/GlowTonic-250ml-MAY19_5.jpg?v=1701458044&width=1200'),
            ((SELECT id FROM product WHERE name = 'Evian Facial Spray' AND release_date = '2023-05-28'), 'https://medias.watsons.com.my/publishing/WTCMY-71363-side-zoom.jpg?version=1718382695'),
            ((SELECT id FROM product WHERE name = 'Caudalie Grape Water Mist' AND release_date = '2023-07-12'), 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ73kBhOGQAUFSNiF4535SAQvj9m4UnxM8gOA&s'),
            ((SELECT id FROM product WHERE name = 'Heritage Store Rosewater & Glycerin Spray' AND release_date = '2023-09-10'), 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVNHKmfCnSj9VyB_5UvwbehBu-K8aht6E36Q&s'),
            ((SELECT id FROM product WHERE name = 'Mario Badescu Facial Spray' AND release_date = '2023-10-29'), 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQi3Fz5_XMRRnh19vUPn-hg7s724__VY5Kxig&s'),
            ((SELECT id FROM product WHERE name = 'Tatcha Luminous Dewy Skin Mist' AND release_date = '2023-12-15'), 'https://m.media-amazon.com/images/I/41RrWLchujL._SL1500_.jpg'),
            ((SELECT id FROM product WHERE name = 'SK-II Facial Treatment Essence' AND release_date = '2023-06-10'), 'https://www.sogo.com.my/cdn/shop/files/SK-IIFacialTreatmentEssence160ml.jpg?v=1727247195'),
            ((SELECT id FROM product WHERE name = 'Missha Time Revolution First Treatment Essence' AND release_date = '2023-08-05'), 'https://my.althea.kr/cdn/shop/products/TimeRevolutionTheFirstTreatmentEssenceRx_150ml_Renewal.jpg?v=1682148006'),
            ((SELECT id FROM product WHERE name = 'IOPE Bio Essence Intensive Conditioning' AND release_date = '2023-09-22'), 'https://www.iope.com/int/en/products/__icsFiles/afieldfile/2020/09/08/bio-thum1.png'),
            ((SELECT id FROM product WHERE name = 'Sulwhasoo First Care Activating Serum' AND release_date = '2023-11-10'), 'https://my.sulwhasoo.com/cdn/shop/files/First_Care_Activating_Serum_VI_90ml.jpg?v=1740760356'),
            ((SELECT id FROM product WHERE name = 'Laneige Water Bank Hydro Essence' AND release_date = '2024-01-05'), 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKfXhVybexpdtPHdwDIp0PQlaxLclgdLI5_Q&s'),
            ((SELECT id FROM product WHERE name = 'CeraVe Daily Moisturizing Lotion' AND release_date = '2023-05-20'), 'https://www.cerave.com/-/media/project/loreal/brand-sites/cerave/americas/us/products-v3/daily-moisturizing-lotion/700x875/cerave_daily_moisturizing_lotion_12oz_front-700x875-v2.jpg?rev=c1f482b619984b46bd02512590f52dfc&w=900&hash=1CE688C6849CD2E3CA7FEFB78E0AE598'),
            ((SELECT id FROM product WHERE name = 'Aveeno Daily Moisturizing Lotion' AND release_date = '2023-07-08'), 'https://images.ctfassets.net/mgaihfszrtka/6GjNQY9eM192bralFU0IS2/33278f6def11d747e2d5281550a632de/ave_381370038443_us_daily_moisturizing_lotion_18oz_00000_0-en-us'),
            ((SELECT id FROM product WHERE name = 'Eucerin Advanced Repair Lotion' AND release_date = '2023-09-02'), 'https://down-my.img.susercontent.com/file/6f722cb087e395f4a95492c9efae6a08'),
            ((SELECT id FROM product WHERE name = 'NIVEA Essentially Enriched Lotion' AND release_date = '2023-10-18'), 'https://m.media-amazon.com/images/I/61qouR91jpL._AC_UF1000,1000_QL80_.jpg'),
            ((SELECT id FROM product WHERE name = 'Vaseline Intensive Care Lotion' AND release_date = '2023-12-10'), 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlM8_Q7vTD4wPXF-PXQjm21mKPtb692wWL2Q&s'),
            ((SELECT id FROM product WHERE name = 'Kiehl’s Ultra Facial Cream' AND release_date = '2023-05-30'), 'https://www.kiehls.com.my/dw/image/v2/BFZM_PRD/on/demandware.static/-/Sites-kiehls-master-catalog/en_MY/dw478f7e21/new-packshot/622-3605970360757-50ml-IMAGE1.jpg?sw=320&sh=320&sm=cut&sfrm=png&q=70'),
            ((SELECT id FROM product WHERE name = 'La Mer Crème de la Mer' AND release_date = '2023-07-15'), 'https://m.lamer.com.my/media/images/products/680x680/LM_SKU_332002_26766_680x680_0.png'),
            ((SELECT id FROM product WHERE name = 'Drunk Elephant Lala Retro Whipped Cream' AND release_date = '2023-09-12'), 'https://drunkelephant.my/cdn/shop/products/Lala-Retro_1024px_72dpi.jpg?v=1604010986'),
            ((SELECT id FROM product WHERE name = 'Olay Regenerist Micro-Sculpting Cream' AND release_date = '2023-10-25'), 'https://m.media-amazon.com/images/I/71-55TGAWNL.jpg'),
            ((SELECT id FROM product WHERE name = 'Tatcha The Dewy Skin Cream' AND release_date = '2023-12-18'), 'https://m.media-amazon.com/images/I/51RFfDtchYL._AC_UF1000,1000_QL80_.jpg'),
            ((SELECT id FROM product WHERE name = 'Neutrogena Hydro Boost Water Gel' AND release_date = '2023-06-10'), 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTV2xp6G_7FhJ6sjmSDtWGFL9IGJsRkCIFzbg&s'),
            ((SELECT id FROM product WHERE name = 'Belif The True Cream Aqua Bomb' AND release_date = '2023-08-02'), 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXLDkiNpvfTFKSckZ6VwzyKCm-jB_tS0hang&s'),
            ((SELECT id FROM product WHERE name = 'Clinique Moisture Surge 100H' AND release_date = '2023-09-20'), 'https://m.clinique.com.my/media/export/cms/products/1200x1500/cl_sku_KWW401_1200x1500_0.png'),
            ((SELECT id FROM product WHERE name = 'Laneige Water Bank Blue Hyaluronic Gel' AND release_date = '2023-11-15'), 'https://www.laneige.com/int/en/skincare/__icsFiles/afieldfile/2023/12/20/20230100_final_INT_WATER-BANK-BLUE-HYALURONIC-GEL-CREAM_thumbnail01_2.jpg'),
            ((SELECT id FROM product WHERE name = 'Dr.Jart+ Cicapair Tiger Grass Gel Cream' AND release_date = '2024-01-05'), 'https://down-my.img.susercontent.com/file/3d4d90f8da2348e1af8aff11887981e4'),
            ((SELECT id FROM product WHERE name = 'Ole Henriksen Truth Serum' AND release_date = '2023-05-20'), 'https://down-my.img.susercontent.com/file/my-11134207-7rasc-m176fcp9t9pdf1'),
            ((SELECT id FROM product WHERE name = 'Skinceuticals C E Ferulic' AND release_date = '2023-07-08'), 'https://www.skinceuticals.co.uk/dw/image/v2/AAQP_PRD/on/demandware.static/-/Sites-skc-master-catalog/default/dw0ed123c8/Products/635494363210/635494363210_C-E-Ferulic-30ml_SkinCeuticals.jpg'),
            ((SELECT id FROM product WHERE name = 'Glow Recipe Pineapple-C Bright Serum' AND release_date = '2023-09-02'), 'https://m.media-amazon.com/images/I/51C0VXdzsNL._AC_UF1000,1000_QL80_.jpg'),
            ((SELECT id FROM product WHERE name = 'Tatcha Violet-C Brightening Serum' AND release_date = '2023-10-12'), 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTu_QWYYn9izDM5ToZs5-KtqioXGKljbF-hkQ&s'),
            ((SELECT id FROM product WHERE name = 'Drunk Elephant C-Firma Fresh Day Serum' AND release_date = '2023-11-25'), 'https://drunkelephant.my/cdn/shop/products/C-Firma_Fresh_30ml_Standards_01_1080px_72dpi_1024x1024.jpg?v=1641834349'),
            ((SELECT id FROM product WHERE name = 'Estée Lauder Advanced Night Repair' AND release_date = '2023-05-30'), 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSi_9D33pEzCDEEL-WX3HbchaCzMx8KruiyuQ&s'),
            ((SELECT id FROM product WHERE name = 'Lancôme Génifique Youth Activating Serum' AND release_date = '2023-07-15'), 'https://www.lancome.com.my/dw/image/v2/BFZM_PRD/on/demandware.static/-/Sites-lancome-ng-master-catalog/en_MY/dw63f35018/images/PACKSHOTS/SKINCARE/Genifique/00997-LAC_genifique-ultimate-serum/3614274142365_genifique-ultimate-serum_30ml_main.jpg'),
            ((SELECT id FROM product WHERE name = 'Drunk Elephant A-Passioni Retinol Cream' AND release_date = '2023-09-12'), 'https://drunkelephant.my/cdn/shop/products/1_A-Passioni_PDPAsset_Standard_1024x1024.jpg?v=1679496262'),
            ((SELECT id FROM product WHERE name = 'Sunday Riley Luna Retinol Sleeping Night Oil' AND release_date = '2023-10-20'), 'https://sundayriley.com/cdn/shop/files/FINAL_luna_ingredients_037_2000x2000_b9c39952-7563-4671-92a0-7f10efcfb514.jpg?v=1613719688&width=1500'),
            ((SELECT id FROM product WHERE name = 'Murad Retinol Youth Renewal Serum' AND release_date = '2023-12-01'), 'https://www.murad.com.my/cdn/shop/files/RYRS_Carousel_1_MURAD.webp?v=1728871623'),
            ((SELECT id FROM product WHERE name = 'Kiehl''s Midnight Recovery Concentrate' AND release_date = '2023-06-10'), 'https://www.kiehls.com.my/dw/image/v2/BFZM_PRD/on/demandware.static/-/Sites-kiehls-master-catalog/default/dwc94fd6fb/nextgen/skin-care/face-serums-and-oils/midnight-recovery/midnight-recovery-concentrate/kiehls-face-serum-midnight-recovery-concentrate-15ml-000-3605970926137-front.png'),
            ((SELECT id FROM product WHERE name = 'La Roche-Posay Cicaplast B5 Serum' AND release_date = '2023-08-02'), 'https://www.laroche-posay.com.my/-/media/project/loreal/brand-sites/lrp/apac/my/products/cicaplast/cicaplast-b5-serum/lrpcicaplastbaumeb530ml3337875837804front-2.png'),
            ((SELECT id FROM product WHERE name = 'Clarins Double Serum' AND release_date = '2023-09-20'), 'https://my.ozcosmetics.com/syimages/201709/214956.jpg'),
            ((SELECT id FROM product WHERE name = 'The Ordinary Buffet + Copper Peptides 1%' AND release_date = '2023-10-15'), 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkBCZ1timgD__njCWf8LcRsU5fIJwLgpzDjg&s'),
            ((SELECT id FROM product WHERE name = 'First Aid Beauty Ultra Repair Hydrating Serum' AND release_date = '2023-11-30'), 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKfuXHIXzW7RvFly2rQx_IhRKyFrmiJHTeFw&s'),
            ((SELECT id FROM product WHERE name = 'Kiehl''s Creamy Eye Treatment with Avocado' AND release_date = '2023-06-15'), 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZMXdLjWl7gE-a98fN-e0pxEFmhvamNNIlWA&s'),
            ((SELECT id FROM product WHERE name = 'Estée Lauder Advanced Night Repair Eye Supercharged Gel-Creme' AND release_date = '2023-08-05'), 'https://m.esteelauder.com.my/media/export/cms/products/420x578/el_sku_PYL501_420x578_0.jpg'),
            ((SELECT id FROM product WHERE name = 'CeraVe Eye Repair Cream' AND release_date = '2023-09-10'), 'https://www.cerave.com/-/media/project/loreal/brand-sites/cerave/americas/us/products-v3/eye-repair-cream/700x875/cerave_eye_repair_cream_05oz_front-700x875-v2.jpg?rev=c9bbdf22506e4bf99cdff6c39465081c'),
            ((SELECT id FROM product WHERE name = 'La Mer The Eye Concentrate' AND release_date = '2023-10-22'), 'https://media-neo.dfsglobal.cn/spu/SPU_1498322940054347776_1_en_50.jpeg'),
            ((SELECT id FROM product WHERE name = 'Clinique All About Eyes' AND release_date = '2023-11-30'), 'https://m.clinique.com.my/media/export/cms/products/1200x1500/cl_sku_61EP01_1200x1500_0.png'),
            ((SELECT id FROM product WHERE name = 'Shiseido Ultimune Eye Power Infusing Eye Concentrate' AND release_date = '2023-07-01'), 'https://www.shiseido.com.my/on/demandware.static/-/Sites-itemmaster_shiseido/default/dw68a7981c/images/products/17289/17289_S_01.jpg'),
            ((SELECT id FROM product WHERE name = 'Lancôme Advanced Génifique Yeux Light-Pearl Eye Serum' AND release_date = '2023-08-20'), 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPMhzETopB1BkdjfxQaAMYzDGe2ZSQAE75Tw&s'),
            ((SELECT id FROM product WHERE name = 'The Ordinary Caffeine Solution 5% + EGCG' AND release_date = '2023-09-15'), 'https://theordinary.com/dw/image/v2/BFKJ_PRD/on/demandware.static/-/Sites-deciem-master/default/dwd2b40942/Images/products/The%20Ordinary/rdn-caffeine-solution-5pct-egcg-30ml.png?sw=900&sh=900&sm=fit'),
            ((SELECT id FROM product WHERE name = 'Tatcha The Silk Peony Melting Eye Cream' AND release_date = '2023-10-28'), 'https://media.ulta.com/i/ulta/2634181?w=1600&h=1600&fmt=auto'),
            ((SELECT id FROM product WHERE name = 'Drunk Elephant Shaba Complex Firming Eye Serum' AND release_date = '2023-12-05'), 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLkiZrl9wvVeC-6ZP_On8YQxlsoteF52hwKg&s'),
            ((SELECT id FROM product WHERE name = 'SunShield Ultra Sunscreen SPF 50' AND release_date = '2023-05-10'), 'https://m.media-amazon.com/images/I/61OCZdrIjWL.jpg'),
            ((SELECT id FROM product WHERE name = 'Mamaearth Vitamin C Daily Glow Sunscreen for Sun Protection & Glow' AND release_date = '2023-06-15'), 'https://www.mamaearth.my/cdn/shop/files/80g_b1a1c0b7-4116-4aa5-8bff-b4c9960d1c95.jpg?v=1721034900'),
            ((SELECT id FROM product WHERE name = 'AquaGlow Moisturizing Sunscreen SPF 55' AND release_date = '2023-07-05'), 'https://images.mamaearth.in/catalog/product/1/_/1_white_bg_57.jpg?format=auto&height=600'),
            ((SELECT id FROM product WHERE name = 'DermaCare Advanced Sunscreen SPF 60' AND release_date = '2023-08-12'), 'https://images.thedermaco.com/promotional/faq-image/Ultra%20Matte%20Sunscreen%20Gel.jpg'),
            ((SELECT id FROM product WHERE name = 'Neutrogena® Purescreen+™ Mineral UV Tint Face Liquid Sunscreen' AND release_date = '2023-09-20'), 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGkNVY9HG9GPvezTCjIqM8MgOB-2Tywonp3A&s');
END;
$BODY$
    LANGUAGE plpgsql;