
---------------C�u 36.	T�nh t?ng s? l??ng c?a t?ng s?n ph?m b�n ra trong th�ng 10/2006.
SELECT MASP, COUNT(DISTINCT MASP) AS TONGSO
FROM SANPHAM
WHERE MASP IN(SELECT MASP
FROM CTHD C INNER JOIN HOADON H
ON C.SOHD = H.SOHD
WHERE MONTH(NGHD) = 10 AND YEAR(NGHD) = 2006)
GROUP BY MASP
--------------C�u 37.	T�nh doanh thu b�n h�ng c?a t?ng th�ng trong n?m 2006.
SELECT MONTH(NGHD) AS THANG, SUM(TRIGIA) AS DOANHTHU
FROM HOADON
WHERE YEAR(NGHD) = 2006
GROUP BY MONTH(NGHD)
---------------C�u 38.	T�m h�a ??n c� mua �t nh?t 4 s?n ph?m kh�c nhau.
SELECT *
FROM HOADON
WHERE SOHD IN(SELECT SOHD
FROM CTHD
WHERE SL >= 4)
-------------C�u 39.	T�m h�a ??n c� mua 3 s?n ph?m do �Viet Nam� s?n xu?t (3 s?n ph?m kh�c nhau).
SELECT *
FROM HOADON
WHERE SOHD IN(SELECT SOHD
FROM CTHD C INNER JOIN SANPHAM S
ON C.MASP = S.MASP
WHERE NUOCSX = 'Viet Nam' AND SL >= 3)
-------------C�u 40.	T�m kh�ch h�ng (MAKH, HOTEN) c� s? l?n mua h�ng nhi?u nh?t.
SELECT MAKH, HOTEN
FROM KHACHHANG
WHERE MAKH = (SELECT TOP 1 MAKH
FROM HOADON
GROUP BY MAKH
ORDER BY COUNT(DISTINCT SOHD) DESC)
-------------C�u 41.	Th�ng m?y trong n?m 2006, doanh s? b�n h�ng cao nh?t ?
SELECT TOP 1 MONTH(NGHD) AS THANG_DOANHSO_MAX
FROM HOADON
WHERE YEAR(NGHD) = 2006
GROUP BY MONTH(NGHD)
ORDER BY SUM(TRIGIA) DESC
--------------C�u 42.	T�m s?n ph?m (MASP, TENSP) c� t?ng s? l??ng b�n ra th?p nh?t trong n?m 2006.
SELECT MASP, TENSP
FROM SANPHAM
WHERE MASP = (SELECT TOP 1 MASP
FROM CTHD
GROUP BY MASP
ORDER BY SUM(SL) DESC)
-------------C�u 43.	M?i n??c s?n xu?t, t�m s?n ph?m (MASP,TENSP) c� gi� b�n cao nh?t.

SELECT B.NUOCSX, MASP, TENSP
FROM (SELECT NUOCSX, MAX(GIA) AS MAX
FROM SANPHAM
GROUP BY NUOCSX) AS B LEFT JOIN SANPHAM S 
ON S.GIA = B.MAX 
WHERE B.NUOCSX = S.NUOCSX

----------C�u 44.	T�m n??c s?n xu?t s?n xu?t �t nh?t 3 s?n ph?m c� gi� b�n kh�c nhau.
SELECT sp.NUOCSX
FROM SANPHAM sp
GROUP BY sp.NUOCSX
HAVING count(distinct sp.GIA)>=3
----------C�u 45.	*Trong 10 kh�ch h�ng c� doanh s? cao nh?t, t�m kh�ch h�ng c� s? l?n mua h�ng nhi?u nh?t.
SELECT MAKH, COUNT(SOHD)
FROM HOADON
GROUP BY MAKH
