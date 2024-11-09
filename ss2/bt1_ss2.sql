create database bt1ss2;
CREATE TABLE phieu_xuat (
    so_px INT PRIMARY KEY,
    ngay_xuat DATE
);

CREATE TABLE vat_tu (
    ma_vtu INT PRIMARY KEY,
    ten_vtu VARCHAR(100),
    dg_nhap DECIMAL(10,2),
    sl_nhap INT
);

CREATE TABLE phieu_nhap (
    so_pn INT PRIMARY KEY,
    ngay_nhap DATE
);

CREATE TABLE don_dh (
    so_dh INT PRIMARY KEY,
    ngay_dh DATE
);

CREATE TABLE nha_cc (
    ma_ncc INT PRIMARY KEY,
    ten_ncc VARCHAR(100),
    dia_chi VARCHAR(200),
    sdt VARCHAR(20)
);

CREATE TABLE chi_tiet (
    id INT PRIMARY KEY,
    so_px INT,
    ma_vtu INT,
    so_pn INT,
    so_dh INT,
    ma_ncc INT,
    dg_xuat DECIMAL(10 , 2 ),
    sl_xuat INT,
    FOREIGN KEY (so_px)
        REFERENCES phieu_xuat (so_px),
    FOREIGN KEY (ma_vtu)
        REFERENCES vat_tu (ma_vtu),
    FOREIGN KEY (so_pn)
        REFERENCES phieu_nhap (so_pn),
    FOREIGN KEY (so_dh)
        REFERENCES don_dh (so_dh),
    FOREIGN KEY (ma_ncc)
        REFERENCES nha_cc (ma_ncc)
);
