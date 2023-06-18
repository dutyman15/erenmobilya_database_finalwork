
DELIMITER $$
CREATE PROCEDURE eren_MusteriEkle (
    id varchar(64),
    ad varchar(64),
    soyad varchar(64),
    tel varchar(25),
    mail varchar(250),
    adr varchar(250)
)
BEGIN
    INSERT INTO eren_mobilya
    VALUES (id, ad, soyad, tel, mail, adr);
END $$
DELIMITER ; 

DELIMITER ; 
DELIMITER $$ 
CREATE PROCEDURE eren_MusterilerHepsi () 
BEGIN 
	SELECT 
		musteri_id as ID, 
		musteri_ad as Adı, 
		musteri_soyad as Soyadı, 
		musteri_tel as Telefon, 
		musteri_mail as Mail, 
		musteri_adres as Adres 
		FROM altin_musteriler; 
END $$ 
DELIMITER ;


DELIMITER $$ 
CREATE PROCEDURE eren_MusteriBul ( 
	filtre varchar(32) 
) 
BEGIN 
	SELECT 
		musteri_id as ID, 
		musteri_ad as Adı, 
		musteri_soyad as Soyadı, 
		musteri_tel as Telefon, 
		musteri_mail as Mail,
		musteri_adres as Adres 
		FROM eren_musteriler 
		WHERE musteri_ad LIKE CONCAT('%',filtre,'%') OR 
		musteri_soyad LIKE CONCAT('%',filtre,'%') OR 
		musteri_tel LIKE CONCAT('%',filtre,'%') OR 
		musteri_mail LIKE CONCAT('%',filtre,'%') OR 
		musteri_adres LIKE CONCAT('%',filtre,'%');
END $$ 
DELIMITER ;

DELIMITER $$ 
CREATE PROCEDURE eren_MusteriGuncelle ( 
id varchar(64) , 
ad varchar(64) , 
soy varchar(64) , 
tel varchar(25) ,
 mail varchar(250), 
 adr varchar(250) 
 ) 
 BEGIN 
 UPDATE eren_musteriler 
 SET 
 musteri_ad = ad, 
 musteri_soyad = soy, 
 musteri_tel = tel, 
 musteri_mail = mail, 
 musteri_adres = adr 
 WHERE 
 musteri_id = id; 
 END $$ 
 DELIMITER ;

DELIMITER $$ 
CREATE PROCEDURE eren_MusteriSil ( 
id varchar(64) 
) 
BEGIN 
DELETE FROM eren_musteriler 
WHERE musteri_id = id; 
END $$ 
DELIMITER ;

DELIMITER $$ 
CREATE PROCEDURE eren_UrunEkle ( 
id varchar(64) , 
ad varchar(250) , 
kategori varchar(250) , 
fiyat float , 
stok float , 
birim varchar(16) , 
detay varchar(250) 
) 
BEGIN 
INSERT INTO eren_urunler 
VALUES (id, ad, kategori, fiyat, stok, birim, detay); 
END $$ 
DELIMITER ;


DELIMITER $$ 
CREATE PROCEDURE altin_UrunlerHepsi () 
BEGIN 
SELECT 
urun_id as ID, 
urun_ad as 'Ürün Adı' , 
urun_kategori as Kategori, 
urun_fiyat as Fiyat, 
urun_stok as 'Stok Miktarı', 
urun_birim as 'Birim Fiyat', 
urun_detay as 'Detay' 
FROM altin_urunler; 
END $$ 
DELIMITER ;

DELIMITER $$ 
CREATE PROCEDURE eren_UrunGuncelle ( 
id varchar(64) , 
ad varchar(250) , 
kategori varchar(250) , 
fiyat float , 
stok float , 
birim varchar(16) , 
detay varchar(250) 
) 
BEGIN 
UPDATE eren_urunler 
SET 
urun_ad = ad, 
urun_kategori = kategori, 
urun_fiyat = fiyat, 
urun_stok = stok, 
urun_birim = birim, 
urun_detay = detay 
WHERE 
urun_id = id; 
END $$ 
DELIMITER ;


