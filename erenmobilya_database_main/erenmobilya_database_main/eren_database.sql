CREATE DATABASE eren_mobilya;
use eren_mobilya;

CREATE TABLE eren_musteriler
(
    musteri_id      varchar(64)     not null,
    musteri_ad      varchar(64)     not null,
    musteri_soyad   varchar(64)     not null,
    musteri_tel     varchar(25)     not null,
    musteri_mail    varchar(250)    not null,
    musteri_adres   varchar(250)    not null,
    
    primary key(musteri_id)
);

CREATE TABLE eren_urunler
(
    urun_id         varchar(64)     not null,
    urun_ad         varchar(250)    not null,
    urun_kategori   varchar(250)    not null,
    urun_fiyat      float           not null,
    urun_stok       float           not null,
    urun_birim      varchar(16)     not null,
    urun_detay      varchar(250)    not null,
    
    primary key(urun_id)
);

CREATE TABLE eren_satislar
(
    satis_id        varchar(64)     not null,
    musteri_id      varchar(64)     not null,
    urun_id         varchar(64)     not null,    
    satis_tarih     datetime        not null,
    satis_fiyat     float           not null,
    
    primary key(satis_id),
   
    foreign key(musteri_id) references eren_musteriler(musteri_id)
        on delete cascade on update cascade,
        
    foreign key(urun_id)    references eren_urunler(urun_id)
        on delete cascade on update cascade                         
);

CREATE TABLE eren_odemeler
(
    odeme_id        varchar(64)     not null,
    musteri_id      varchar(64)     not null,    
    odeme_tarih     datetime        not null,
    odeme_tutar     float           not null,    
    odeme_tur       varchar(25)     not null,    
    odeme_aciklama  varchar(250)    not null,
    
   primary key(odeme_id),
   
   foreign key(musteri_id)  references eren_musteriler(musteri_id)
        on delete cascade on update cascade
);