DELIMITER $$ 	
CREATE PROCEDURE eren_UrunSil (
 id varchar(64) 
 ) 
 BEGIN 
 DELETE FROM eren_urunler
 WHERE urun_id = id; 
 END $$ 
 DELIMITER ;
 
 DELIMITER $$ 
 CREATE PROCEDURE eren_SatisEkle ( 
 sid varchar(64) , 
 mid varchar(64) , 
 uid varchar(64) , 
 tarih datetime , 
 fiyat float 
 ) 
 BEGIN INSERT INTO eren_satislar
 VALUES (sid, mid, uid, tarih, fiyat);
 END $$ 
 DELIMITER ;
 
 
 SELECT 
 s.satis_id,
 m.musteri_id, 
 u.urun_id, 
 CONCAT(musteri_ad, ' ' , musteri_soyad) as 'Müşteri', 
 urun_ad as 'Ürün', 
 urun_kategori as 'Kategori', 
 urun_fiyat as 'Birim Fiyat', 
 satis_fiyat as 'Satış Fiyatı' 
 FROM eren_musteriler m inner join eren_satislar s 
 on m.musteri_id = s.musteri_id 
 inner join eren_urunler u on u.urun_id;
 
 DELIMITER $$ 
 CREATE PROCEDURE eren_SatisGuncelle ( 
 sid varchar(64), 
 mid varchar(64), 
 uid varchar(64), 
 tarih datetime , 
 fiyat float 
 ) 
 BEGIN
 UPDATE eren_satislar
 SET 
 musteri_id = mid, 
 urun_id = uid, 
 satis_tarih = tarih, 
 satis_fiyat = fiyat 
 WHERE 
 satis_id = sid;
 END $$ 
 DELIMITER ;
 
 DELIMITER $$ 
 CREATE PROCEDURE eren_SatisSil ( 
 id varchar(64) 
 ) 
 BEGIN 
 DELETE FROM eren_satislar 
 WHERE satis_id = id; 
 END $$ 
 DELIMITER ;
 
 
 DELIMITER $$ 
 CREATE PROCEDURE eren_OdemeEkle ( 
 oid varchar(64) , 
 mid varchar(64) , 
 tarih datetime , 
 tutar float , 
 tur varchar(25) , 
 aciklama varchar(250) 
 ) 
 BEGIN INSERT INTO eren_odemeler 
 VALUES (oid, mid, tarih, tutar, tur, aciklama); 
 END $$ 
 DELIMITER ;
 
 DELIMITER $$ 
 CREATE PROCEDURE eren_OdemeDetay ( 
 ) 
 BEGIN 
 SELECT 
 o.odeme_id, 
 m.musteri_id, 
 CONCAT(musteri_ad, ' ', musteri_soyad) as 'Müşteri Ad Soyad', 
 o.odeme_tarih as 'Ödeme Tarihi', 
 o.odeme_tutar as 'Ödeme Tutarı', 
 o.odeme_tur as 'Ödeme Türü',
 o.odeme_aciklama as 'Ödeme Açıklama' 
 FROM eren_musteriler m inner join eren_odemeler o 
 on m.musteri_id = o.musteri_id; 
 END $$
 DELIMITER ;
 
 DELIMITER $$ 
 CREATE PROCEDURE eren_OdemeGuncelle ( 
 oid varchar(64) , 
 mid varchar(64) , 
 tarih datetime , 
 tutar float , 
 tur varchar(25) , 
 aciklama varchar(250) 
 ) 
 BEGIN 
 UPDATE eren_odemeler 
 SET 
 musteri_id = mid, 
 odeme_tarih = tarih, 
 odeme_tutar = tutar, 
 odeme_tur = tur, 
 odeme_aciklama = aciklama 
 WHERE 
 odeme_id = oid; 
 END $$ 
 DELIMITER ;
 
 DELIMITER $$ 
 CREATE PROCEDURE eren_OdemeSil ( 
 oid varchar(64) 
 ) 
 BEGIN 
 DELETE FROM eren_odemeler 
 WHERE odeme_id = oid; 
 END $$ 
 DELIMITER ;
 
 
 
 
 
 
 
 
 
 
 























